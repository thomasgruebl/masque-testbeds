FROM golang:latest

WORKDIR /app

RUN apt-get update && apt-get install -y git iproute2 iputils-ping traceroute net-tools tcpdump

RUN git clone https://github.com/quic-go/masque-go.git .

RUN \
    go build -o /usr/local/bin/masque-client ./cmd/client && \
    go build -o /usr/local/bin/masque-proxy ./cmd/proxy
