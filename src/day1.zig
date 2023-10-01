const std = @import("std");
const common = @import("common.zig");

pub fn findMax(data: []u8) u64 {
    //split by line and accumulate grouped numbers
    var split_data = std.mem.splitSequence(u8, data, "\n");

    // holding current max and count
    var current_elf_count: u64 = 0;
    var current_max: u64 = 0;

    while (split_data.next()) |item| {
        // using 0 as a flag to stop accumulating on this elf
        const number = std.fmt.parseUnsigned(u64, item, 10) catch 0;

        if (number > 0) {
            // add to total
            current_elf_count += number;
        } else if (current_elf_count > current_max) {
            // check if we have the new max and replace
            current_max = current_elf_count;
            current_elf_count = 0;
        }
    }
    return current_max;
}

test "Day One" {
    const data = try common.readInData("data/day1.txt");
    const max = findMax(data);

    try std.testing.expectEqual(max, 24000);
}
