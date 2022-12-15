# Replication and fault tolerance {{ MG }}

{{ mmg-name }} supports replication by default: if a cluster has multiple active hosts, they automatically elect a primary replica to process write queries.

When manually [changing the primary replica](../operations/stepdown.md), {{ MG }} automatically selects a new primary replica from the available hosts.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

For more information about how replication works in {{ MG }}, read the [DBMS documentation](https://docs.mongodb.com/manual/replication/).

## Fault tolerance {#Fault-tolerance}

For cluster hosts to be able to automatically select the primary replica if needed, the vast majority of hosts need to be operable. As a result, it's more cost-efficient to deploy clusters with an odd number of hosts when working with {{ mmg-name }}. For example, a cluster with 3 hosts can't lose more than 1 host and keep working. At the same time, a cluster with 4 hosts also can't lose more than 1: if a second host is lost, the remaining hosts won't be enough to select a new primary replica.

A cluster with 2 hosts doesn't ensure full fault tolerance for the same reason: a single remaining host can't select itself to be the primary replica. In this situation, the cluster can only process read operations.
