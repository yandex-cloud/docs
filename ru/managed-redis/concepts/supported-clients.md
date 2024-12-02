---
title: Поддерживаемые клиенты СУБД {{ RD }}
description: '{{ mrd-short-name }} гарантирует работу только для определенных клиентов СУБД {{ RD }}, но не накладывает ограничений на использование остальных клиентов. Поддерживаются следующие клиенты Python-пакет redis, Java-клиент jedis, Node.js-пакет ioredis, Go-клиент go-redis, telnet, redis-cli.'
keywords:
  - клиенты redis
  - clients redis
  - redis
  - субд redis
---

# Поддерживаемые клиенты СУБД в {{ mrd-name }}

{{ mrd-short-name }} гарантирует работу только для определенных клиентов СУБД, но не накладывает ограничений на использование остальных клиентов.

Поддерживаются следующие клиенты:
* стандартный `redis-cli`;
* утилита `telnet`;
* Python-пакет [redis](https://pypi.org/project/redis/);
* Java-клиент [jedis](https://mvnrepository.com/artifact/redis.clients/jedis);
* Node.js-пакет [ioredis](https://www.npmjs.com/ioredis);
* Go-клиент [go-redis](https://github.com/go-redis/redis).

{% note info %}

Для подключения с использованием SSL-соединения используйте клиент `redis-cli`, собранный с флагом `BUILD_TLS=yes`. Подробнее см. в примерах строк подключения к [шардированному](../operations/connect/sharded.md#bash) или [нешардированному](../operations/connect/non-sharded.md#bash) кластеру.

{% endnote %}
