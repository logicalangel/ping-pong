FROM golang:1.20rc3-alpine3.17 as builder

WORKDIR /app

ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

COPY . .
RUN go mod download
RUN go build -ldflags="-w -s" -o app .

FROM alpine:3.17.4

WORKDIR /app

COPY --from=builder /app/app /app/app
CMD [ "./app" ]
