После установки агента {{ backup-name }} ВМ будет добавлена в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}** на вкладку **{{ ui-key.yacloud.backup.label_instances }}** раздела **{{ ui-key.yacloud.backup.label_connected-resources }}** и привязана к [политике резервного копирования](../../backup/concepts/policy.md).

Если виртуальная машина не привязалась к политике автоматически, [привяжите](../../backup/operations/policy-vm/attach-and-detach-vm.md) ее вручную.
