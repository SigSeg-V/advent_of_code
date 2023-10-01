const std = @import("std");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub fn readInData(path: []const u8) ![]u8 {
    //open input data and ensure close at end of scope
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const file_size = (try file.stat()).size;
    const contents = try file.reader().readAllAlloc(gpa.allocator(), file_size);

    return contents;
}
