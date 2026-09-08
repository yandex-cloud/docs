### Risk of cluster unavailability {#postgresql_disk_free_space}

**Description**

Your host is critically low on free space. Some operations may be disabled, while the whole cluster may become unavailable, i.e., switch to read-only mode. Increase the disk size or clear unused data.

**Action**

To increase the disk size:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, increase the disk size.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
