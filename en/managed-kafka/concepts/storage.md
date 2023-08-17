# Disk types in {{ mkf-name }}


{{ mkf-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on [broker servers](brokers.md).

{% include [storage-type-nrd](../../_includes/mdb/mkf/storage-type.md) %}


## Selecting disk type during cluster creation {#storage-type-selection}

The number of broker hosts that can be created together with a {{ KF }} cluster depends on the selected type of disk:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more broker hosts.

   This cluster will be fail-safe only if it meets all [fault tolerance conditions](index.md#fault-tolerance).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of broker hosts within the current quota.

For more information about limits on the number of broker hosts per cluster, see [{#T}](./limits.md).



## Minimum storage size {#minimal-storage-size}

Each [topic](topics.md#topics) requires space in broker host storage to function. The amount of such space depends on the replication factor and the number of [partitions](topics.md#partitions). If there is less available storage space, you cannot create a new topic.

{% note tip %}

You can always [increase](../operations/cluster-update.md#change-disk-size) the storage size up to the current [quota]({{ link-console-quotas }}).

{% endnote %}

You can calculate the maximum storage size for all topics using the formula below:

`2 × maximum log segment size × number of partitions in cluster × replication factor`.

If topic partitions are evenly distributed, divide the value calculated using the formula by the number of broker hosts.

## Maximum log segment size {#maximum-log-segment-size}

At least two log segments are required for each replica of a topic partition. You can set the maximum size of this segment:
* [At the topic level](../operations/cluster-topics.md#update-topic) by using the [Segment bytes](settings-list.md#settings-topic-segment-bytes) setting.
* Globally at the [cluster level](../operations/cluster-update.md#change-kafka-settings) by using the [Log segment bytes](settings-list.md#settings-log-segment-bytes) setting.

The minimum storage size for all topics is: `2 × the maximum log segment size × the number of partitions per cluster × the replication factor`. If the cluster partitions are evenly distributed, the resulting value can be divided by the number of brokers to determine the required storage size per broker.

By default, the segment size is equal to 1 GB.
