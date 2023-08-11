## Подключение из Docker-контейнера {#connection-docker}

Подключаться из Docker-контейнера можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](../../../managed-mongodb/operations/connect/index.md#get-ssl-cert).

Для подключения к кластеру {{ mmg-name }} добавьте в Dockerfile строки:

```bash
RUN apt-get update && \
    apt-get install wget --yes && \
    mkdir -p ~/.mongodb && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mongodb/root.crt && \
    chmod 0644 ~/.mongodb/root.crt
```

После запуска Docker-контейнера перейдите в него и [установите утилиту](https://www.mongodb.com/docs/mongodb-shell/install/) `mongosh`. Она понадобится для подключения к кластеру.
