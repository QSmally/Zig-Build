
# Zig Build

Image to compile and run Zig.

A `scratch` image containing the output binary of `zig build` from a multi-stage build. A couple of
build args may be supplied to adjust the compilation process by the image; `VERSION` (`0.13.0`
default), `OPTIONS` (`-Doptimize=ReleaseSafe` default). This image is perfect for statically
compiled Zig binaries without any system dependencies.

## Usage

A compose service may look something like the following, running it with `$ docker compose up`.

```yml
services:
  application:
    restart: always
    build: . # Dockerfile, build.zig, Sources/
    container_name: application
    entrypoint: /bin/<executable>
```

## Cross-compilation

Say you're compiling from `darwin/aarch64` (macOS M-series) and need to build a deployment image to
run on your Debian Linux server on x64, you can easily specify the final stage's target platform and
compilation target (using the awesome capabilities of the Zig compiler).
[Having the multi-stage build](https://docs.docker.com/build/building/multi-platform/#cross-compilation)
removes the need for (often slow) virtualisation.

Below compiles an image for `linux/amd64` with a `x86_64-linux-musl` (static) binary regardless of
the platform you're building on.

```bash
$ options="-Doptimize=ReleaseSafe -Dtarget=x86_64-linux-musl"
$ docker build \
    --platform "linux/amd64" \
    --build-arg "OPTIONS=$options" \
    -t application .
```
