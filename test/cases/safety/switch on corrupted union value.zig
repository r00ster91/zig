const std = @import("std");

pub fn panic(cause: std.builtin.PanicCause, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    if (cause == .corrupt_switch) {
        std.process.exit(0);
    }
    std.process.exit(1);
}

const U = union(enum(u32)) {
    X: u8,
    Y: i8,
};

pub fn main() !void {
    var u: U = undefined;
    @memset(@as([*]u8, @ptrCast(&u))[0..@sizeOf(U)], 0x55);
    switch (u) {
        .X, .Y => @breakpoint(),
    }
    return error.TestFailed;
}

// run
// backend=llvm
// target=native
