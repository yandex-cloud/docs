---
title: Host types in {{ SD }}
description: '{{ mmg-name }} cluster hosts come in four types. Each host type has a role and functions of its own.'
---

# Host types in {{ mmg-name }}

{{ mmg-name }} has these four host types: `MONGOD`, `MONGOINFRA`, `MONGOCFG`, and `MONGOS`. Each host type has a [role and functions](#features) of its own in the cluster. The [type and number](#configuration) of hosts in a {{ mmg-name }} cluster depend on what sharding type you select.

## Roles and functions of different host types {#features}

* `MONGOD`: Data storage and query processing hosts. These hosts are present in both sharded and non-sharded clusters. 

  Primary functions of `MONGOD` hosts:
  * Read and write request processing.
  * User data storage.
  * Data replication.
  * Ensuring data consistency.

* `MONGOCFG`: Sharding configuration hosts. These hosts are present only in clusters with advanced sharding.

  Primary functions of `MONGOCFG` hosts:
  * Storing and updating sharding metadata on changes in the shard configuration.
  * Providing `MONGOS` hosts with up-to-date information about chunks and shards.
  * Coordinating chunk migration between shards.

* `MONGOS`: Router hosts. These hosts are present only in clusters with advanced sharding.

  Primary functions of `MONGOS` hosts:
  * Accepting client connections.
  * Routing queries to shards.
  * Processing of query or subquery results.
  * Delivery of final output to the client.

* `MONGOINFRA`: Infrastructure hosts. This host type combines the `MONGOS` and `MONGOCFG` roles. `MONGOINFRA` hosts are present only in clusters with standard sharding.

  Primary functions of `MONGOINFRA` hosts:
  * Accepting client connections.
  * Routing queries to shards.
  * Storing and updating sharding metadata on changes in the shard configuration.
  * Coordinating chunk migration between shards.
  * Processing of query or subquery results.
  * Delivery of final output to the client.

## Cluster composition depending on sharding type {#configuration}

The number of hosts of various types in an {{ mmg-name }} cluster depends on [sharding type](./sharding.md#shard-management):

{% include [sharding-and-host-roles-table](../../_includes/mdb/mmg/sharding-and-host-roles-table.md) %}

A non-sharded cluster consists exclusively of `MONGOD` hosts that process all client requests. Query routing is managed by the [{{ SD }} client](./supported-clients.md).

A standard-sharded cluster consists of `MONGOD` and `MONGOINFRA` hosts.
Client requests addressed to the cluster are processed as follows:
1. The {{ SD }} client connects to all `MONGOINFRA` hosts and sends the request to one of them.
1. The `MONGOINFRA` host analyzes the request and figures out what shards are affected by it.
1. The `MONGOINFRA` host forwards the request or the group of subrequests to relevant `MONGOD` hosts.
1. `MONGOD` hosts execute the request or subrequests.
1. The `MONGOINFRA` host processes the result of the request or subrequests and returns the final result to the client.

A cluster with advanced sharding consists of `MONGOD`, `MONGOS`, and `MONGOCFG` hosts.
Client requests addressed to the cluster are processed as follows:
1. The {{ SD }} client connects to all `MONGOS` hosts and sends the request to one of them.
1. The `MONGOS` host analyzes the request and uses metadata from `MONGOCFG` hosts to figure out what shards are affected by it.
1. The `MONGOS` host forwards the request or the group of subrequests to relevant `MONGOD` hosts.
1. `MONGOD` hosts execute the request or subrequests.
1. The `MONGOS` host processes the result of the request or subrequests and returns the final result to the client.
