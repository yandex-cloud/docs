### Risk of losing the coordination service quorum in the event of a zone failure {#clickhouse_ha_keeper}

**Description**

Your coordination service hosts are distributed unevenly: one of the availability zones has too few hosts to form a quorum. If that zone fails, the remaining hosts may lose quorum, blocking leader elections and stopping normal cluster operation. Distribute your hosts across zones so that losing any single zone does not lead to a loss of quorum.

**Action**

To move {{ ZK }} hosts:

1. Create a subnet in the target availability zone for the hosts.
1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
1. [Navigate]({{ link-console-main }}/link/managed-clickhouse) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-coordinator }}**.
1. Specify the new subnet and the availability zone to move the hosts to.
1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

For more information, see [this host migration guide](../../managed-clickhouse/operations/host-migration.md).