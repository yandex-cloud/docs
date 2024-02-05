## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mrd-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   # Build the redis-tools utility with TLS support manually.
   RUN apt-get update && \
       apt-get install make gcc libssl-dev --yes && \
       wget https://download.redis.io/redis-stable.tar.gz && \
       tar -xzvf redis-stable.tar.gz && \
       cd redis-stable && \
       make BUILD_TLS=yes MALLOC=libc && \
       make install && \
       cp ./src/redis-cli /usr/bin/
   ```


- Connecting via SSL {#with-ssl}

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
       mkdir --parents ~/.redis && \
       wget "{{ crt-web-path }}" \
            --output-document ~/.redis/{{ crt-local-file }} && \
       chmod 0655 ~/.redis/{{ crt-local-file }}
   ```

{% endlist %}