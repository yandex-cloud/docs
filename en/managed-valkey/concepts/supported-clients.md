---
title: Recommended {{ VLK }} clients
description: 'To connect to {{ mrd-short-name }}, consider using the following clients: `redis` Python package, `jedis` Java client, `ioredis` Node.js package, `go-redis` Go client, `telnet`, and `redis-cli`. {{ mrd-short-name }} does not restrict the use of other clients. However, if using clients other than those listed above, review known limitations and problems to avoid connectivity issues and cluster failures.'
keywords:
  - redis clients
  - valkey clients
  - clients redis
  - clients valkey
  - redis
  - valkey
  - redis dbms
  - valkey dbms
---

# Recommended {{ mrd-name }} clients

To connect to {{ mrd-short-name }}, consider using the following clients:
* Standard `redis-cli`
* `telnet` utility
* [redis](https://pypi.org/project/redis/) Python package
* [jedis](https://mvnrepository.com/artifact/redis.clients/jedis) Java client
* [Ioredis](https://www.npmjs.com/ioredis) Node.js package
* [Go-redis](https://github.com/go-redis/redis) Go client

{{ mrd-short-name }} does not restrict the use of other clients. However, if using clients other than those listed above, review known limitations and problems to avoid connectivity issues and cluster failures.

{% note info %}

To connect through SSL, use the `redis-cli` client built with the `BUILD_TLS=yes` flag. For more information, see connection string examples for a [sharded](../operations/connect/sharded.md#bash) or [non-sharded](../operations/connect/non-sharded.md#bash) cluster.

{% endnote %}
