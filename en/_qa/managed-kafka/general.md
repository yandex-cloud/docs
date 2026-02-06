#### How do I achieve high cluster availability? {#cluster-fault-tolerance}

Make sure it complies with all the [high availability conditions](../../managed-kafka/concepts/ha-cluster.md).

#### What should I do if I get this or similar error: "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

This error occurs because the log segments of your topics use more space than the broker storage can provide. For more information about calculating the required space, see [{#T}](../../managed-kafka/concepts/storage.md#minimal-storage-size).

To solve this issue, you can [increase the disk storage size](../../managed-kafka/operations/cluster-update.md#change-disk-size) for the [entire cluster](../../managed-kafka/operations/cluster-update.md#change-kafka-settings) or reduce the [topic](../../managed-kafka/operations/cluster-topics.md#update-topic) segment size.

{% include [logs](../logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I move a cluster to a different network? {#move-cluster}

You cannot move a {{ mkf-name }} cluster to different network.

Here is an alternative solution:

1. Create a new cluster with the same configuration in the target network.
1. Use [MirrorMaker](../../managed-kafka/tutorials/kafka-connectors.md#kf-mirrormaker) to move the topics of your source cluster to the new cluster.

#### How do I set up an alert that triggers as soon as a certain percentage of disk space is used up? {#disk-space-percentage}

[Create an alert](../../managed-kafka/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mkf-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Their recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85899345920` bytes (80%)

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, [expand the storage](../../managed-kafka/operations/storage-space.md#change-disk-size).

#### Can I connect to cluster hosts over SSH or get superuser privileges on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get a revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means that when connecting to the website, the service was unable to check whether or not its certificate was listed among revoked ones.

To fix this error:

* Make sure your corporate network policies are not blocking the check.
* Run the command with the `--ssl-no-revoke` parameter:

   ```powershell
   mkdir $HOME\.kafka; curl.exe --ssl-no-revoke -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
   ```

#### Can I manage a cluster using scripts from an {{ KF }} distribution? {#script-apache-kafka}

Yes, you can, but with some limitations.

For more information about the API types available in a cluster and applicable limitations, see [{#T}](../../managed-kafka/concepts/available-apis.md).

For an example of using scripts, see [{#T}](../../managed-kafka/operations/connect/clients.md).

#### What should I do if the _kafkacat: command not found_ error occurs? {#kafkacat-not-found}

On Ubuntu 24.04 and higher, use `kcat` instead of `kafkacat` (this command will not work).

#### Will Karapace be available during maintenance? {#karapace-maintenance}

{% include [karapace-maintenance](../../_includes/mdb/mkf/karapace-maintenance.md) %}

#### Is Karapace's endpoint constant or does it vary depending on the broker? {#karapace-endpoint}

{% include [karapace](../../_includes/mdb/mkf/karapace.md) %}

#### What is the role of {{ mkf-short-name }} in database management and maintenance? {#services}

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### How do I track message loss in an {{ KF }} topic? {#lost-messages}

If a topic uses the `Delete` log cleanup policy with a short segment lifetime, messages may be deleted before the [consumer group](../../managed-kafka/concepts/producers-consumers.md#consumer-groups) reads them. You can monitor message loss using {{ mkf-name }} [metrics](../../managed-kafka/metrics.md) delivered to [{{ monitoring-name }}](../../monitoring/concepts/index.md).

To monitor message loss:

1. Use [{{ monitoring-full-name }}]({{ link-monitoring }}) to [plot](../../monitoring/operations/metric/metric-explorer.md#add-graph) the `kafka_group_topic_partition_offset` and `kafka_log_Log_LogStartOffset` metrics on the same chart:
   * For `kafka_group_topic_partition_offset`, specify these labels:
       * `service = managed-kafka`
       * `name = kafka_group_topic_partition_offset`
       * `host = <host_FQDN>`
       * `topic = <topic_name>`
       * `partition = <partition_number>`
       * `group = <consumer_group_name>`
   * For `kafka_log_Log_LogStartOffset`, specify these labels: 
       * `service = managed-kafka`
       * `name = kafka_log_Log_LogStartOffset`
       * `host = <host_FQDN>`
       * `topic = <topic_name>`
       * `partition = <partition_number>`
1. Wait until the number of messages written to the topic is enough for analysis.
1. Navigate to [{{ monitoring-full-name }}]({{ link-monitoring }}) and review the behavior of the previously created metrics:
   * If the `kafka_log_Log_LogStartOffset` value is higher than `kafka_group_topic_partition_offset` within the entire monitoring period, the selected consumer group will have enough time to read all new messages from the specified topic segment.
   * `kafka_group_topic_partition_offset` falling below `kafka_log_Log_LogStartOffset` signals a message loss.

For more information, see [{#T}](../../managed-kafka/tutorials/retention-policy.md).
