FROM debian:bullseye

RUN apt update && apt install -y vsftpd

COPY ./vsftpd.conf /etc/vsftpd.conf

COPY ./script.sh ./script.sh

RUN chmod +x ./script.sh

ENTRYPOINT ["./script.sh"]

# EXPOSE 21 3000-3009