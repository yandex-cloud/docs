# WebSocket protocol support

{% include [note-preview-pp](../../../_includes/note-preview-pp.md) %}

To connect to an API gateway using the WebSocket protocol, client applications must make a [GET request](https://www.rfc-editor.org/rfc/rfc6455#section-1.3) to the URI for which integrations according to OpenAPI specifications are set up. Integrations are called when the following operations are performed:
* `x-yc-apigateway-websocket-connect`: Open connections.
* `x-yc-apigateway-websocket-message`: Send messages via a web socket.
* `x-yc-apigateway-websocket-disconnect`: Close a connection.

## x-yc-apigateway-websocket-connect operation {#connect}

The operation is performed when a new connection is established. {{ api-gw-name }}calls an integration by performing the operation. If the integration is called successfully, the client is returned a response with the HTTP code `101 Switching Protocol`, after which a web socket is considered open according to the [RFC protocol](https://www.rfc-editor.org/rfc/rfc6455#page-12). Otherwise, an integration returns an error.

For each new web socket, a unique connection ID is generated and returned to the client in the `X-Yc-Apigateway-Websocket-Connection-Id` header. The connection ID is transmitted when an integration is called. To manage an established connection with the [API](../../api-ref/authentication.md), for example, send data to the client's side or close a connection, save the received ID, for example in the [YDB](../../../ydb/index.yaml) database.

Below is a list of headers that are additionally transmitted in an HTTP request to the integration:

- `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
- `X-Yc-Apigateway-Websocket-Event-Type`: Event type, here `CONNECT`.
- `X-Yc-Apigateway-Websocket-Connected-At`: Connection time.

If the {{ sf-name }} function is used as an integration, the above websocket details are passed as individual fields within `requestContext` of a [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

For this operation, you can set up [authorization using a function](../extensions/function-authorizer.md). If authorization fails, the connection isn't established and the client receives a response with the `401` or `403` HTTP code.

Clients can use the [RFC](https://www.rfc-editor.org/rfc/rfc6455#page-12)-specified `Sec-WebSocket-Protocol` header to request subprotocol support from the API gateway. The API gateway passes this header in an HTTP request to an integration.

It isn't a required operation. If the operation isn't defined in the specifications, the HTTP code `101 Switching Protocol` is returned by default after connecting to the client. Add integrations to this operation if you need to:
- Implement special subrotocols for the client and the API gateway to interact.
- Know when a connection is opened and closed.
- Based on authorization, manage who can and can't connect using WebSocket.
- Send messages to the client's side via the [connection managing API](../../api-ref/authentication.md).
- Save the connection ID and other details in the database.

## x-yc-apigateway-websocket-message operation {#message}

The operation is executed when a message from the client's side is sent. {{ api-gw-name }}calls an integration by performing the operation. Data from a websocket is passed in the body of an HTTP request to the integration. Text (UTF-8) and binary messages according to [RFC](https://www.rfc-editor.org/rfc/rfc6455#section-5.6) are supported. In text-based data, the `Content-Type` header gets the `application/json` value, in binary, `application/octet-stream`. If the {{ sf-name }} function is used as an integration, a binary message is encoded in base64, the resulting string value is written in the `body` field of the request [JSON structure](../../../functions/concepts/function-invoke.md#request), and the `isBase64Encoded` parameter is set to `true`.

The body of the integration response is transferred to a web socket to the client's side as an individual message. If the `Content-Type` response from the integration has the `application/json` value or starts with the `text/` prefix, a text message is sent. Otherwise, a binary message is transferred.

The message cannot be larger than 128 KB, and the frame cannot be larger than 32 KB. If a message is larger than 32 KB, it should be split into several frames. If a message or frame exceeds the limit, the connection is closed with the `1009` code.

A unique ID is generated for each message. The message ID is transferred in a special header when the integration is called. The lexicographic message ID order is time-based.

Below is a list of headers that are additionally transmitted in an HTTP request to the integration:

- `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
- `X-Yc-Apigateway-Websocket-Event-Type`: Event type, here `MESSAGE`.
- `X-Yc-Apigateway-Websocket-Message-Id`: Message ID.

If a {{ sf-name }} function is used as an integration, the above message details are passed as individual fields within `requestContext` of a [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

The operation is mandatory, otherwise the corresponding path in the API gateway's OpenAPI specification doesn't support a WebSocket connection.

## x-yc-apigateway-websocket-disconnect operation {#disconnect}

The operation is executed after a connection is closed according to [RFC](https://www.rfc-editor.org/rfc/rfc6455#section-1.4) or terminated. The client or {{ api-gw-name }} may decide to close a connection. {{ api-gw-name }},while executing this operation, always tries to call an integration, but the operation execution cannot be guaranteed.

It isn't a required operation. If you want to be doing something while closing a connection, such as delete data about it from the database, we recommend doing so in the integration that is called when this operation is executed.

Below is a list of headers that are additionally transmitted in an HTTP request to the integration:

- `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
- `X-Yc-Apigateway-Websocket-Event-Type`: Event type, here `DISONNECT`.
- `X-Yc-Apigateway-Websocket-Disconnect-Status-Code`: Status code, see the list of possible codes in the [RFC protocol](https://www.rfc-editor.org/rfc/rfc6455#section-7.4).
- `X-Yc-Apigateway-Websocket-Disconnect-Reason`: Text description of the reason why the connection closed.

If a {{ sf-name }} function is used as an integration, the above details about a closed connection are passed as individual fields within `requestContext` of a [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

Maximum connection lifetime is 60 minutes. A websocket is considered idle if no messages are received through it after 10 minutes. Then the connection closes. You can occasionally send RFC-specified [ping frames](https://www.rfc-editor.org/rfc/rfc6455#section-5.5.2) so that the API gateway considers the connection active and doesn't close it.

Because the connection can be closed for the reasons mentioned above or other reasons, in writing client apps, it's recommended that you provide for automatic reconnection.

## Extension specification {#spec}

Example of a specification with a static response:

```yaml
  /ws:
    x-yc-apigateway-websocket-message:
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': Got new message!
        http_code: 200
        http_headers:
          Content-Type: text/plain
```

Example of a specification with a function call:

```yaml
  /ws:
    x-yc-apigateway-websocket-connect:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95ic**********
        tag: "$latest"
        service_account_id: ajehfe56h**********
    x-yc-apigateway-websocket-message:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95ic**********
        tag: "$latest"
        service_account_id: ajehfe56h**********
    x-yc-apigateway-websocket-disconnect:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: b095c95ic**********
        tag: "$latest"
        service_account_id: ajehfe56h**********
```

#### See also

* [Communicating with an API gateway using the WebSocket protocol](../../tutorials/api-gw-websocket.md).