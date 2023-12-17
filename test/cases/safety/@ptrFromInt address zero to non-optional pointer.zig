const std = @import("std");

pub fn panic(cause: std.builtin.PanicCause, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    if (cause == .cast_to_null) {
        std.process.exit(0);
    }
    std.process.exit(1);
}
pub fn main() !void {
    var zero: usize = 0;
    _ = &zero;
    const b: *i32 = @ptrFromInt(zero);
    _ = b;
    return error.TestFailed;
}
// run
// backend=llvm
// target=native
