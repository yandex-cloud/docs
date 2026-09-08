### Disk space autoscaling is not configured {#opensearch_disk_autoscaling}

**Description**

Disk space autoscaling is not configured in shards. Configure autoscaling to prevent disk overflow.

**Action**

To increase the disk size:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. In the **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** field, set the conditions for autoscaling.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.