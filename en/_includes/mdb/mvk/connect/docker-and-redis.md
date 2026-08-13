## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mrd-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

    ```bash
    # Buildng valkey-tools with TLS support manually.
    RUN apt-get update && \
        apt-get install wget make gcc libssl-dev --yes && \
        wget https://github.com/valkey-io/valkey/archive/refs/tags/<{{ VLK }}_version>.tar.gz && \
        tar -xzvf <{{ VLK }}_version>.tar.gz && \
        cd valkey-<{{ VLK }}_version> && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/valkey-cli /usr/bin/
    ```

- Connecting with SSL {#with-ssl}

    ```bash
    # Buildng valkey-tools with TLS support manually.
    RUN apt-get update && \
        apt-get install wget make gcc libssl-dev --yes && \
        wget https://github.com/valkey-io/valkey/archive/refs/tags/<{{ VLK }}_version>.tar.gz && \
        tar -xzvf <{{ VLK }}_version>.tar.gz && \
        cd valkey-<{{ VLK }}_version> && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/valkey-cli /usr/bin/ && \
        # Get an SSL certificate.
        mkdir --parents ~/.redis && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.redis/{{ crt-local-file }} && \
        chmod 0655 ~/.redis/{{ crt-local-file }}
    ```

{% endlist %}

You can look up the version on the [{{ VLK }} releases page](https://github.com/valkey-io/valkey/releases).
