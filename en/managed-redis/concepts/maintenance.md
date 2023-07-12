# Maintenance in {{ mrd-name }}

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version is not part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or updating [its settings](../operations/update.md):

* **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (default): Maintenance is possible at any time.
* **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}**: Set the preferred maintenance start time, i.e., the day and time (UTC) you want to perform maintenance at. For example, you can choose a time when the cluster is least loaded.

## Maintenance procedure {#maintenance-order}

Maintenance procedure for {{ mrd-name }} clusters depends on the number of hosts and presence of [shards](sharding.md).

### Non-sharded clusters

Maintenance is performed as follows:

1. [Replica hosts](replication.md) undergo maintenance one by one. The hosts are queued randomly. A replica becomes unavailable while it is being restarted during maintenance.
1. Maintenance is performed on a master host. If it is restarted and becomes unavailable, one of the replicas takes its role. A single-host cluster will be unavailable during its maintenance.

### Sharded clusters

In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance in each shard is the same as in non-sharded clusters:

1. Replica hosts undergo maintenance one by one. The hosts are queued randomly. A replica becomes unavailable while it is being restarted during maintenance.
1. Maintenance is performed on a master host. If it is restarted and becomes unavailable, one of the replicas takes its role. A single-host shard will be unavailable during its maintenance.
