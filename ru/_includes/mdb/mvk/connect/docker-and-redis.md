## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mrd-name }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    # Собрать вручную утилиту redis-tools с поддержкой TLS.
    RUN apt-get update && \
        apt-get install make gcc libssl-dev --yes && \
        wget https://download.redis.io/redis-stable.tar.gz && \
        tar -xzvf redis-stable.tar.gz && \
        cd redis-stable && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/redis-cli /usr/bin/
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    # Собрать вручную утилиту redis-tools с поддержкой TLS.
    RUN apt-get update && \
        apt-get install wget make gcc libssl-dev --yes && \
        wget https://download.redis.io/redis-stable.tar.gz && \
        tar -xzvf redis-stable.tar.gz && \
        cd redis-stable && \
        make BUILD_TLS=yes MALLOC=libc && \
        make install && \
        cp ./src/redis-cli /usr/bin/ && \
        # Получить SSL-сертификат.
        mkdir --parents ~/.redis && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.redis/{{ crt-local-file }} && \
        chmod 0655 ~/.redis/{{ crt-local-file }}
    ```

{% endlist %}