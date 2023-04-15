
# Zig-Build

Image to compile and run Zig.

A `scratch` image containing the output binary of `zig build` from a multi-stage build.

## Usage

A compose file may look something like the following, running it with `$ docker compose up`.

```yml
application:
  restart: always
  image: qsmally/zig-build
  container_name: application
  entrypoint: /bin/mybuildexecutable
```

`build.zig`:

```zig
const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const e = b.addExecutable("mybuildexecutable", "<main file>.zig");
    e.install();
}
```
