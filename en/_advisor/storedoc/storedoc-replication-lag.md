### Risk of data loss {#storedoc_replication_lag}

**Description**

The host has a high replication lag, which may result in data loss. Check the load on the master node and replicas and optimize your requests or increase the cluster's computing resources.

**Action**

To increase the cluster's computing resources:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Under **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_resources_5RLrK }}**, select a host class with the required amount of vCPUs.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.