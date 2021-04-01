# Replication

Data in {{ mms-name }} clusters is replicated synchronously. A successful response to a write data request
is returned only when the data is written to the disk on both the master host and the priority replica. In the other cluster replicas, data is replicated asynchronously.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

## Selecting the master and a synchronous replica {#selecting-the-master-and-a-synchronous-replica}

The master host and synchronous replica are selected based on the priority that you can [set for a specific host](../operations/hosts.md#update).

In addition, you can configure cascading replication by explicitly assigning a source of replication for each host. The hosts with the set replication source cannot:

* Become synchronous replicas.
* Participate in the selection of a new master host.
* Automatically switch to a new source of replication.

## Write sync and read consistency {#write-sync-and-read-consistency}

