FROM --platform=$TARGETPLATFORM alpine:latest

ENV NTP_SERVERS="pool.ntp.org" \
    ALLOWED_CLIENTS="" \
    DENIED_CLIENTS="" \
    MAKESTEP="1 3"

RUN apk update && \
    apk add --no-cache chrony

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 123/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/chronyd", "-ds"]