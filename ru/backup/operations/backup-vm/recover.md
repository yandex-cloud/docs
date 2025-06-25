---
title: Как восстановить ВМ или сервер {{ baremetal-name }} из резервной копии
description: Следуя данной инструкции, вы сможете восстановить виртуальную машину или сервер {{ baremetal-full-name }} из резервной копии.
---

# Восстановить виртуальную машину или сервер {{ baremetal-full-name }} из резервной копии


{% include [vm-and-bms-backup-incompatibility](../../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% include [avoid-errors-when-restoring-from-backup.md](../../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% note tip %}

Если текущая виртуальная машина неисправна, [создайте](../#connect-vm) новую ВМ с подключением к {{ backup-name }} и [восстановите](non-native-recovery.md) в нее резервную копию. Для восстановления из резервной копии новая ВМ должна находиться в [статусе](../../../compute/concepts/vm-statuses.md#list-of-statuses) `Running`.

{% endnote %}

Чтобы восстановить виртуальную машину или сервер {{ baremetal-name }} из резервной копии:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. В зависимости от того, какой ресурс вы хотите восстановить из резервной копии, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с резервной копией, из которой нужно восстановить ВМ или сервер {{ baremetal-name }}, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_recovery }}** или **{{ ui-key.yacloud.backup.action_bms-recovery }}**.
  1. В открывшемся окне выберите виртуальную машину или сервер {{ baremetal-name }}, из которых была создана выбранная резервная копия. В списке эти ВМ или сервер будут отмечены соответственно как `({{ ui-key.yacloud.backup.context_current-vm }})` или `({{ ui-key.yacloud.backup.context_current-bms }})`.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.action_recovery-start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для восстановления ВМ или сервера {{ baremetal-name }} из резервной копии:

      ```bash
      yc backup backups recover --help
      ```

  1. Узнайте идентификатор нужной резервной копии:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Узнайте идентификатор ВМ, которую нужно восстановить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Восстановите ВМ или сервер {{ baremetal-name }} из резервной копии:

      ```bash
      yc backup backups recover \
        --source-backup-id <идентификатор_резервной_копии> \
        --destination-instance-id <идентификатор_ВМ_или_сервера_{{ baremetal-name }}>
      ```

      Где:

      * `--source-backup-id` — идентификатор резервной копии, из которой нужно восстановить ВМ или сервер {{ baremetal-name }}.
      * `--destination-instance-id` — идентификатор ВМ или сервера {{ baremetal-name }}, в которые нужно восстановить резервную копию.

      Результат:

      ```text
      ...1s...6s...11s ... 9m4s...9m9s...done (9m9s)
      ```

      Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/backup/recover.md).

- API {#api}

  Воспользуйтесь методом REST API [startRecovery](../../backup/api-ref/Backup/startRecovery.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/StartRecovery](../../backup/api-ref/grpc/Backup/startRecovery.md).

{% endlist %}

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

#### См. также {#see-also}

* [{#T}](non-native-recovery.md)
