
FROM alpine AS compiler

ARG VERSION=0.13.0
ARG OPTIONS=-Doptimize=ReleaseSafe

RUN apk update && apk add curl tar xz

# zig-linux-aarch64-0.10.1.tar.xz
# ziglang.org/download/<ver>/zig-linux-<architecture>-<ver>.tar.xz

RUN curl https://ziglang.org/download/$VERSION/zig-linux-$(uname -m)-$VERSION.tar.xz -O && \
    tar -xf *.tar.xz && \
    mv zig-linux-$(uname -m)-$VERSION /compiler

WORKDIR /build
COPY . /build
RUN /compiler/zig build $OPTIONS

FROM scratch AS output
COPY --from=compiler /build/zig-out/bin /bin
