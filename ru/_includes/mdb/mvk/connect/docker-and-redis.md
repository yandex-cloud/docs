## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mrd-name }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    ```bash
    # Собрать вручную утилиту valkey-tools с поддержкой TLS.
    RUN apt-get update && \
        apt-get install wget make gcc libssl-dev --yes && \
        wget https://github.com/valkey-io/valkey/archive/refs/tags/<версия_{{ VLK }}>.tar.gz && \
        tar -xzvf <версия_{{ VLK }}>.tar.gz && \
        cd valkey-<версия_{{ VLK }}> && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/valkey-cli /usr/bin/
    ```

- Подключение с SSL {#with-ssl}

    ```bash
    # Собрать вручную утилиту valkey-tools с поддержкой TLS.
    RUN apt-get update && \
        apt-get install wget make gcc libssl-dev --yes && \
        wget https://github.com/valkey-io/valkey/archive/refs/tags/<версия_{{ VLK }}>.tar.gz && \
        tar -xzvf <версия_{{ VLK }}>.tar.gz && \
        cd valkey-<версия_{{ VLK }}> && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/valkey-cli /usr/bin/ && \
        # Получить SSL-сертификат.
        mkdir --parents ~/.redis && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.redis/{{ crt-local-file }} && \
        chmod 0655 ~/.redis/{{ crt-local-file }}
    ```

{% endlist %}

Версию можно посмотреть на [странице релизов {{ VLK }}](https://github.com/valkey-io/valkey/releases).
