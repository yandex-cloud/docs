### Risk of reduced performance {#opensearch_cpu_idle}

**Description**

The host continuously uses all CPU resources, which may cause delays in query processing. Check the [load](../../managed-opensearch/operations/monitoring.md) and optimize your queries (which may include using the {{ websql-name }} [AI assistant](../../websql/operations/ai-assistant.md)) or increase the cluster's computing resources.

**Action**

To increase the cluster's computing resources:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Select a host class with the required amount of vCPUs.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
