---
title: "Как восстановить виртуальную машину из резервной копии"
description: "Следуя данной инструкции, вы сможете восстановить виртуальную машину из резервной копии."
---

# Восстановить виртуальную машину из резервной копии

{% note info %}

Если текущая виртуальная машина неисправна, [создайте](../#connect-vm) новую ВМ с подключением к {{ backup-name }} и [восстановите](non-native-recovery.md) в нее резервную копию.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Напротив резервной копии, из которой нужно восстановить ВМ, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.backup.action_recovery }}**.
  1. В поле **{{ ui-key.yacloud.backup.field_recover-to-vm }}** выберите ВМ, из которой была создана резервная копия. В списке эта ВМ отмечена как `({{ ui-key.yacloud.backup.context_current-vm }})`.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для восстановления ВМ из резервной копии:

      ```bash
      yc backup backups recover --help
      ```

  1. Узнайте идентификатор нужной резервной копии:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Узнайте идентификатор ВМ, которую нужно восстановить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Восстановите ВМ из резервной копии:

      ```bash
      yc backup backups recover \
        --source-backup-id <идентификатор_резервной_копии> \
        --destination-instance-id <идентификатор_ВМ>
      ```

      Где:

      * `--source-backup-id` — идентификатор резервной копии, из которой нужно восстановить ВМ.
      * `--destination-instance-id` — идентификатор ВМ, в которую нужно восстановить резервную копию.

      Результат:

      ```text
      ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/backup/recover.md).

- API {#api}

  Чтобы восстановить виртуальную машину из резервной копии, воспользуйтесь методом REST API [startRecovery](../../backup/api-ref/Backup/startRecovery.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/StartRecovery](../../backup/api-ref/grpc/backup_service.md#StartRecovery).

{% endlist %}

#### См. также {#see-also}

* [{#T}](non-native-recovery.md)