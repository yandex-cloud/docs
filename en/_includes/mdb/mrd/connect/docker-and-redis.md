## Connecting from a Docker container {#connection-docker}

You can only use Docker containers to connect to public cluster hosts [using SSL certificates](../../../../managed-redis/operations/connect/index.md#get-ssl-cert).

To connect to a {{ mrd-name }} cluster, add the following lines to the Dockerfile:

```bash
# Build the redis-tools utility with TLS support manually.
RUN apt-get update && \
    apt-get install wget make gcc libssl-dev --yes && \
    wget https://download.redis.io/redis-stable.tar.gz && \
    tar -xzvf redis-stable.tar.gz && \
    cd redis-stable && \
    make BUILD_TLS=yes MALLOC=libc && \
    make install && \
    cp ./src/redis-cli /usr/bin/ && \
    # Get an SSL certificate.
    mkdir -p ~/.redis && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.redis/{{ crt-local-file }} && \
    chmod 0655 ~/.redis/{{ crt-local-file }}
```
