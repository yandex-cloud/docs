{% note warning %}

{{ mkf-name }} uses ZooKeeper for storing cluster statuses and configurations.
ZooKeeper is automatically installed on the same hosts as [brokers](../../managed-kafka/concepts/brokers.md) {{ KF }} when creating a cluster.

ZooKeeper doesn't require separate hosts or additional configuration.

{% endnote %}

