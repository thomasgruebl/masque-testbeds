FROM golang:latest

WORKDIR /app

RUN apt-get update && apt-get install -y git iproute2 tcpdump

RUN git clone https://github.com/quic-go/masque-go.git .

RUN \
    go build -o /usr/local/bin/masque-client ./cmd/client && \
    go build -o /usr/local/bin/masque-proxy ./cmd/proxy


RUN mkdir -p certs

RUN cat > certs/san.cnf <<'EOF'
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
CN = localhost

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1
EOF


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout certs/server.key \
    -out certs/server.crt \
    -config certs/san.cnf \
    -extensions v3_req


ENV SSL_CERT_FILE=/app/certs/server.crt

#EXPOSE 4443/udp

# default command (proxy by default)
#CMD ["masque-client", "-t", "quic-go.net:443"] 


# start proxy in container
#masque-proxy -b :4443 -c certs/server.crt -k certs/server.key -t "https://localhost:4443/masque?h={target_host}&p={target_port}"

# run client in the same container (enter with docker exec)
#masque-client -t "https://localhost:4443/masque?h={target_host}&p={target_port}" https://cloudflare-quic.com:443

