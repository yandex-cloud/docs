Роль `serverless.eventrouter.admin` позволяет управлять шинами, коннекторами, правилами и доступом к ним, а также отправлять в шины пользовательские и аудитные события.

Пользователи с этой ролью могут:
* просматривать информацию о [шинах](../../../serverless-integrations/concepts/eventrouter/bus.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](../../../iam/concepts/access-control/index.md) к шинам, а также изменять такие права доступа;
* просматривать информацию о [коннекторах](../../../serverless-integrations/concepts/eventrouter/connector.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к коннекторам, а также изменять такие права доступа;
* просматривать информацию о [правилах](../../../serverless-integrations/concepts/eventrouter/rule.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к правилам, а также изменять такие права доступа;
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md);
* отправлять пользовательские события в шины с помощью вызова gRPC API [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md);
* передавать события аудита;
* просматривать информацию о [квотах](../../../serverless-integrations/concepts/limits.md#eventrouter) EventRouter.

Включает разрешения, предоставляемые ролью `serverless.eventrouter.editor`.