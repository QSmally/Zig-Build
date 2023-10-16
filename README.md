
# Zig-Build

Image to compile and run Zig.

A `scratch` image containing the output binary of `zig build` from a multi-stage build. A couple of
build args may be supplied to adjust the compilation process by the image; `VERSION` (`0.11.0`
default), `PLATFORM` (`linux` default), `OPTIONS` (`-Drelease-safe` default).

## Usage

A compose service may look something like the following, running it with `$ docker compose up`.

```yml
application:
  restart: always
  build: . # Dockerfile, build.zig, Sources/
  container_name: application
  entrypoint: /bin/executable
```

`build.zig`:

```zig
const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const e = b.addExecutable(.{ .name = "executable" });
    // ... build options
    b.installArtifact(e);
}
```
