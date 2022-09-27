---
title: Redis DBMS supported clients
description: {{ mrd-short-name }} guarantees operation only with certain DBMS clients, but you are free to use other clients without restrictions. The following clients are supported redis Python package, jedis Java client, ioredis Node.js package, go-redis client, telnet, redis-cli.
keywords:
  - clients redis
  - redis
  - dbms redis
---

# Supported DBMS clients

{{ mrd-short-name }} guarantees operation only with certain DBMS clients, but you are free to use other clients without restrictions.

The following clients are supported:
* Standard `redis-cli`.
* `telnet` utility.
* [redis](https://pypi.org/project/redis/) Python package.
* [jedis](https://mvnrepository.com/artifact/redis.clients/jedis) Java client.
* [ioredis](https://www.npmjs.com/ioredis) Node.js package.
* [go-redis](https://github.com/go-redis/redis) Go client.

{% note info %}

To connect via SSL, use the `redis-cli` client built with the `BUILD_TLS=yes` flag. For more information, see examples of connection strings for a [sharded](../operations/connect/sharded.md#bash) or [unsharded](../operations/connect/non-sharded.md#bash) cluster.

{% endnote %}
