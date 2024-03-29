
FROM alpine AS compiler

ARG VERSION=0.11.0
ARG OPTIONS=-Doptimize=ReleaseSafe

RUN apk update && apk add curl tar xz

# zig-linux-aarch64-0.10.1.tar.xz
# ziglang.org/download/<ver>/zig-linux-<architecture>-<ver>.tar.xz

RUN curl https://ziglang.org/download/$VERSION/zig-$PLATFORM-$(uname -m)-$VERSION.tar.xz -O && \
    tar -xf *.tar.xz && \
    mv zig-$PLATFORM-$(uname -m)-$VERSION /compiler

WORKDIR /build
COPY . /build
RUN /compiler/zig build $OPTIONS

FROM alpine AS output
COPY --from=compiler /build/zig-out/bin /bin
