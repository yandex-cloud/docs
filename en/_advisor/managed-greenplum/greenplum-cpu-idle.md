### Risk of reduced performance {#greenplum_cpu_idle}

**Description**

The host continuously uses all CPU resources, which may cause delays in query processing. Check the [load](../../managed-greenplum/operations/monitoring.md) and optimize your queries (which may include using the {{ websql-name }} [AI assistant](../../websql/operations/ai-assistant.md)) or increase computing resources of the cluster.

**Action**

To increase the cluster's computing resources:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**, select a host class with the required amount of vCPUs.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
