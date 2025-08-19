---
title: Как получить информацию об операции {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как получить информацию об операции.
---

# Получение информации об операции


{% include notitle [preview](../../_includes/note-preview.md) %}


## Получить список операций для конкретного подключения {#operations-list}

{% include [connection-manager-operations](../../_includes/metadata-hub/connection-manager-operations.md) %}

## Получить информацию о конкретной операции {#operation}

{% list tabs group=instructions %}

- API {#api}
  
  Чтобы получить информацию о конкретной операции, воспользуйтесь методом REST API [Operation.Get](../api-ref/Operation/get.md) или методом gRPC API [OperationService.Get](../api-ref/grpc/Operation/get.md) и передайте в запросе идентификатор операции.

  Идентификатор операции можно получить со [списком операций](operation-connection.md#operations-list) подключения.

{% endlist %}
