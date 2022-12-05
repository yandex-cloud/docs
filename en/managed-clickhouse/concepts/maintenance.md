# Maintenance in {{ mch-name }}

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Changing a major DBMS version isn't part of maintenance. For more information about major version changes, see [{#T}](../operations/cluster-version-update.md).

## Maintenance window {#maintenance-window}

You can set the preferred maintenance time when [creating a cluster](../operations/cluster-create.md) or updating [its settings](../operations/update.md):

* **Unspecified time** (default): Maintenance is possible at any time.
* **By schedule**: Set the preferred maintenance start time: desired day of the week and UTC hour. For example, you can choose a time when cluster load is lightest.

## Maintenance procedure {#maintenance-order}

Maintenance procedure for {{ mch-name }} clusters depends on the number of [shards](sharding.md) and hosts in the shards:

* In single-host clusters, maintenance is performed on a single {{ CH }} host. So, such a cluster becomes unavailable if a single host needs to be restarted during maintenance.
* If a cluster consists of a few {{ CH }} hosts in a single shard, [host replicas](replication.md) undergo maintenance consecutively. The hosts are queued randomly. If a host needs to be restarted during maintenance, it becomes unavailable while it's being restarted. If you access the cluster using the FQDN or IP address of the {{ CH }} host, such a cluster may become unavailable. To make your application continuously available, access the cluster using a [special FQDN](../operations/connect.md#auto) always pointing to the available host.
* If a cluster consists of multiple shards, maintenance is performed shard by shard in ascending order by shard number. Maintenance is first performed on hosts of one shard, then two shards, four, and so on, up to ten. Host maintenance is the the same as in clusters with a single shard. If you access the cluster shard using the FQDN or IP address of the {{ CH }} host, such a shard may become unavailable. To make your application continuously available, access the shard using a [special FQDN](../operations/connect.md#auto), always pointing to the available host in a shard.
