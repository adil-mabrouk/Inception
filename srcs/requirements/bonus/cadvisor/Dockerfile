FROM debian:bullseye


RUN apt update -y
RUN apt install wget -y

RUN wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 -O /usr/local/bin/cadvisor \
    && chmod +x /usr/local/bin/cadvisor

CMD ["/usr/local/bin/cadvisor", "-logtostderr", "--port=8080"]
