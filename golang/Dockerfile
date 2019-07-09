# Multi-stage build 要求 Docker 版本 17.05 以上
FROM golang:1.12 AS builder
WORKDIR /app
COPY ./ ./
RUN go build -o myapp test.go

FROM debian:stable-slim
WORKDIR /app
COPY --from=builder /app/myapp /app/
CMD ["./myapp"]
