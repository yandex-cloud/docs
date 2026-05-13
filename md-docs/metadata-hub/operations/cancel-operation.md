# Отмена операции

{% list tabs group=instructions %}

- API {#api}
  
  Чтобы отменить операцию для конкретного подключения, воспользуйтесь методом REST API [Operation.Cancel](../connection-manager/api-ref/Operation/cancel.md) или методом gRPC API [OperationService.Cancel](../connection-manager/api-ref/grpc/Operation/cancel.md) и передайте в запросе идентификатор операции.

  Идентификатор операции можно получить со [списком операций](operation-connection.md#operations-list) подключения.

{% endlist %}