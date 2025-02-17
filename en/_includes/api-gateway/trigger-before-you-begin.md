To create a trigger, you will need:

* API gateway. Messages will be sent to WebSocket connections accessing the API gateway at the path specified in the trigger settings. If you do not have an API gateway, [create one](../../api-gateway/operations/api-gw-create.md).

    {% note info %}

    The trigger does not call the API gateway when sending messages to WebSocket connections.

    {% endnote %}

* [Service account](../../iam/concepts/users/service-accounts.md) with the `api-gateway.websocketBroadcaster` role. If you do not have a service account, [create one](../../iam/operations/sa/create.md).
