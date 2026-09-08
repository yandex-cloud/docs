### Risk of reduced performance {#valkey_main_thread}

**Description**

The host continuously uses all CPU resources in `main thread`, which may cause delays in query processing. Check the [load](../../managed-valkey/operations/monitoring.md) and optimize your queries, including those sent via the [AI assistant](../../websql/operations/ai-assistant.md), or increase the computing resources allocated to your cluster.

**Action**

To increase the cluster computing resources:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**, select a host class with the required amount of vCPUs.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
