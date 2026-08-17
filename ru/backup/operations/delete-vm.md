---
title: Как удалить виртуальную машину {{ compute-full-name }} из {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете удалить виртуальную машину из {{ backup-name }}.
---

# Удалить виртуальную машину из {{ backup-name }}

При удалении виртуальной машины {{ compute-full-name }} из {{ backup-name }} она остается в {{ compute-full-name }} и продолжает функционировать. [Удаление](../../compute/operations/vm-control/vm-delete.md) ВМ из {{ compute-name }} выполняется отдельно.

{% note info %}

Если вы удаляете ВМ из {{ compute-name }} с помощью консоли управления, она также удалится из {{ backup-name }}. При использовании CLI, {{ TF }} или запроса к API, ВМ останется доступна в {{ backup-name }}.

{% endnote %}

Если после удаления ВМ из {{ backup-name }} вы захотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Windows](connect-vm-windows.md)

Чтобы удалить ВМ из {{ backup-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить ВМ.
  1. [Перейдите]({{ link-console-main }}/link/backup) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. На панели слева выберите ![server](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}** и перейдите на вкладку **{{ ui-key.yacloud_billing.backup.label_instances }}**.
  1. Напротив ВМ, которую вы хотите удалить, нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ВМ из {{ backup-name }}:

      ```bash
      yc backup vm delete --help
      ```

  1. Узнайте идентификатор ВМ, которую нужно удалить:

      {% include [get-vm-id](../../_includes/backup/operations/get-vm-id.md) %}

  1. Удалите ВМ, указав ее идентификатор:

      ```bash
      yc backup vm delete <идентификатор_ВМ>
      ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../backup/api-ref/Resource/delete.md) для ресурса [Resource](../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Delete](../backup/api-ref/grpc/Resource/delete.md).

{% endlist %}
