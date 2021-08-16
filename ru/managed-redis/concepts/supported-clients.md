---
title: Поддерживаемые клиенты СУБД Redis
description: {{ mrd-short-name }} гарантирует работу только для определенных клиентов СУБД Redis, но не накладывает ограничений на использование остальных клиентов. Поддерживаются следующие клиенты Python-пакет redis, Java-клиент jedis, Node.js-пакет ioredis, Go-клиент go-redis, telnet, redis-cli.
keywords:
  - клиенты redis
  - clients redis
  - redis
  - субд redis
---

# Поддерживаемые клиенты СУБД

{{ mrd-short-name }} гарантирует работу только для определенных клиентов СУБД, но не накладывает ограничений на использование остальных клиентов.

Поддерживаются следующие клиенты:
* стандартный `redis-cli`;
* утилита `telnet`;
* Python-пакет [redis](https://pypi.org/project/redis/);
* Java-клиент [jedis](https://mvnrepository.com/artifact/redis.clients/jedis);
* Node.js-пакет [ioredis](https://www.npmjs.com/ioredis);
* Go-клиент [go-redis](https://github.com/go-redis/redis).