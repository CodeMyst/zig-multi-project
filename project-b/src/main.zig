const std = @import("std");
const project_a = @import("project_a");

pub fn main() anyerror!void {
    std.log.info("glfw version: {}", .{project_a.get_glfw_version()});
}
