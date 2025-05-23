---
title: Как удалить Routing Instance в {{ cr-name }}
description: Следуя этой инструкции, вы сможете удалить Routing Instance в {{ cr-name }}.
---

# Удалить Routing Instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Убедитесь, что в Routing Instance, который должен быть удален, нет других дочерних объектов, например, приватных соединений.
      ```bash
      yc cloudrouter routing-instance get c3l87**********1dpin
      ```

  1. Посмотрите описание команды CLI для удаления [Routing Instance](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance delete --help
      ```

  1. Удалите Routing Instance:

      ```bash
      yc cloudrouter routing-instance delete c3l87**********1dpin --async
      ```

{% endlist %}

