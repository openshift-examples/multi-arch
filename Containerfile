FROM registry.access.redhat.com/ubi8/go-toolset AS builder
WORKDIR /tmp/src/
COPY hello-world.go /tmp/src/
RUN go build -o /tmp/hello-world .

# Or via assemble
# COPY hello-world.go /tmp/src/
# USER 0
# RUN chown -R 1001:0 /tmp/src
# USER 1001
# RUN  /usr/libexec/s2i/assemble

# FROM registry.access.redhat.com/ubi8/ubi-minimal AS runner
# RUN mkdir /app
# WORKDIR /app
# COPY --from=builder /opt/app-root/gobinary /app/main
# ENTRYPOINT ["/app/main"]


FROM scratch AS runner
COPY --from=builder /tmp/hello-world /hello-world
ENTRYPOINT ["/hello-world"]

