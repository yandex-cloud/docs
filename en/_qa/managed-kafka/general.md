#### How do I achieve high cluster availability? {#cluster-fault-tolerance}

Make sure it complies with all the [high availability conditions](../../managed-kafka/concepts/ha-cluster.md).

#### What should do I do if I get this or similar error: "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

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

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85899345920` bytes (80%)

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, [increase the storage size](../../managed-kafka/operations/storage-space.md#change-disk-size).

#### Can I connect to cluster hosts via SSH or get superuser permissions on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get the revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means, when connecting to the website, the service was unable to check whether or not its certificate was listed among revoked ones.

To fix this error:

* Make sure the corporate network settings do not block the check.
* Run the command with the `--ssl-no-revoke` parameter.

   ```powershell
   mkdir $HOME\.kafka; curl.exe --ssl-no-revoke -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
   ```

#### Can I manage a cluster using scripts from an {{ KF }} distribution? {#script-apache-kafka}

Yes, you can, but with some limitations.

For more information about the API types available in a cluster and applicable limitations, see [{#T}](../../managed-kafka/concepts/available-apis.md).

For an example of using scripts, see [{#T}](../../managed-kafka/operations/connect/clients.md).

#### What should I do if the _kafkacat: command not found_ error occurs? {#kafkacat-not-found}

On Ubuntu 24.04 and higher, use `kcat` instead of `kafkacat` (this command will not work).
