const std = @import("std");

pub fn accumulateWins(data: []const u8) !u64 {
    var total_points: u64 = 0;
    var games = std.mem.splitSequence(u8, data, "\n");

    while (games.next()) |game| {
        if (game.len != 3) {
            std.debug.print("Invalid game: {s}\n", .{game});
        }
        const opponent = game[0];
        const player = game[2];

        // map a->x, b->y, c->z
        const player_compare = player - 23;

        total_points += determineWin(player_compare, opponent);
    }

    return total_points;
}

fn determineWin(player: u8, opponent: u8) u64 {
    // add points for playing r/p/s
    var round_win = player - 'A' + 1;

    if (player == opponent) {
        return round_win + 3;
    }

    // r > s | p > r | s > p
    if (player == 'A' and opponent == 'C' or
        player == 'B' and opponent == 'A' or
        player == 'C' and opponent == 'B')
    {
        return round_win + 6;
    }

    return round_win;
}

test "Rock Paper Scissors" {
    const common = @import("common.zig");

    var data = try common.readInData("data/day2.txt");

    const points_won = try accumulateWins(data);

    try std.testing.expectEqual(points_won, 15);
}
