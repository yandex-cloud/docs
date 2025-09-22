---
title: Как отменить операцию конкретного подключения {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как отменить операцию конкретного подключения.
---

# Отмена операции

{% list tabs group=instructions %}

- API {#api}
  
  Чтобы отменить операцию для конкретного подключения, воспользуйтесь методом REST API [Operation.Cancel](../api-ref/Operation/cancel.md) или методом gRPC API [OperationService.Cancel](../api-ref/grpc/Operation/cancel.md) и передайте в запросе идентификатор операции.

  Идентификатор операции можно получить со [списком операций](operation-connection.md#operations-list) подключения.

{% endlist %}