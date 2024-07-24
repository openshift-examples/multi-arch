FROM registry.access.redhat.com/ubi9/ubi-micro AS runner

# Run a command, to have an architecture-specific action during the build
RUN uname -om

CMD ["uname","-om" ]
