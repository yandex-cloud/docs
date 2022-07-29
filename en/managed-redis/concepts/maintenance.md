# Maintenance

Maintenance means:

* Automatic installation of DBMS updates and revisions for hosts (including disabled clusters).
* Changes to the host class and storage size.
* Other maintenance activities.

Maintenance procedure for {{ mrd-name }} clusters depends on the number of hosts and presence of [shards](sharding.md):

* In non-sharded single-host clusters, maintenance is performed on a master host. So, such a cluster becomes unavailable if a master host needs to be restarted during maintenance.
* If a non-sharded cluster is comprised of a few hosts, the maintenance procedure is as follows:

   1. [Replica hosts](replication.md) undergo maintenance consecutively. The hosts are queued randomly. A replica becomes unavailable while it's being restarted during maintenance.
   1. Maintenance is performed on a master host. If it's restarted during maintenance and becomes unavailable, one of the replicas assumes its role.

* In sharded clusters, maintenance is performed shard by shard in ascending order by shard number. Host maintenance is the the same as in non-sharded clusters.

Changing a DBMS version isn't part of maintenance. For more information about version changes, see [{#T}](../operations/cluster-version-update.md).
