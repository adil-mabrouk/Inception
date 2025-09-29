#!/bin/bash

# Create FTP user and set password
useradd -m -d /var/www/html -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

# Make sure permissions are correct
chown -R $FTP_USER:$FTP_USER /var/www/html

# Start vsftpd
/usr/sbin/vsftpd /etc/vsftpd.conf
