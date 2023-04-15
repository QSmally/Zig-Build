
FROM homebrew/brew AS compiler

RUN brew update && brew install zig

WORKDIR /build
COPY . /build
RUN zig build

FROM scratch
COPY --from=compiler /build/zig-out/bin /bin
