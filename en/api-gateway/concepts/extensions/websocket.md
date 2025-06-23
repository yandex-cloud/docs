---
title: WebSocket protocol support
description: To connect to an API gateway via WebSocket, client applications need to send a GET request to the URI for which integrations are set up in the OpenAPI specification.
---

# WebSocket protocol support

{% include [note-preview-pricing.md](../../../_includes/mdb/mgp/cloud-storage-preview.md) %}

To connect to an API gateway via WebSocket, client applications need to send a [GET request](https://www.rfc-editor.org/rfc/rfc6455#section-1.3) to the URI for which integrations are set up in the OpenAPI specification. Integrations are invoked when the following operations are performed:
* `x-yc-apigateway-websocket-connect`: Opening a connection.
* `x-yc-apigateway-websocket-message`: Sending messages via a web socket.
* `x-yc-apigateway-websocket-disconnect`: Closing a connection.

{{ api-gw-name }} does not limit the number of WebSocket connections per API gateway.

Messages sent to clients (e.g., using the [Send](../../apigateway/websocket/api-ref/grpc/Connection/send.md) gRPC API call) and the pings within WebSocket connections are free of charge.

## x-yc-apigateway-websocket-connect operation {#connect}

The operation is performed when a new connection is established. {{ api-gw-name }} invokes an integration when performing the operation. If the integration is invoked successfully, the client gets a response with the `101 Switching Protocol` HTTP code, after which a web socket is considered open as per [RFC](https://www.rfc-editor.org/rfc/rfc6455#page-12). Otherwise, the integration returns an error.

For each new web socket, a unique connection ID is generated and returned to the client in the `X-Yc-Apigateway-Websocket-Connection-Id` header. The connection ID is provided when an integration is invoked. To manage an established connection with the [API](../../api-ref/websocket/authentication.md), e.g., send data to the client or close the connection, save the received ID, e.g., to a [{{ ydb-full-name }}](../../../ydb/) database.

Below, you can find a list of headers that are additionally provided in an HTTP request to the integration:
* `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
* `X-Yc-Apigateway-Websocket-Event-Type`: Event type; in our case, it is `CONNECT`.
* `X-Yc-Apigateway-Websocket-Connected-At`: Connection time.

If a {{ sf-full-name }} function is used as an integration, the above websocket details are provided as individual fields within `requestContext` in the [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

For this operation, you can set up [authorization using a function](../extensions/function-authorizer.md). If authorization fails, the connection will not be established and the client will get a response with the `401` or `403` HTTP code.

As per [RFC](https://www.rfc-editor.org/rfc/rfc6455#page-12), clients can use the `Sec-WebSocket-Protocol` header to request subprotocol support from the API gateway. The API gateway provides this header in an HTTP request to an integration.

This operation is optional. If the operation is not defined in the specification, the `101 Switching Protocol` HTTP code is returned by default after connecting to the client. Add integrations to this operation if you need to:
* Implement specific subprotocols to enable communication between a client and an API gateway.
* Know when a connection is opened and closed.
* Based on authorization, manage who can and cannot connect using WebSocket.
* Send messages to the client through the [connection managing API](../../api-ref/websocket/authentication.md).
* Save the connection ID and other details to databases.

## x-yc-apigateway-websocket-message operation {#message}

The operation is run when a message is sent from the client side. {{ api-gw-name }} invokes an integration when performing the operation. Data from a websocket is provided in the body of an HTTP request to the integration. As per [RFC](https://www.rfc-editor.org/rfc/rfc6455#section-5.6), text (UTF-8) and binary messages are supported. For text data, the `Content-Type` header gets the `application/json` value, while for binary data, it gets `application/octet-stream`. If a {{ sf-name }} function is used as an integration, the binary message is Base64-encoded; the resulting string value is written to the `body` field of the request’s [JSON structure](../../../functions/concepts/function-invoke.md#request), while the `isBase64Encoded` flag is set to `true`.

The body of the integration response is sent to a web socket at the client side as an individual message. If the `Content-Type` header in the integration response has the `application/json` value or it is prefixed with `text/`, a text message will be sent. Otherwise, this will be a binary message.

The maximum message size is 128 KB, while the maximum frame size is 32 KB. If a message is larger than 32 KB, split it into multiple frames. If a message or frame exceeds the limit, the connection is closed with the `1009` code.

A unique ID is generated for each message. The message ID is provided in a special header when the integration is invoked. The alphabetic message ID order is time-based.

Below, you can find a list of headers that are additionally provided in an HTTP request to the integration:
* `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
* `X-Yc-Apigateway-Websocket-Event-Type`: Event type; in our case, it is `MESSAGE`.
* `X-Yc-Apigateway-Websocket-Message-Id`: Message ID.

If a {{ sf-name }} function is used as an integration, the above message details are provided as individual fields within `requestContext` in the [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

This is a required operation. Otherwise, the relevant path in the API gateway's OpenAPI specification will not support a WebSocket connection.

## x-yc-apigateway-websocket-disconnect operation {#disconnect}

The operation is run after a connection is closed as per [RFC](https://www.rfc-editor.org/rfc/rfc6455#section-1.4) or terminated. Connection may be closed by the client or {{ api-gw-name }}. When performing this operation,{{ api-gw-name }} always tries to invoke an integration, but the operation still cannot be guaranteed.

This operation is optional. If you perform any operation while closing a connection, e.g., delete data about it from the database, we recommend doing so in the integration invoked when performing that operation.

Below, you can find a list of headers that are additionally provided in an HTTP request to the integration:
* `X-Yc-Apigateway-Websocket-Connection-Id`: Connection ID.
* `X-Yc-Apigateway-Websocket-Event-Type`: Event type; in our case, it is `DISCONNECT`.
* `X-Yc-Apigateway-Websocket-Disconnect-Status-Code`: Status code. For the list of all possible codes, see the [RFC protocol](https://www.rfc-editor.org/rfc/rfc6455#section-7.4).
* `X-Yc-Apigateway-Websocket-Disconnect-Reason`: Text description of the reason for closing the connection.

If a {{ sf-name }} function is used as an integration, the above details about a closed connection are provided as individual fields within `requestContext` in the [JSON structure](../../../functions/concepts/function-invoke.md#request) of the request to the function.

The maximum connection lifetime is 60 minutes. A websocket is considered idle if no messages are received through it for 10 minutes. Then the connection is closed. You can occasionally send RFC-specified [ping frames](https://www.rfc-editor.org/rfc/rfc6455#section-5.5.2) so that the API gateway considers the connection active and does not close it.

Since the connection can be closed for the reasons mentioned above or others, when writing client apps, we recommend enabling automatic reconnection.

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

## Use cases {#examples}

* [{#T}](../../tutorials/api-gw-websocket.md)
