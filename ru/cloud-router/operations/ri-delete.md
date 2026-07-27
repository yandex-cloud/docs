---
title: Как удалить виртуальный маршрутизатор в {{ cr-name }}
description: Следуя этой инструкции, вы сможете удалить виртуальный маршрутизатор в {{ cr-name }}.
---

# Удалить виртуальный маршрутизатор

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите]({{ link-console-main }}/link/cloud-router) в сервис **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. В строке с виртуальным маршрутизатором нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  1. Убедитесь, что в виртуальном маршрутизаторе, который должен быть удален, нет других дочерних объектов, например, приватных соединений:
  
      ```bash
      yc cloudrouter routing-instance get c3l87**********1dpin
      ```

  1. Посмотрите описание команды CLI для удаления [виртуального маршрутизатора](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance delete --help
      ```

  1. Удалите виртуальный маршрутизатор:

      ```bash
      yc cloudrouter routing-instance delete c3l87**********1dpin --async
      ```

{% endlist %}
