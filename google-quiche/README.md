# Google quiche Testbed

This is a dockerized testbed for the [Google quiche MASQUE implementation](https://github.com/google/quiche/).

```
┌─────────────────────┐         ┌──────────────────────┐
│   client container  │ ─────▶  │   proxy container    │ ─────▶ Internet
│   (MASQUE client)   │         │   (MASQUE proxy)     │
└─────────────────────┘         └──────────────────────┘
           │                               │
           │                               │
           └───────────────┬───────────────┘
                           │
                   Docker bridge network
```

## Build the testbed

```bash
docker build -t google-masque-image .
```

```bash
docker compose up
```

## Start a MASQUE connection

The proxy automatically starts listening on port 9661 when the containers are started. The client needs to be started manually:


Enter the client container:

```bash
docker exec -it google-masque-client /bin/bash
```

Inside the masque-client container, open a MASQUE connection to the proxy:

```bash
/app/quiche/bazel-bin/quiche/masque_client --disable_certificate_verification=true 172.30.0.2:9661 https://cloudflare-quic.com
```
In this example, the target website is https://cloudflare-quic.com


Enter the proxy container:
```bash
docker exec -it google-masque-server /bin/bash
```

The proxy starts automatically when you run ```docker compose up```. If you need to (re)start the proxy manually, you can do so by running:

```bash
/app/quiche/bazel-bin/quiche/masque_server --certificate_file /app/certs/server.crt --key_file /app/certs/server.key
```

Start tcpdump on the proxy's interface to monitor all incoming and outgoing connections. By default, the pcap file is saved to capture/proxy-traffic.pcap

```bash
tcpdump -i any -w /capture/masque.pcap
```

## Generate a self-signed certificate
If want need to generate a new self-signed TLS certificate for the proxy, simply run:

```bash
./generate_new_cert.sh
```

Then place the generated files into the <i>certs</i> directory and rerun ```docker compose up```.

## Notes
Neither the google-masque-client nor the google-masque-server print to stdout. In order to analyze the traffic, you need to capture it with tcpdump or alike.

If you run this on a different architecture than ARM, you need to adjust the ```https://github.com/bazelbuild/bazelisk/releases/download/v1.27.0/bazelisk-linux-arm64``` binary in the Dockerfile.