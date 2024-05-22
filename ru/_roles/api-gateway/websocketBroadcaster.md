Роль `api-gateway.websocketBroadcaster` позволяет отправлять данные через соединения WebSocket, в том числе одновременно нескольким клиентам, а также просматривать список API-шлюзов, информацию о них и о привязках прав доступа ним.

Пользователи с этой ролью могут:
* просматривать информацию о соединениях [WebSocket](../../api-gateway/concepts/index.md#websocket) и закрывать их, а также отправлять данные через соединения WebSocket, в том числе одновременно нескольким клиентам;
* просматривать список [API-шлюзов](../../api-gateway/concepts/index.md), информацию о них и о [привязках](../../iam/concepts/access-control/index.md#access-bindings) прав доступа к ним;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `api-gateway.websocketWriter`.