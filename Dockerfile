
FROM homebrew/brew AS compiler

ARG OPTIONS=-Drelease-safe

RUN brew update && brew install zig

WORKDIR /build
COPY . /build
RUN zig build $OPTIONS

FROM scratch AS output
COPY --from=compiler /build/zig-out/bin /bin
