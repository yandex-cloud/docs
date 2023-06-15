# Maintenance in {{ mrd-name }}

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or updating [its settings](../operations/update.md):

* **Unspecified time** (default): Maintenance is possible at any time.
* **On schedule**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

Maintenance procedure for {{ mrd-name }} clusters depends on the number of hosts and presence of [shards](sharding.md):

* In non-sharded single-host clusters, maintenance is performed on a master host. Therefore, it may become unavailable in case it is restarted.
* If a non-sharded cluster is comprised of a few hosts, the maintenance procedure is as follows:

   1. [Replica hosts](replication.md) undergo maintenance one by one. The hosts are queued randomly. A replica becomes unavailable while it is being restarted during maintenance.
   1. Maintenance is performed on a master host. If it is restarted and becomes unavailable, one of the replicas takes its role.

* In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance is the the same as in non-sharded clusters.
