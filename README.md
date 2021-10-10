Harbor Simple Router
====================

Provides an NGINX image with predefined templates, controlled by environment variables.

Based on Harbor's concept - an external gateway with service discovery is routing traffic to containers by domain name,
simple router does not replace gateway, it should be put in place of application container to eg. do rewrites, redirects, proxying etc.

Example architecture
--------------------

Gateway + Service Discovery routes traffic to selected container by hostname -> Simple Router reacts for eg. forum.zsp.net.pl and performs redirection to super-hiper-new-forum.zsp.net.pl

#### Configuration reference

List of all common environment variables and their defaults. Those variables are used regardless of template.

```yaml

- NGINX_CLIENT_MAX_BODY_SIZE # (default: 200000M)


- NGINX_FCGI_BUFFERS # (default: "16 512k")


- NGINX_FCGI_BUFF_SIZE # (default: 512k)


- NGINX_FCGI_BUSY_BUFF_SIZE # (default: 786k)


- NGINX_FCGI_TEMP_WRITE_SIZE # (default: 20m)

# GZIP output. May be redundant when there is a gateway above
- NGINX_GZIP # (default: off)


- NGINX_KEEPALIVE_TIMEOUT # (default: 65)

# Fetch the long/big request at first, then pass it to application? (recommended when container is directly accessible on the internet, not recommended when is behind a gateway which is already buffering requests)
- NGINX_REQUEST_BUFFERING # (default: "on")


- NGINX_SENDFILE # (default: on)


- NGINX_TCP_NODELAY # (default: on)


- NGINX_TCP_NOPUSH # (default: on)


- NGINX_TYPES_HASH_MAX_SIZE # (default: 4096)


- NGINX_WORKER_CONNECTIONS # (default: 1024)

# Worker processes count
- NGINX_WORKER_PROCESSES # (default: 4)


- RKD_PATH # (default: /opt/rkd/.rkd)


```

# Templates

## redirect-to-new-domain

Redirects to a new domain. Preserves HTTP/HTTPS scheme and request URI.

**Variables:**
- TEMPLATE="redirect-to-new-domain"
- NEW_DOMAIN (example: iwa-ait.org)

## reditect-to-url

Redirect to a given URL, does not preserve scheme or request URI.

**Variables:**
- TEMPLATE="redirect-to-url"
- REDIRECT_URL="https://zsp.net.pl/statut"
