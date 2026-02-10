FROM tungns1207/masque_firefox_with_tool:6

WORKDIR /app

USER root

RUN apt update && apt install -y \
    git \
    iproute2 \
    iputils-ping \
    traceroute \
    net-tools \
    tcpdump \
    curl

ENV GO_VERSION=1.25.7
RUN curl -fsSL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    | tar -C /usr/local -xzf -

ENV PATH="/usr/local/go/bin:${PATH}"

RUN git config --global --add safe.directory /app && \
    git clone https://github.com/quic-go/masque-go.git . && \
    git checkout 606f8ea366ff6c8ee4429565a438af61c4c90d23

COPY main.go ./cmd/client/main.go
COPY youtube_loop_firefox_with_proxy.py /home/headless/tools/youtube_loop_firefox_with_proxy.py
COPY certs/ /home/headless/tools/certs/
COPY commands /home/headless/tools/commands

RUN \
    go build -o /usr/local/bin/masque-client ./cmd/client && \
    go build -o /usr/local/bin/masque-proxy ./cmd/proxy

