FROM registry.access.redhat.com/ubi8/go-toolset AS builder
COPY hello-world.go /tmp/src/
USER 0
RUN chown -R 1001:0 /tmp/src
USER 1001
ENV GO111MODULE=off
RUN  /usr/libexec/s2i/assemble

FROM registry.access.redhat.com/ubi8/ubi-minimal AS runner
RUN mkdir /app
WORKDIR /app

COPY --from=builder /opt/app-root/gobinary /app/main
ENTRYPOINT ["/app/main"]

