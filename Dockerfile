FROM alpine:20231219 as download_bwdc
WORKDIR /tmp
ADD https://vault.bitwarden.com/download/?app=connector&platform=linux&variant=cli-zip /tmp/bwdc.zip
RUN apk --no-cache add unzip
RUN unzip /tmp/bwdc.zip

FROM alpine:20231219
COPY --from=download_bwdc /tmp/bwdc /usr/bin/bwdc
RUN apk --no-cache add \
      gcompat \
      libc6-compat \
      libstdc++ \
      libsecret \
  && adduser -D bwdc
USER bwdc
ENV HOME=/home/bwdc \
    BITWARDENCLI_CONNECTOR_PLAINTEXT_SECRETS=true
WORKDIR /home/bwdc
RUN  mkdir -p /home/bwdc/.config/Bitwarden\ Directory\ Connector
ENTRYPOINT [ "bwdc" ]