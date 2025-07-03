---
title: Удаление инстанса
description: Следуя данной инструкции, вы сможете удалить инстанс.
---

# Удаление инстанса

Если для инстанса включена защита от удаления, сначала [снимите](instance-update.md) ее, а затем удалите инстанс.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить [инстанс {{ GL }}](../../concepts/index.md#instance).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного инстанса и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы удалить инстанс {{ GL }}, выполните команду:

  ```bash
  {{ yc-mdb-gl }} instance delete <имя_или_идентификатор_инстанса>
  ```

  Идентификатор или имя инстанса можно [запросить](instance-list.md#list) со списком инстансов в каталоге.

  Результат:

  ```text
  done (3m14s)
  ```

  Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/delete.md).

- API {#api}

  Воспользуйтесь методом REST API [Delete](../../api-ref/Instance/delete.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Delete](../../api-ref/grpc/Instance/delete.md).

{% endlist %}

Если вы удалили инстанс, но хотите его восстановить, обратитесь в [техническую поддержку]({{ link-console-support }}). Для удаленного инстанса автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.
