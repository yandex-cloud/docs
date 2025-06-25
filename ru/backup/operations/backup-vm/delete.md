---
title: Удалить резервную копию
description: Из статьи вы узнаете, как удалить резервную копию виртуальной машины или сервера {{ baremetal-full-name }} в **{{ backup-full-name }}**.
---

# Удалить резервную копию


{% note info %}

Чтобы удалить резервные копии, в каталоге должна быть хотя бы одна виртуальная машина или сервер {{ baremetal-name }}, подключенные к сервису {{ backup-name }}. Если таких ВМ или серверов нет, на время [создайте](../create-vm.md) новую ВМ с подключением к {{ backup-name }} и удалите резервные копии.

{% endnote %}

Чтобы удалить резервную копию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. В зависимости от того, резервную копию какого ресурса вы хотите удалить, выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с резервной копией, которую нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления резервной копии:

      ```bash
      yc backup backups delete --help
      ```

  1. Узнайте идентификатор резервной копии, которую нужно удалить:

      {% include [get-backup-id](../../../_includes/backup/operations/get-backup-id.md) %}

  1. Узнайте идентификатор виртуальной машины, резервную копию которой нужно удалить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Удалите резервную копию:

      ```bash
      yc backup backups delete \
        --backup-id <идентификатор_резервной_копии> \
        --instance-id <идентификатор_ВМ_или_сервера_{{ baremetal-name }}>
      ```

      Где:

      * `--backup-id` — идентификатор резервной копии, которую нужно удалить.
      * `--instance-id` — идентификатор виртуальной машины или сервера {{ baremetal-name }}, резервную копию которых нужно удалить.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/backup/delete.md).

- API {#api}

  Воспользуйтесь методом REST API [delete](../../backup/api-ref/Backup/delete.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Delete](../../backup/api-ref/grpc/Backup/delete.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](./batch-delete.md)