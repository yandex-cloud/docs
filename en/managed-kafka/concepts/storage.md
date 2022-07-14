# Storage types

{% if audience != "internal" %}

{{ mkf-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on [broker servers](brokers.md).

{% include [storage-type-nrd](../../_includes/mdb/mkf/storage-type.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSD storage doesn't provide fault tolerance for a single-host cluster: if a disk fails, the data is permanently lost. To ensure fault tolerance, create clusters of three or more hosts.

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

## Choice of storage type during cluster creation {#storage-type-selection}

The number of broker hosts that can be created together with a {{ KF }} cluster depends on the selected type of storage:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more broker hosts (to ensure fault tolerance, a minimum of three brokers is necessary).
* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of broker hosts within the [current quota](./limits.md).

For more information about limits on the number of broker hosts per cluster, see [{#T}](./limits.md).

{% else %}

{{ mkf-name }} lets you use local storage for database clusters. Local disks are physically located in the database host servers.

When creating a cluster, you can choose between the following storage types:
* Local SSD storage (`local-ssd`): The fastest disks. This storage capacity is between 10 and 2048 GB.
* Standard local disk storage (`local-hdd`): Uses slower but larger disks. Available only for hosts powered by Ice Lake or Cascade Lake processors with at least eight vCPUs.

{% endif %}

## Minimum storage size {#minimal-storage-size}

Each [topic](topics.md#topics) requires space in broker host storage to function. The amount of such space depends on the replication factor and the number of [partitions](./topics.md#partitions). If there is less available storage space, you cannot create a new topic.

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