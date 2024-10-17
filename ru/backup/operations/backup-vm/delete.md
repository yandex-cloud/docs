---
title: Удалить резервную копию
description: Из статьи вы узнаете, как удалить резервную копию ВМ в **{{ backup-name }}**.
---

# Удалить резервную копию

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится резервная копия.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![backups](../../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}**.
  1. Напротив резервной копии, которую нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
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

  1. Узнайте идентификатор ВМ, резервную копию которой нужно удалить:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

  1. Удалите резервную копию:

      ```bash
      yc backup backups delete \
        --backup-id <идентификатор_резервной_копии> \
        --instance-id <идентификатор_ВМ>
      ```

      Где:

      * `--backup-id` — идентификатор резервной копии, которую нужно удалить.
      * `--instance-id` — идентификатор ВМ, резервную копию которой нужно удалить.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/managed-services/backup/backup/delete.md).

- API {#api}

  Чтобы удалить резервную копию, воспользуйтесь методом REST API [delete](../../backup/api-ref/Backup/delete.md) для ресурса [Backup](../../backup/api-ref/Backup/index.md) или вызовом gRPC API [BackupService/Delete](../../backup/api-ref/grpc/Backup/delete.md).

{% endlist %}

{% note info %}

Чтобы удалить резервные копии, в каталоге должна быть хотя бы одна виртуальная машина, подключенная к сервису {{ backup-name }}. Если таких ВМ нет, [создайте](../create-vm.md) новую ВМ с подключением к {{ backup-name }} и удалите резервные копии.

{% endnote %}

