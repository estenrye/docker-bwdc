FROM alpine:3 as download_bwdc
WORKDIR /tmp
ADD https://vault.bitwarden.com/download/?app=connector&platform=linux&variant=cli-zip /tmp/bwdc.zip
RUN apk --no-cache add unzip
RUN unzip /tmp/bwdc.zip

FROM alpine:3
COPY --from=download_bwdc /tmp/bwdc /usr/bin/bwdc
RUN apk --no-cache add \
      libc6-compat \
      libsecret
ENTRYPOINT [ "bwdc" ]