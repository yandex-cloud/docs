Роль `serverless.eventrouter.supplier` позволяет отправлять пользовательские события в шины, а также передавать события аудита.

Пользователи с этой ролью могут:
* отправлять пользовательские события в [шины](../../../serverless-integrations/concepts/eventrouter/bus.md) с помощью вызова gRPC API [EventService/Send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md);
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md);
* передавать события аудита.