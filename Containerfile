FROM registry.access.redhat.com/ubi9/ubi-micro AS runner

CMD ["uname","-om" ]
