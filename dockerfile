FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache chrony

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 123/udp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/chronyd", "-d"]