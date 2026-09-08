### Disk space autoscaling is limited {#valkey_disk_autoscaling_limit}

**Description**

The disk autoscaling limit has been reached, so the cluster cannot increase its disk space when needed. Change the autoscaling settings in the cluster and increase the limit.

**Action**

To increase the disk size:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Specify the maximum storage size after the expansion in the **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** field.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.