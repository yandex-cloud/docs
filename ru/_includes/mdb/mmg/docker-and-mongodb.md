## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mmg-name }} из Docker-контейнера с SSL, добавьте в Dockerfile строки:

```bash
RUN apt-get update && \
    apt-get install wget --yes && \
    mkdir --parents ~/.mongodb && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mongodb/root.crt && \
    chmod 0644 ~/.mongodb/root.crt
```

Чтобы подключаться без SSL, дополнительно настраивать Dockerfile не нужно.

После запуска Docker-контейнера перейдите в него и [установите утилиту](https://www.mongodb.com/docs/mongodb-shell/install/) `mongosh`. Она понадобится для подключения к кластеру.
