---
title: Supported {{ RD }} DBMS clients
description: '{{ mrd-short-name }} guarantees operation only for some {{ RD }} DBMS clients but does not restrict the use of other clients. The following clients are supported: `redis` Python package, `jedis` Java client, `ioredis` Node.js package, `go-redis` Go client, `telnet`, and `redis-cli`.'
keywords:
  - redis clients
  - clients redis
  - redis
  - redis dbms
---

# DBMS clients supported in {{ mrd-name }}

{{ mrd-short-name }} guarantees operation only for some DBMS clients but does not restrict the use of other clients.

The following clients are supported:
* Standard `redis-cli`
* `telnet` utility
* [redis](https://pypi.org/project/redis/) Python package
* [jedis](https://mvnrepository.com/artifact/redis.clients/jedis) Java client
* [ioredis](https://www.npmjs.com/ioredis) Node.js package
* [go-redis](https://github.com/go-redis/redis) Go client

{% note info %}

To connect through SSL, use the `redis-cli` client built with the `BUILD_TLS=yes` flag. For more information, see connection string examples for a [sharded](../operations/connect/sharded.md#bash) or [unsharded](../operations/connect/non-sharded.md#bash) cluster.

{% endnote %}
