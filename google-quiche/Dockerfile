FROM ubuntu:latest

WORKDIR /app

RUN apt update && apt install -y \
    libicu-dev \
    clang \
    lld \
    wget \
    git \
    iproute2 \
    iputils-ping \
    traceroute \
    net-tools \
    tcpdump \
    curl

RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.27.0/bazelisk-linux-arm64
RUN chmod +x bazelisk-linux-arm64
RUN mv bazelisk-linux-arm64 /usr/local/bin/bazel

# noticed that newer commits may throw an error, but the commit (fc9b5782ff3939d34b7dc8266c4c73572cfbf6d5) seems to build just fine.
# remove the line "git checkout fc9b5782ff3939d34b7dc8266c4c73572cfbf6d5 && \" if you want to test the most recent version of the repo.
RUN git clone --recurse-submodules https://github.com/google/quiche.git && \
    cd quiche && \
    git checkout fc9b5782ff3939d34b7dc8266c4c73572cfbf6d5 && \
    CC=clang bazel build -c opt //...
