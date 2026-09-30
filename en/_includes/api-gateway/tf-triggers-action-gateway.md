* `action`: Target settings. You can specify this section multiple times so the trigger calls multiple resources, including those of different types. There are [limits](../../api-gateway/concepts/limits.md#api-gw-limits) on the maximum number of resources.

    * `gateway_websocket_broadcast`: API gateway settings:

        * `gateway_id`: API gateway ID.
        * `path`: Path in the OpenAPI specification. Events will be sent through WebSocket connections established using this path.
        * `service_account_id`: ID of the service account with permissions to send events to WebSocket connections.
    
    {% include [tf-trigger-params](../functions/tf-trigger-params.md) %}