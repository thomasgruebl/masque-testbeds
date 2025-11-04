# masque-go Testbed

This is a dockerized testbed for the [masque-go implementation](https://github.com/quic-go/masque-go).

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

Build and run the client and proxy containers

```bash
docker compose up
```

## Start a MASQUE connection

The proxy automatically starts when the containers are started. The client needs to be started manually:


Enter the client container:

```bash
docker exec -it masque-client /bin/bash
```

Inside the masque-client container, open a MASQUE connection to the proxy:

```bash
masque-client -t "https://172.20.0.2:4443/masque?h={target_host}&p={target_port}" https://cloudflare-quic.com:443
```
In this example, the target website is https://cloudflare-quic.com


Enter the proxy container:
```bash
docker exec -it masque-proxy /bin/bash
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

Then place the generated files into the <i>certs</i> directory.

## Notes
Reopening a MASQUE connection to the same endpoint may not work immediately since there is a timeout on the proxy.

.
.

!!!!!!!!!!!!!!!

NEXT: dump SSL keys, so that we can decrypt the pcap