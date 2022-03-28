# Storage types

{% if audience != "internal" %}

{{ mkf-name }} lets you use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located on [broker servers](brokers.md).

{% include [storage-type-nrd](../../_includes/mdb/mkf/storage-type.md) %}

## Specifics of local SSD storage {#local-storage-features}

Local SSD storage doesn't provide fault tolerance for a single-host cluster: if a disk fails, the data is permanently lost. To ensure fault tolerance, create clusters of three or more hosts.

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

{% include [nrd-storage-details](../../_includes/mdb/nrd-storage-details.md) %}

{% endif %}

## Minimum storage size {#minimum-disk-size}

There is a limit on the minimum storage size in a cluster, which is the sum of the sizes of all custom topics' log segments. At least two log segments are required for each replica of a topic partition. You can set the maximum size of this segment:

* [At the topic level](../operations/cluster-topics.md#update-topic) by using the [Segment bytes](settings-list.md#settings-topic-segment-bytes) setting.
* Globally [at the cluster level](../operations/cluster-update.md#change-kafka-settings) by using the [Log segment bytes](settings-list.md#settings-log-segment-bytes) setting.

The default value is 1 GB.

The minimum storage size for all topics is: `2 × the maximum log segment size × the number of partitions per cluster × the replication factor`. If the cluster partitions are evenly distributed, the resulting value can be divided by the number of brokers to determine the required storage size per broker.