# download files but only copy lokid into the final image

# download stage
FROM ubuntu:18.04 AS fetcher

RUN apt-get update
RUN apt-get install -y wget unzip

WORKDIR /

ARG URL
ARG TEMPDIR
ARG ZIPFILE
ARG SHA256SUM

RUN echo ${SHA256SUM} ${ZIPFILE} > ${ZIPFILE}.sha256sum

RUN wget -nv ${URL}
RUN sha256sum -c ${ZIPFILE}.sha256sum

RUN unzip ${ZIPFILE}

# final stage
FROM ubuntu:18.04

RUN apt-get update
RUN apt-get dist-upgrade -y

ARG TEMPDIR

COPY --from=fetcher ${TEMPDIR}/lokid /usr/sbin/

CMD [ "/usr/sbin/lokid" ]
EXPOSE 22022 22023
