# Maintenance in {{ mmg-name }}

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

Maintenance procedure for {{ mmg-name }} clusters depends on the number of hosts and presence of [shards](sharding.md):

* In non-sharded single-host clusters, maintenance is performed on a [primary replica](replication.md) (master). So, such a cluster becomes unavailable if a primary replica needs to be restarted during maintenance.
* If a non-sharded cluster is comprised of a few hosts, the maintenance procedure is as follows:

   1. Secondary replicas undergo maintenance consecutively. The replicas are queued randomly. A secondary replica becomes unavailable while it's being restarted during maintenance.
   1. A primary replica undergoes maintenance. If it's restarted during maintenance and becomes unavailable, one of the secondary replicas assumes its role.

* In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance is the same as in non-sharded clusters.
