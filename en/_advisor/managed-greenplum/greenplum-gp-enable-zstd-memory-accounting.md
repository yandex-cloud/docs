### Risk of exceeding resource manager memory limits {#greenplum_gp_enable_zstd_memory_accounting}

**Description**

The `gp_enable_zstd_memory_accounting` parameter controls memory allocation for the ZSTD algorithm. Enabling it prevents the system from exceeding the resource manager memory limits by allocating ZSTD to a separate `zstd_context`, which significantly reduces the risk of cluster failure due to OOM. We recommend enabling this parameter.

**Action**

To enable the `gp_enable_zstd_memory_accounting` parameter:

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}** and enable `gp_enable_zstd_memory_accounting`.
