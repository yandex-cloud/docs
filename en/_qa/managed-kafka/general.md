#### How do I ensure my cluster is fault tolerant? {#cluster-fault-tolerance}

Make sure it meets all [fault tolerance conditions](../../managed-kafka/concepts/index.md#fault-tolerance).

#### What do I do if I get an error like "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

The error results from the fact that your topics' log segments take up more space than is available in broker storage. For more information about calculating the required space, see [{#T}](../../managed-kafka/concepts/storage.md#minimal-storage-size).

To solve the issue, you can [increase the disk size](../../managed-kafka/operations/cluster-update.md#change-disk-size) or reduce the [topic](../../managed-kafka/operations/cluster-topics.md#update-topic) segment or [total cluster](../../managed-kafka/operations/cluster-update.md#change-kafka-settings) size.

{% include [logs](../logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I move a cluster to a different network? {#move-cluster}

You cannot move a {{ mkf-name }} cluster to another network.

Here is an alternative solution:

1. Create a new cluster with the same configuration in the target network.
1. Use [MirrorMaker](../../managed-kafka/tutorials/kafka-connectors.md#kf-mirrormaker) to move the topics of the source cluster to the new one.

#### How do I set up an alert that triggers as soon as a certain percentage of disk space has been used up? {#disk-space-percentage}

[Create an alert](../../managed-kafka/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mkf-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of the disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of the disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85899345920` bytes (80%)

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, [increase the storage size](../../managed-kafka/operations/storage-space.md#change-disk-size).

#### Can I connect to cluster hosts via SSH or get superuser permissions on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}