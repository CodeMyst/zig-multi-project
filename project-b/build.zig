const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;

const a_build = @import("project-a/build.zig");

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});

    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("project-b", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);

    a_build.linkArtifact(b, exe, target, "../");

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
