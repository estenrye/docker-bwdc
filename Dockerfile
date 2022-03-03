FROM alpine:20210804 as download_bwdc
WORKDIR /tmp
ADD https://vault.bitwarden.com/download/?app=connector&platform=linux&variant=cli-zip /tmp/bwdc.zip
RUN apk --no-cache add unzip
RUN unzip /tmp/bwdc.zip

FROM alpine:20210804
ENV HOME /home/bwdc
COPY --from=download_bwdc /tmp/bwdc /usr/bin/bwdc
RUN apk --no-cache add \
      gcompat \
      libc6-compat \
      libstdc++ \
      libsecret \
  && adduser -D bwdc
USER bwdc
WORKDIR /home/bwdc
ENTRYPOINT [ "bwdc" ]
