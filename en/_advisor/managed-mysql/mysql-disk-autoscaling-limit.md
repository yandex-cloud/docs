### Disk space autoscaling is limited {#mysql_disk_autoscaling_limit}

**Description**

The autoscaling limit has been reached, so the cluster cannot increase its disk space when needed. Update the cluster’s autoscaling settings and increase the limit.

**Action**

To update autoscaling settings:

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. In the advanced **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** cluster settings, select **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** and specify the **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}** percentage to trigger a storage expansion during the next [maintenance window](../../managed-mysql/concepts/maintenance.md#maintenance-window).