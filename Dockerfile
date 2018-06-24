FROM stilliard/pure-ftpd:jessie-latest

RUN adduser --home /var/ftp --shell /usr/sbin/nologing --disabled-login --disabled-password --no-create-home --quiet ftp && \
    mkdir /var/ftp && \
    chmod 0777 /var/ftp

CMD /run.sh -c 30 -C 10 -l puredb:/etc/pure-ftpd/pureftpd.pdb -j -R -P $PUBLICHOST -p 30000:30059 --tls=3 -i
