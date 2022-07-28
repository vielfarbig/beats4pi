FROM golang:latest

ENV GOPATH=/go
ENV GOARCH=arm
ENV GOARM=7
#ENV GOARCH=386
#ENV GOOS=windows

ENV BEATS=filebeat,metricbeat
ENV BEATS_VERSION=8.3.0

COPY ./build.sh /build.sh
RUN [ "mkdir", "-p", "/go" ]
RUN [ "mkdir", "/build" ]

CMD "/build.sh"
