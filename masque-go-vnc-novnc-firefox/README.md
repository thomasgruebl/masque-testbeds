# masque-go-vnc-novnc-firefox Testbed

This is a dockerized testbed for the [masque-go implementation](https://github.com/quic-go/masque-go) which is partly based on a [accetto/xubuntu-vnc-novnc-firefox](https://hub.docker.com/r/accetto/xubuntu-vnc-novnc-firefox) Docker image.


## Build the image

Build and run the client and proxy containers:

```bash
docker build --tag masque-go-vnc-novnc-firefox .
```

## Start the container

Start the testbed container:

```bash
docker run --rm -d -p 6901:6901 -p 5901:5901 -v "$(pwd):/home/headless/Documents" -e VNC_PW=password123 --name masque-go-vnc-novnc-firefox-container masque-go-vnc-novnc-firefox
```

On your host machine, open a browser and navigate to

```bash
127.0.0.1:6901
```

Select "noVNC Lite Client" and enter the password "password123".

Open a terminal and navigate to the following directory:

```bash
/home/headless/tools/
```

Start the Python script :
```bash
python3 youtube_loop_firefox_with_proxy.py
```

