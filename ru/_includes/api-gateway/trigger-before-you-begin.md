Для создания триггера вам понадобятся:

* API-шлюз. Сообщения будут отправляться в WebSocket-соединения, подключенные к API-шлюзу. Если у вас нет API-шлюза, [создайте его](../../api-gateway/operations/api-gw-create.md).

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью `api-gateway.websocketBroadcaster`. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).
