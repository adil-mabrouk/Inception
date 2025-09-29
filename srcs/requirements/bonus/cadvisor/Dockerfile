FROM debian:bookworm

RUN apt update -y && \
    apt install -y wget && \
    wget https://github.com/google/cadvisor/releases/download/v0.53.0/cadvisor-v0.53.0-linux-amd64 -O /usr/local/bin/cadvisor && \
    chmod +x /usr/local/bin/cadvisor && \
    apt remove -y wget && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD ["/usr/local/bin/cadvisor", "-logtostderr", "--port=8080"]