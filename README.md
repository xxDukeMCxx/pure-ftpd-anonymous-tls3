## pure-ftpd-anonymous-tls3

this is just a personnal tunning of the original stilliard/pure-ftpd. You probably want it instead : 
https://hub.docker.com/r/stilliard/pure-ftpd/

# Launch command :

    docker run -d -p 21:21 -p 30000-30059:30000-30059  -v VftpUsers:/home/ftpusers -v VftpPasswd:/etc/pure-ftpd/passwd -v VftpSsl:/etc/ssl/private -v VftpAnonymous:/var/ftp -e PUBLICHOST="ftp.mydomain.com" -e FTP_ANON_DIR="/var/ftp" --restart=always --name Cpure-ftp dukemc/pure-ftpd-anonymous-tls3

# Need to create a certificate to work :

If you want to enable tls (for ftps connections), you need to have a valid
certificate. You can get one from one of the certificate authorities that you'll
find when googling this topic. The certificate (containing private key and
certificate) needs to be at:

/etc/ssl/private/pure-ftpd.pem

Use docker volumes to get the certificate there at runtime. The container will
automatically enable optional TLS when it detect the file at this location.

You can also self-sign a certificate, which is certainly the easiest way to
start out. Self signed certificates come with certain drawbacks, but it might
be better to have a self signed one than none at all.

Here's how to create a self-signed certificate from within the container:

    mkdir -p /etc/ssl/private

    openssl dhparam -out /etc/ssl/private/pure-ftpd-dhparams.pem 2048

    openssl req -x509 -nodes -newkey rsa:2048 -sha256 -keyout \
    /etc/ssl/private/pure-ftpd.pem \
    -out /etc/ssl/private/pure-ftpd.pem

    chmod 600 /etc/ssl/private/*.pem


# Create a user (ie "ftpmaster" ) to manage (upload/etc.) the Anonymous zone :


    docker exec -it Cpure-ftp pure-pw useradd ftpmaster -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /var/ftp

# Create users with personnal data store :

   docker exec -it Cpure-ftp pure-pw useradd bob -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/bob

# more informations :

https://hub.docker.com/r/stilliard/pure-ftpd/