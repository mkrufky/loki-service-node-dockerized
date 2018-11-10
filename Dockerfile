# download files but ditch wget and unzip from the final image

# download stage
FROM ubuntu:18.04 AS fetcher

RUN apt-get update
RUN apt-get install -y wget unzip

WORKDIR /

RUN echo "5a367fc78e4fcddd0d4d324772fb9d3858dd3faf9dbeca73b48d117256fab6a7 loki-linux-x64-1.0.4.zip" > loki-linux-x64-1.0.4.zip.sha256sum

RUN wget https://github.com/loki-project/loki/releases/download/v1.0.4/loki-linux-x64-1.0.4.zip
RUN sha256sum -c loki-linux-x64-1.0.4.zip.sha256sum

RUN unzip loki-linux-x64-1.0.4.zip

# final stage
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get dist-upgrade -y

COPY --from=fetcher /loki-linux-x64-1.0.4/lokid /usr/sbin/

CMD [ "/usr/sbin/lokid" ]
EXPOSE 22022 22023
