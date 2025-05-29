# Planning a cluster topology

When planning your cluster topology, you need to be aware of what can disrupt the cluster and how tolerant your application is of such disruptions.

The possible cluster disruptions include:

1. Scheduled hardware maintenance, including:
   * Upgrading hardware
   * OS, BIOS, and firmware updates
   * OS configuration updates
   * Security updates
1. Unscheduled maintenance when hardware or network infrastructure fails.
1. Problems related to the database engine or user load, such as the following:
   * Not enough RAM
   * Not enough disk space

In the above situations, the cluster behavior will depend on its topology. {{ mpg-full-name }} offers a number of cluster topology options for you to select the most suitable one according to your needs.

For a cluster of two or more hosts to remain available for reading during a master failover, [additional configuration](#cluster-availability) is required.

## Cluster topology options {#topology-options}

{{ mpg-name }} offers the following cluster topology options:

* Single-host cluster
* Two-host cluster
* Cluster with three or more hosts

### Single-host cluster {#one-host-cluster}

Single-host cluster is both the cheapest and easiest to operate. We recommend to use it for test clusters or production apps where high cluster availability is not critical.

Benefits:

* Price: Such a cluster is cheaper than a multi-host one within the same [host class](./instance-types.md).
* Ease of operation: Its master host is always the same, so your app does not need to support [master failover](../operations/connect.md#automatic-master-host-selection).

Disadvantages:

* Single-host clusters are not covered by the [Service level agreement (SLA)](https://yandex.ru/legal/cloud_sla_mdb/).
* A single-host cluster is not fault tolerant. If the master host VM fails, your cluster will be unavailable for reading and writing until the VM recovers completely.
* In the event of a major incident on the master host, your data will be restored from [backups](backup.md). This means you may lose data written between the last backup and master host failure.

#### Use cases {#examples-one-host-cluster}

* [{#T}](../tutorials/data-recording.md)
* [{#T}](../tutorials/datalens.md)

### Two-host cluster {#two-hosts-cluster}

A two-host cluster meets the high availability criteria and is subject to the [SLA](https://yandex.ru/legal/cloud_sla_mdb/). This option is sutable for medium-sized applications in a production environment.

Compared to a single-host cluster, a cluster with two hosts offers the following advantages:

* Balancing load between two hosts when reading data for faster cluster performance.
* Automatic master failover when the current master host is unavailable if the **Autofailover** option is enabled. Until the failover is complete, your cluster will be unavailable for writes for a short time but still readable.

#### Use cases {#examples-two-hosts-cluster}

* [{#T}](../tutorials/data-migration.md)
* [{#T}](../tutorials/fault-tolerance.md)

### Cluster with three or more hosts {#three-or-more-hosts-cluster} 

A cluster with three or more hosts meets the high availability criteria and is subject to the [SLA](https://yandex.ru/legal/cloud_sla_mdb/). This option is the best choice for production environments with high requirements to availability and performance.

Compared to two-host clusters, a cluster with three or more hosts offers the following advantages:

* Quorum [replication](replication.md) instead of synchronous replication, which enables confirming transactions faster with lower risks of unsynchronized data across replicas.

    On average, a transaction is confirmed faster: it must be confirmed by the master host and at least half of the replica hosts.

* You can load-balance read requests between the master and at least two replicas. In addition to speeding up the cluster, this allows your app to send data read requests to specific hosts in that cluster. This way, you can get data faster if your application resides in the same [availability zone](../../overview/concepts/geo-scope.md) as the cluster host.
* Your cluster will be readable even during major {{ PG }} version upgrades.

#### Use cases {#examples-three-or-more-hosts-cluster}

* [{#T}](../tutorials/1c-postgresql.md)

### Cluster availability under different topologies {#cluster-availability}

A cluster is available for writes only if it has [autofailover](../operations/update.md#change-additional-settings) configured. This setting is required for the cluster to restore itself when its master fails or becomes unavailable. Otherwise, the cluster will be unavailable for writes until the master is recovered or you [perform the failover manually](../operations/update.md#start-manual-failover).

The number of hosts listed in the tables includes the master host and replica hosts subject to automatic replication. Replica hosts with [specified replication sources](./replication.md#replication-manual) are not counted.

#|
|| **Cluster topology** | **One host** | **Two hosts** | **Three or more hosts** (`N >= 3`) ||
|| [Available disk types](./storage.md)
|
* `network-hdd`
* `network-ssd`
* `network-ssd-io-m3`
|
* `network-hdd`
* `network-ssd`
* `network-ssd-io-m3`
|
* `network-hdd`
* `network-ssd`
* `network-ssd-io-m3`
* `network-ssd-nonreplicated`
* `local-ssd` ||
|| [Replication mechanism](./replication.md) | Not used | Used by | Used by ||
|| Host roles
|
Master
|
Master and one synchronous replica
|
Master and `N-1` quorum replicas
||
|| Cluster availability during [maintenance](./maintenance.md) or master host failure
| Unavailable for writes and reads
| May not be available for writes until the autofailover is complete
| > ||
|| Cluster availability when [upgrading its {{ PG }} version](../operations/cluster-version-update.md)
| Unavailable for writes and reads | >
| Unavailable for writes with at least one readabale replica
||
|#

## Cluster availability during master failover {#cluster-availability}

If your high availability cluster has the **Autofailover** option enabled and no replication source is specified for at least two hosts, you need to ensure that the cluster is readable during failover. You can do this in any of the following ways:

* Connect to your cluster using [special FQDNs](../operations/connect.md#special-fqdns):

   * For writes, use the [FQDN of the current master host](../operations/connect.md#fqdn-master): `c-<cluster_ID>.rw.mdb.yandexcloud.net`.
   * For reads, use the [FQDN of the most recent replica](../operations/connect.md#fqdn-replica): `c-<cluster_ID>.ro.mdb.yandexcloud.net`.

   While easy to use, this method invovles [DNS](https://en.wikipedia.org/wiki/Domain_Name_System), so it takes extra time to update the DNS record during failover.

* In the app configuration, specify the [FQDNs](../operations/connect.md#fqdn) of all cluster hosts, comma-separated. For reads, specify the `target_session_attrs=any` parameter; for writes, `target_session_attrs=read-write`.

   In this case, you do not need any DNS record updates. If failover time is critical for you, we recommend that you opt for this method.
