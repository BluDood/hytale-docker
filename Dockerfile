FROM eclipse-temurin:25-jre-alpine AS builder

RUN apk update && \
  apk add --no-cache wget unzip

WORKDIR /tmp

RUN wget https://downloader.hytale.com/hytale-downloader.zip && \
  unzip hytale-downloader.zip && \
  rm hytale-downloader.zip

RUN chmod +x hytale-downloader-linux-amd64

FROM eclipse-temurin:25-jdk-alpine AS hytale  

RUN apk update && \
  apk add --no-cache bash wget unzip build-base gcompat libc6-compat

WORKDIR /opt/hytale

COPY --from=builder /tmp/hytale-downloader-linux-amd64 /usr/local/bin/hytale-downloader

COPY ./scripts/ /opt/hytale/scripts
RUN chmod +x /opt/hytale/scripts/*.sh

EXPOSE 5520

ENTRYPOINT [ "/opt/hytale/scripts/entrypoint.sh" ]