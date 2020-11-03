# Relationship between service resources

With {{ mkf-full-name }}, you can deploy and maintain {{ KF }} server clusters in the Yandex.Cloud infrastructure.

{{ KF }} is a distributed inter-application communication system that uses the "publication-subscription" principle.

Each {{ mkf-name }} cluster consists of one or more [broker hosts](brokers.md), where [topics](topics.md) and their partitions are located. Cluster hosts may reside in different availability zones. [Learn more about Yandex.Cloud geography](../../overview/concepts/geo-scope.md).

Clients [connect](../operations/connect.md) to the cluster hosts. Clients are data [producers](producers-consumers.md) and [consumers](producers-consumers.md). Producers send messages to certain cluster topics and consumers read messages from them. This ensures that you won't need to re-configure consumers if the producer changes.

For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/intro).
