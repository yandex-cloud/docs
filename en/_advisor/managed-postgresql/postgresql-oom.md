### Not enough RAM {#postgresql_oom}

**Description**

The cluster is running out of RAM, which leads to slow performance or emergency shutdowns. Increase the cluster's RAM.

**Action**

To increase the amount of RAM:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**, select a host class with the required amount of RAM.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.