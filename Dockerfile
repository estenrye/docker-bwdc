FROM alpine:20210804 as download_bwdc
WORKDIR /tmp
ADD https://vault.bitwarden.com/download/?app=connector&platform=linux&variant=cli-zip /tmp/bwdc.zip
RUN apk --no-cache add unzip
RUN unzip /tmp/bwdc.zip

FROM alpine:20210804
COPY --from=download_bwdc /tmp/bwdc /usr/bin/bwdc
RUN  apk --no-cache add \
       gcompat \
       gnupg \
       libc6-compat \
       libstdc++ \
       libsecret \
       pass \
  && adduser -D bwdc \
  && echo 'a11dba5feedc01ddeadda7a2beefc0de' >  /etc/machine-id
USER bwdc
ENV HOME /home/bwdc
WORKDIR /home/bwdc
RUN  mkdir -p /home/bwdc/.config/Bitwarden\ Directory\ Connector
