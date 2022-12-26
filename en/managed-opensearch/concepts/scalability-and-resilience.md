# Sharding and replication in {{ mos-name }}

In an {{ OS }} cluster:

- You can use sharding to enable the cluster to scale as the amount of index data grows.
- With replication, you can improve cluster fault tolerance and index data protection (only for multi-host cluster configurations).

## Index sharding {#sharding}

{{ mos-full-name }} uses the standard {{ OS }} index sharding mechanism. For each index, you can create one or more primary shards that index write requests are distributed across. The number of primary shards can only be set when creating an index. You can't change this number afterwards.

{{ OS }} evenly distributes primary shards across the hosts in the cluster. This reduces the load on an individual host and makes it easy to scale the cluster if the load spikes.

## Index replication {#replication}

{{ mos-name }} uses the standard {{ OS }} index replication mechanism. To enable it, when creating an index, specify the replication factor: the number of replicas for each primary shard of the index. As a result, the required number of replica shards is created for each primary shard.

When replication is pre-configured:

- Writing to the index is performed only through the primary shards.
- The index can be read simultaneously from both primary shards and replica shards.

{{ OS }} automatically manages replica shards, moving them between hosts in the cluster if the size of the cluster changes.

The number of replica shards can be modified: unlike primary shards, their number is not fixed when creating an index.
