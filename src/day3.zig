const std = @import("std");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub fn countItems(data: []const u8) !u64 {
    // split by rucksack
    var rucksacks = std.mem.split(u8, data, "\n");
    var total: u64 = 0;
    while (rucksacks.next()) |rucksack| {
        var left = rucksack[0..(rucksack.len / 2 - 1)];
        var right = rucksack[(rucksack.len / 2)..];

        var counted_items = std.AutoHashMap(u8, u8).init(gpa.allocator());

        // populate hash map with values
        for (left) |item| {
            try counted_items.put(item, 1);
        }

        total += for (right) |item| {
            if (counted_items.contains(item)) {
                break try charToPriority(item);
            }
        } else 0;
    }
    return total;
}

const AlphaError = error{OutOfBounds};

fn charToPriority(char: u8) AlphaError!u8 {
    if (char >= 'a' and char <= 'z') {
        return char - 'a' + 1;
    } else if (char >= 'A' and char <= 'Z') {
        return char - 'A' + 27;
    } else {
        return AlphaError.OutOfBounds;
    }
}

test "Two Compartments" {
    const common = @import("common.zig");

    const data = try common.readInData("data/day3.txt");
    const total = try countItems(data);

    try std.testing.expectEqual(total, 157);
}
