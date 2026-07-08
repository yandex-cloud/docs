Активируйте резервное копирование:

1. Включите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}**.
1. Выберите вариант **{{ ui-key.yacloud.compute.components.BackupMethodField.cloudBackup_title_aB1c2 }}**.
1. В секции **{{ ui-key.yacloud.compute.components.BackupMethodField.cloudBackup_title_aB1c2 }}** нажмите кнопку **{{ ui-key.yacloud.compute.components.CloudBackupFooter.placeholder_select-policy_cBf3c }}** ![chevron-down](../../_assets/console-icons/chevron-down.svg) и в открывшемся списке выберите [политику резервного копирования](../../backup/concepts/policy.md), которая будет использоваться {{ backup-name }} для работы с ВМ.

    При необходимости нажмите ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud.compute.components.CloudBackupFooter.button_create-policy_cBf1a }}**, чтобы создать новую политику.

{% include [vm-creation-user-console-role-notice](./vm-creation-user-console-role-notice.md) %}

{% include [section-backup-additional-info](../compute/create/section-backup-additional-info.md) %}