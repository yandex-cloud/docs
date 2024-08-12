To create a trigger, you need:

* API gateway. Messages will be sent to WebSocket connections connected to the API gateway. If you do not have an API gateway, [create one](../../api-gateway/operations/api-gw-create.md).

* [Service account](../../iam/concepts/users/service-accounts.md) with the `api-gateway.websocketBroadcaster` role. If you do not have a service account, [create one](../../iam/operations/sa/create.md).
