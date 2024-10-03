---
title: WebSocket protocol support
description: To connect to an API gateway through WebSocket, client applications need to send a GET request to the URI for which integrations are set up as per the OpenAPI specification.
---

# WebSocket protocol support

{% note info %}

{% include [preview-pp.md](../../../_includes/preview-pp.md) %}

{% endnote %}

To connect to an API gateway through WebSocket, client applications need to send a [GET request](https://www.rfc-editor.org/rfc/rfc6455#section-1.3) to the URI for which integrations are set up as per the OpenAPI specification. Integrations are invoked when the following operations are performed:
* `x-yc-apigateway-websocket-connect`: Open connections.
* `x-yc-apigateway-websocket-message`: Send messages through a web socket.
* `x-yc-apigateway-websocket-disconnect`: Close a connection.

## x-yc-apigateway-websocket-connect operation {#connect}

The operation is performed when a new connection is established. {{ api-gw-name }}invokes an integration when performing the operation. If the integration is invoked successfully, the client gets a response with the `101 Switching Protocol` HTTP code, after which a web socket is considered open as per [RFC](https://www.rfc-editor.org/rfc/rfc6455#page-12). Otherwise, an integration returns an error.

For each new web socket, a unique connection ID is generated and returned to the client in the `X-Yc-Apigateway-Websocket-Connection-Id` header. The connection ID is provided when an integration is invoked. To manage an established connection with the [API](../../api-ref/websocket/authentication.md), e.g., send data to the client side or close the connection, save the received ID, for example, to [{{ ydb-full-name }}](../../../ydb/).

Below, you can find a list of headers that are additionally provided in an HTTP request to the integration:
* `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
* `X-Yc-Apigateway-Websocket-Event-Type`: Event type; in our case, it is `CONNECT`.
* `X-Yc-Apigateway-Websocket-Connected-At`: Connection time.

If the {{ sf-full-name }} function is used as an integration, the above websocket details are provided as individual fields within `requestContext` of a [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

For this operation, you can set up [authorization using a function](../extensions/function-authorizer.md). If authorization fails, the connection will not be established and the client will get a response with the `401` or `403` HTTP code.

Clients can use the [RFC](https://www.rfc-editor.org/rfc/rfc6455#page-12)-specified `Sec-WebSocket-Protocol` header to request sub-protocol support from the API gateway. The API gateway provides this header in an HTTP request to an integration.

This operation is not required. If the operation is not defined in the specification, the `101 Switching Protocol` HTTP code is returned by default after connecting to the client. Add integrations to this operation if you need to:
* Implement specific sub-protocols to enable the communication between the client and the API gateway.
* Know when a connection is opened and closed.
* Based on authorization, manage who can and cannot connect using WebSocket.
* Send messages to the client side through the [connection managing API](../../api-ref/websocket/authentication.md).
* Save the connection ID and other details to databases.

## x-yc-apigateway-websocket-message operation {#message}

The operation is run when a message is sent from the client side. {{ api-gw-name }} invokes an integration when performing the operation. Data from a websocket is provided in the body of an HTTP request to the integration. Text (UTF-8) and [RFC](https://www.rfc-editor.org/rfc/rfc6455#section-5.6)-specified binary messages are supported. For text-based data, the `Content-Type` header gets the `application/json` value, while for binary data, it gets `application/octet-stream`. If the {{ sf-name }} function is used as an integration, the binary message is Base64-encoded; the resulting string value is written to the `body` field of the [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request, while the `isBase64Encoded` option is set to `true`.

The body of the integration response is sent to a web socket at the client side as an individual message. If the `Content-Type` response from the integration has the `application/json` value or starts with the `text/` prefix, a text message is sent. Otherwise, a binary message is transferred.

The message cannot be larger than 128 KB, while the frame cannot be larger than 32 KB. If a message is larger than 32 KB, split it into multiple frames. If a message or frame exceeds the limit, the connection is closed with the `1009` code.

A unique ID is generated for each message. The message ID is provided in a special header when the integration is invoked. The alphabetic message ID order is time-based.

Below, you can find a list of headers that are additionally provided in an HTTP request to the integration:
* `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
* `X-Yc-Apigateway-Websocket-Event-Type`: Event type; in our case, it is `MESSAGE`.
* `X-Yc-Apigateway-Websocket-Message-Id`: Message ID.

If a {{ sf-name }} function is used as an integration, the above message details are provided as individual fields within `requestContext` of a [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

This operation is required. Otherwise, the relevant path in the API gateway's OpenAPI specification will not support WebSocket connection.

## x-yc-apigateway-websocket-disconnect operation {#disconnect}

The operation is run after a connection is closed as per [RFC](https://www.rfc-editor.org/rfc/rfc6455#section-1.4) or terminated. The client or {{ api-gw-name }} may decide to close a connection. {{ api-gw-name }}, while running this operation, always tries to invoke an integration; however, the successful run is not guaranteed.

This operation is not required. If you want to do something while closing a connection, such as delete data about it from the database, we recommend doing so in the integration that is invoked when this operation is running.

Below, you can find a list of headers that are additionally provided in an HTTP request to the integration:
* `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
* `X-Yc-Apigateway-Websocket-Event-Type`: Event type; in our case, it is `DISCONNECT`.
* `X-Yc-Apigateway-Websocket-Disconnect-Status-Code`: Status code. For the list of all possible codes, see [RFC protocol](https://www.rfc-editor.org/rfc/rfc6455#section-7.4).
* `X-Yc-Apigateway-Websocket-Disconnect-Reason`: Text description of the reason for which the connection closed.

If a {{ sf-name }} function is used as an integration, the above details about a closed connection are provided as individual fields within `requestContext` of a [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

Maximum connection lifetime is 60 minutes. A websocket is considered idle if no messages are received through it after 10 minutes. Then the connection closes. You can occasionally send RFC-specified [ping frames](https://www.rfc-editor.org/rfc/rfc6455#section-5.5.2) so that the API gateway considers the connection active and does not close it.

Since the connection can be closed for the reasons mentioned above or others, when writing client apps, it is recommended that you enable automatic reconnection.

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

* [Working with an API gateway through WebSocket](../../tutorials/api-gw-websocket.md)