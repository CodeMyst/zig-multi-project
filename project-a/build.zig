const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const lib = b.addStaticLibrary("project-a", "src/main.zig");
    lib.setBuildMode(mode);
    lib.install();

    var main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}

pub fn linkArtifact(b: *Builder,
                    exe: *std.build.LibExeObjStep,
                    target: std.build.Target,
                    comptime prefix_path: []const u8) void {

    exe.linkLibC();

    exe.linkSystemLibrary("glfw3");

    const project_a = Pkg {
        .name = "project_a",
        .path = prefix_path ++ "project-a/src/main.zig",
    };

    exe.addPackage(project_a);
}
