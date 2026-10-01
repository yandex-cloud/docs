### High CPU load is detected {#spqr_cpu_idle}

**Description**

The host continuously uses all CPU resources, which may cause delays in query processing. Check the [load](../../storedoc/operations/performance-diagnostics.md) and optimize your queries (which may include using the {{ websql-name }} [AI assistant](../../websql/operations/ai-assistant.md)) or increase computing resources of the cluster.

**Action**

To increase the cluster's computing resources:

1. [Navigate]({{ link-console-main }}/link/managed-spqr) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
1. Under **{{ ui-key.yacloud.spqr.section_infra }}**, select a host class with the required amount of vCPUs.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
