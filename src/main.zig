const std = @import("std");
const day1 = @import("day1.zig");

pub fn main() !void {
    const data = try day1.readInData("data/day1.txt");

    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("Data contents:\n{s}", .{data});

    const max = day1.findMax(data);
    std.debug.print("Max number found: {d}\n", .{max});
}
