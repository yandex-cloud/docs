Activate a backup:

1. Enable **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}**.
1. Select **{{ ui-key.yacloud.compute.components.BackupMethodField.cloudBackup_title_aB1c2 }}**.
1. Under **{{ ui-key.yacloud.compute.components.BackupMethodField.cloudBackup_title_aB1c2 }}**, click **{{ ui-key.yacloud.compute.components.CloudBackupFooter.placeholder_select-policy_cBf3c }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) and, in the list that opens, select the [backup policy](../../backup/concepts/policy.md) that will be used by {{ backup-name }} to work with the VM.

    Optionally, click ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud.compute.components.CloudBackupFooter.button_create-policy_cBf1a }}** to create a new policy.

{% include [vm-creation-user-console-role-notice](./vm-creation-user-console-role-notice.md) %}

{% include [section-backup-additional-info](../compute/create/section-backup-additional-info.md) %}