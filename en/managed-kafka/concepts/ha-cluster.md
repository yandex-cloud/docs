# High availability of a {{ mkf-name }} cluster

[High availability](../../architecture/fault-tolerance.md#mdb-ha) of a {{ mkf-name }} cluster depends on the number and placement of its hosts, topic settings, and other cluster parameters.

## Number and placement of cluster hosts {#hosts}

The [Service Level Agreement (SLA)]({{ link-sla-kafka }}) defines a high-availability cluster as the one made up of three or more broker hosts residing in different [availability zones](../../overview/concepts/geo-scope.md).

### Single-host cluster {#one-host}

Single-host cluster is both the cheapest and easiest to operate. We recommend to use it for test clusters or production apps where high cluster availability is not critical.

Here is why a single-host cluster is not a high-availability solution:

* If the broker host VM fails, your cluster will be unavailable for reading and writing until the VM is fully recovered.
* Once its host goes to [read-only mode](storage.md#manage-storage-space), your cluster will be unavailable for writing until you manually increase the storage size.

### Two-host cluster {#two-hosts}

For a cluster with two broker hosts, the maximum topic replication factor is two, and the SLA does not apply to such clusters.

Compared to a single-host cluster, a cluster with two hosts offers the following advantages:

* At your application level, you can balance data reads and writes between two broker hosts so your cluster will work faster.
* You can replicate [topic](topics.md) partitions if the topic has a replication factor of `2`. This ensures availability if one of the cluster hosts fails.

To ensure high availability of your cluster under the SLA, you can [increase the number of broker hosts](../operations/cluster-update.md#change-brokers).

### Cluster with three or more hosts {#three-or-more-hosts}

A cluster with three or more hosts offers reliable storage and continuous data availability if each of the three availability zones has at least one broker host. Such a cluster meets the high availability criteria and is subject to the SLA.

To qualify for high availability under the SLA, your cluster topics must have the following parameters:

* **{{ ui-key.yacloud.kafka.label_replication-factor }}**: `3`
* **{{ ui-key.yacloud.kafka.label_min-insync-replicas }}**: `2`

Also, we recommend specifying the `acks=all` parameter in the [producer](producers-consumers.md) configuration. In which case, writing a message to a topic will be considered successful only after {{ KF }} gets a write confirmation from as many broker hosts as specified in the **{{ ui-key.yacloud.kafka.label_min-insync-replicas }}** parameter. For more information, see the [{{ KF }}](https://kafka.apache.org/documentation/#producerconfigs_acks) documentation.

## Cluster availability during maintenance {#maintenance}

The table below lists the possible cluster availability options based on the number of broker hosts.

| **Cluster topology** | **Availability during maintenance** |
| --- | --- |
| One host | Completely unavailable during reboots or updates. |
| Two hosts | Only the rebooting host is temporarily unavailable. When upgrading the {{ KF }} version, cluster topics are unavailable if their replication factor is `1`. |
| Three hosts | Only the rebooting host is temporarily unavailable. |

Consider the expected load on your cluster when selecting the [maintenance window](maintenance.md#maintenance-window).

## Other settings {#other-settings}

High availability of your cluster also depends on the following:

* [Storage disk type](storage.md) you selected.
* [Host classes](instance-types.md).
* [Quotas and limits](limits.md).


### See also {#see-also}

* [{#T}](../../architecture/fault-tolerance.md)
