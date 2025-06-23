---
title: Рекомендуемые клиенты для СУБД {{ VLK }}
description: 'Для подключения к {{ mrd-short-name }} рекомендуется использовать следующие клиенты:: Python-пакет redis, Java-клиент jedis, Node.js-пакет ioredis, Go-клиент go-redis, telnet, redis-cli. {{ mrd-short-name }} не накладывает ограничений на использование остальных клиентов. Однако при их использовании ознакомьтесь с известными ограничениями и проблемами во избежание проблем с подключением и работой с кластером.'
keywords:
  - клиенты redis
  - клиенты valkey
  - clients redis
  - clients valkey
  - redis
  - valkey
  - субд redis
  - субд valkey
---

# Рекомендуемые клиенты для СУБД {{ mrd-name }}

Для подключения к {{ mrd-short-name }} рекомендуется использовать следующие клиенты:
* стандартный `redis-cli`;
* утилита `telnet`;
* Python-пакет [redis](https://pypi.org/project/redis/);
* Java-клиент [jedis](https://mvnrepository.com/artifact/redis.clients/jedis);
* Node.js-пакет [ioredis](https://www.npmjs.com/ioredis);
* Go-клиент [go-redis](https://github.com/go-redis/redis).

{{ mrd-short-name }} не накладывает ограничений на использование остальных клиентов. Однако при их использовании ознакомьтесь с известными ограничениями и проблемами во избежание проблем с подключением и работой с кластером.

{% note info %}

Для подключения с использованием SSL-соединения используйте клиент `redis-cli`, собранный с флагом `BUILD_TLS=yes`. Подробнее см. в примерах строк подключения к [шардированному](../operations/connect/sharded.md#bash) или [нешардированному](../operations/connect/non-sharded.md#bash) кластеру.

{% endnote %}
