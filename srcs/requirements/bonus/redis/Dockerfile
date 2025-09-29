FROM debian:bookworm

RUN apt update && apt install -y redis-server \
	&& rm -rf /var/lib/apt/lists/*

CMD ["redis-server", "--protected-mode", "no"]
