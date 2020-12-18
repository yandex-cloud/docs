# Relationship between service resources

With {{ mkf-full-name }}, you can deploy and maintain {{ KF }} server clusters in the {{ yandex-cloud }} infrastructure.

{{ KF }} is a distributed inter-application communication system that uses the "publication-subscription" principle.

Each {{ mkf-name }} cluster consists of one or more [broker hosts](brokers.md), where [topics](topics.md) and their partitions are located. Cluster hosts may reside in different availability zones. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

Clients [connect](../operations/connect.md) to the cluster hosts. Clients are data [producers](producers-consumers.md) and [consumers](producers-consumers.md). Producers send messages to certain cluster topics and consumers read messages from them. This ensures that you won't need to re-configure consumers if the producer changes.

Depending on the number of broker hosts in the cluster, {{ ZK }} is automatically configured and hosted:

- If the {{ KF }} cluster consists of one broker host, {{ ZK }} is hosted on the same host.
- If the {{ KF }} cluster consists of two or more broker hosts, {{ ZK }} is hosted on three dedicated hosts. These hosts are added to the cluster automatically.

You can't change or delete {{ ZK }} hosts. The number of {{ZK}} hosts is also fixed. {{ mkf-name }} uses {{ ZK }} for storing cluster statuses and configurations.

{% note info %}

The following characteristics are set for the {{ ZK }} hosts by default:

* [Host class](instance-types.md) `b2.medium`.
* 10 GB disk size.
* [Storage type](storage.md): Fast network storage.

{% endnote %}

For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/intro).
