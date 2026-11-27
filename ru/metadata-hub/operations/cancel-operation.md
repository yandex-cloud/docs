---
title: Как отменить операцию конкретного подключения {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как отменить операцию конкретного подключения.
alternate:
  - href: ru/metadata-hub/operations/cancel-operation.md
    type: text/markdown
    title: Markdown version
---

# Отмена операции


{% list tabs group=instructions %}

- API {#api}
  
  Чтобы отменить операцию для конкретного подключения, воспользуйтесь методом REST API [Operation.Cancel](../connection-manager/api-ref/Operation/cancel.md) или методом gRPC API [OperationService.Cancel](../connection-manager/api-ref/grpc/Operation/cancel.md) и передайте в запросе идентификатор операции.

  Идентификатор операции можно получить со [списком операций](operation-connection.md#operations-list) подключения.

{% endlist %}