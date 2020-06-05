ARG NGINX_VERSION=1.19

FROM nginx:${NGINX_VERSION}-alpine

# stateless container can be updated with a rolling strategy safely
LABEL org.riotkit.updateStrategy="rolling"

ADD container-files/ /

#
# Install RKD
#
ENV RKD_PATH=/opt/rkd/.rkd
RUN apk add py3-pip bash git \
    && pip3 install -r /opt/rkd/requirements.txt

#
# Configuration
#
ENV NGINX_CLIENT_MAX_BODY_SIZE=200000M \
    NGINX_TYPES_HASH_MAX_SIZE=4096 \
    NGINX_KEEPALIVE_TIMEOUT=65 \
    # GZIP output. May be redundant when there is a gateway above
    NGINX_GZIP=off \
    # Worker processes count
    NGINX_WORKER_PROCESSES=4 \
    NGINX_WORKER_CONNECTIONS=1024 \
    NGINX_SENDFILE=on \
    NGINX_TCP_NOPUSH=on \
    NGINX_TCP_NODELAY=on \
    NGINX_FCGI_TEMP_WRITE_SIZE=20m \
    NGINX_FCGI_BUSY_BUFF_SIZE=786k \
    NGINX_FCGI_BUFF_SIZE=512k \
    NGINX_FCGI_BUFFERS="16 512k" \
    # Fetch the long/big request at first, then pass it to application? (recommended when container is directly accessible on the internet, not recommended when is behind a gateway which is already buffering requests)
    NGINX_REQUEST_BUFFERING="on"

ENTRYPOINT ["rkd", ":start"]
