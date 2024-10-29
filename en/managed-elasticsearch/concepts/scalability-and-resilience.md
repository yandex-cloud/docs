---
title: Sharding and replication in Elasticsearch
description: You can use sharding to enable Elasticsearch clusters to scale as the amount of index data grows. With replication, you can improve cluster fault tolerance and index data protection.
keywords:
  - Elasticsearch sharding
  - Elasticsearch replication
  - Elasticsearch
---

# Sharding and replication

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

In an {{ ES }} cluster:
- You can use sharding to enable the cluster to scale as the amount of index data grows.
- With replication, you can improve cluster fault tolerance and index data protection (only for multi-host cluster configurations).

To learn more about shards, scaling, and fault tolerance, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/scalability.html).

## Index sharding {#sharding}

{{ mes-full-name }} uses the regular {{ ES }} index sharding feature. For each index, you can create one or more primary shards across which the index write requests are distributed. The number of primary shards can only be set when creating an index. You cannot change this number afterwards.

{{ ES }} evenly distributes primary shards across the hosts in the cluster. This reduces the load on an individual host and makes it easy to scale the cluster if the load spikes.

## Index replication {#replication}

{{ mes-full-name }} uses the regular {{ ES }} index replication feature. To enable it, when creating an index, specify the replication factor, i.e., the number of replicas for each primary shard of the index. As a result, the required number of replica shards will be created for each primary shard.

When replication is pre-configured:
- Writing to the index is performed only through the primary shards.
- The index can be read simultaneously from both primary shards and replica shards.

{{ ES }} automatically manages replica shards, moving them between hosts in the cluster if the size of the cluster changes.

The number of replica shards can be modified: unlike primary shards, their number is not fixed when creating an index.