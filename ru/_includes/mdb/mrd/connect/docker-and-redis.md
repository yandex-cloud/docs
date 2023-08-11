## Подключение из Docker-контейнера {#connection-docker}

Подключаться из Docker-контейнера можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](../../../../managed-redis/operations/connect/index.md#get-ssl-cert).

Для подключения к кластеру {{ mrd-name }} добавьте в Dockerfile строки:

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
    mkdir -p ~/.redis && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.redis/{{ crt-local-file }} && \
    chmod 0655 ~/.redis/{{ crt-local-file }}
```
