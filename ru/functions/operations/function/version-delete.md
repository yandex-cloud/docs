---
title: Как удалить версию функции
description: Следуя данной инструкции, вы сможете удалить версию функции.
---

# Удалить версию функции

{% note info %}

Если у версии функции есть [теги](../../concepts/function.md#tag), ее нельзя удалить. [Удалите теги](tag-delete.md) прежде, чем удалять версию функции.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы удалить версию функции, выполните команду:

  ```bash
  yc serverless function version delete <идентификатор_версии_функции>
  ```

- API {#api}

  Чтобы удалить версию функции, воспользуйтесь методом REST API [deleteVersion](../../functions/api-ref/Function/deleteVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/DeleteVersion](../../functions/api-ref/grpc/Function/deleteVersion.md).

{% endlist %}