---
title: "Как удалить снимок диска"
description: "Следуя данной инструкции, вы сможете удалить снимок диска."
---

# Удалить снимок диска

{% note warning %}

Удаление [снимка](../../concepts/snapshot.md) — неотменяемая и необратимая операция, восстановить удаленный снимок невозможно. При удалении снимка удаляется вся хранимая на нем информация. Данные на основном диске останутся без изменений.

{% endnote %}

Чтобы удалить снимок:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите каталог, в котором находится снимок.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/snapshots.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. В строке с нужным снимком нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.snapshots.list.button_action-delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.snapshots.list.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для удаления снимков:

     ```bash
     yc compute snapshot delete --help
     ```

  1. Получите список снимков в каталоге по умолчанию:

     {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.
  1. Удалите снимок:

     ```bash
     yc compute snapshot delete \
       --name first-snapshot
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Если вы создавали снимок диска с помощью {{ TF }}, вы можете удалить его:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Snapshot/delete.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызовом gRPC API [SnapshotService/Delete](../../api-ref/grpc/snapshot_service.md#Delete).

{% endlist %}