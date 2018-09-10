FROM golang:1.11-alpine as builder

WORKDIR /go/src/github.com/empatica/aws-es-proxy
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o aws-es-proxy

FROM alpine:3.8

RUN apk --no-cache add ca-certificates
WORKDIR /home/
COPY --from=builder /go/src/github.com/empatica/aws-es-proxy/aws-es-proxy /usr/local/bin/

ENV PORT_NUM 9200
EXPOSE ${PORT_NUM}

ENTRYPOINT ["aws-es-proxy"]
CMD ["-h"]
