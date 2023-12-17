const std = @import("std");

pub fn panic(cause: std.builtin.PanicCause, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    if (cause == .div_by_zero) {
        std.process.exit(0);
    }
    std.process.exit(1);
}
pub fn main() !void {
    const x = div0(999, 0);
    _ = x;
    return error.TestFailed;
}
fn div0(a: u32, b: u32) u32 {
    return a / b;
}
// run
// backend=llvm
// target=native
