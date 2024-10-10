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

{% endlist %}

Если вы удалили инстанс, но хотите его восстановить, обратитесь в [техническую поддержку]({{ link-console-support }}). Для удаленного инстанса автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.
