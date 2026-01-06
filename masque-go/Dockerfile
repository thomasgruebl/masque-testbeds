FROM golang:latest

WORKDIR /app

RUN apt update && apt install -y \
    git \
    iproute2 \
    iputils-ping \
    traceroute \
    net-tools \
    tcpdump \
    curl

RUN git clone https://github.com/quic-go/masque-go.git . && \
    git checkout 606f8ea366ff6c8ee4429565a438af61c4c90d23

COPY main.go ./cmd/client/main.go

RUN \
    go build -o /usr/local/bin/masque-client ./cmd/client && \
    go build -o /usr/local/bin/masque-proxy ./cmd/proxy