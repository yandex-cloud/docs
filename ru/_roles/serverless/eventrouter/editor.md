Роль `serverless.eventrouter.editor` позволяет управлять шинами, коннекторами и правилами, а также отправлять в шины пользовательские и аудитные события.

Пользователи с этой ролью могут:
* просматривать информацию о [шинах](../../../serverless-integrations/concepts/eventrouter/bus.md) и назначенных [правах доступа](../../../iam/concepts/access-control/index.md) к ним, а также создавать, изменять и удалять шины;
* просматривать информацию о [коннекторах](../../../serverless-integrations/concepts/eventrouter/connector.md) и назначенных правах доступа к ним, а также создавать, изменять и удалять коннекторы;
* просматривать информацию о [правилах](../../../serverless-integrations/concepts/eventrouter/rule.md) и назначенных правах доступа к ним, а также создавать, изменять и удалять правила;
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md);
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md);
* передавать события аудита.

Включает разрешения, предоставляемые ролями `serverless.eventrouter.viewer` и `serverless.eventrouter.supplier`.