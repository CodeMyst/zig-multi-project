const std = @import("std");
const testing = std.testing;

extern fn glfwGetVersion(major: *i32, minor: *i32, rev: *i32) void;

pub const GLFWVersion = struct {
    major: i32,
    minor: i32,
    rev: i32,
};

/// adds 2 numbers
pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

/// gets glfw3 version
pub fn get_glfw_version() GLFWVersion {
    var major: i32 = 0;
    var minor: i32 = 0;
    var rev: i32 = 0;

    glfwGetVersion(&major, &minor, &rev);

    return GLFWVersion {
        .major = major,
        .minor = minor,
        .rev = rev,
    };
}

test "basic add functionality" {
    testing.expect(add(3, 7) == 10);
}
