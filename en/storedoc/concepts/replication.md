# Replication in {{ SD }}

Replication in a {{ mmg-name }} cluster is enabled when there are two or more [non-hidden](../operations/hosts.md#update) hosts. Each replica host stores a copy of the same dataset.

Types of replicas in a {{ mmg-name }} cluster:
* _Primary replica (master)_: Automatically selected from among non-hidden hosts and accepts all write requests.
* _Secondary replicas_: Asynchronously copy all changes from the primary replica. 

Read requests can be processed both on secondary replicas and the primary replica, depending on the [`readPreference` connection parameter](../operations/connect/clients.md).

## Primary replica failover {#master-failover}

If the primary replica fails or is [switched over manually](../operations/stepdown.md), {{ SD }} will automatically select a new primary replica from among the non-hidden hosts.

You can influence the primary replica selection in a {{ SD }} cluster by [configuring priorities](../operations/hosts.md#update) for cluster hosts. The highest priority host will become the new primary replica.

You can set the host priority using the YC CLI, API, or {{ TF }}:

* When [creating a cluster](../operations/cluster-create.md) or [a host in a cluster](../operations/hosts.md#add).
* When [changing the host settings](../operations/hosts.md#update).

The default priority value of `1` represents the lowest priority. The minimum value is `0`. A host with this priority level cannot become the primary replica, even for absence of other suitable hosts in the cluster. The maximum value is `1000`. Only integer values can be used.
