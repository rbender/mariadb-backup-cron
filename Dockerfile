FROM alpine:latest

RUN apk add bash mariadb-client curl

COPY entrypoint.sh .
COPY backup.sh .

VOLUME "/backup"

CMD ["/entrypoint.sh"]
