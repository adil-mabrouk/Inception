FROM debian:bookworm

RUN apt-get update && apt-get install -y php8.2 \
	&& rm -rf /var/lib/apt/lists/*

COPY index.html /

COPY script.sh /

RUN chmod +x /script.sh

ENTRYPOINT [ "/script.sh" ]

