---
editable: false
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/LoadBalancer/addSniMatch.md
---

# Application Load Balancer API, REST: LoadBalancer.AddSniMatch {#AddSniMatch}

Adds a SNI handler to the specified listener.

This request does not allow to add [TlsListener.defaultHandler](/docs/application-load-balancer/api-ref/LoadBalancer/get#yandex.cloud.apploadbalancer.v1.TlsListener). Make an [UpdateListener](/docs/application-load-balancer/api-ref/LoadBalancer/updateListener#UpdateListener) request instead.

## HTTP request

```
POST https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}:addSniMatch
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the application load balancer to add a SNI handler to. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.AddSniMatchRequest}

```json
{
  "listenerName": "string",
  "name": "string",
  "serverNames": [
    "string"
  ],
  "handler": {
    // Includes only one of the fields `httpHandler`, `streamHandler`
    "httpHandler": {
      "httpRouterId": "string",
      // Includes only one of the fields `http2Options`, `allowHttp10`
      "http2Options": {
        "maxConcurrentStreams": "string"
      },
      "allowHttp10": "boolean",
      // end of the list of possible fields
      "rewriteRequestId": "boolean"
    },
    "streamHandler": {
      "backendGroupId": "string",
      "idleTimeout": "string"
    },
    // end of the list of possible fields
    "certificateIds": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| listenerName | **string**

Required field. Name of the listener to add a SNI handler to. ||
|| name | **string**

Required field. Name of the SNI handler to add. ||
|| serverNames[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `serverNames` values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| httpHandler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

HTTP handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| streamHandler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Stream (TCP) handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| certificateIds[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler}

An HTTP handler resource.

#|
||Field | Description ||
|| httpRouterId | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request. ||
|| http2Options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

HTTP/2 settings.

If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allowHttp10 | **boolean**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| rewriteRequestId | **boolean**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

An HTTP/2 options resource.

#|
||Field | Description ||
|| maxConcurrentStreams | **string** (int64)

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/BackendGroup/list#List) request. ||
|| idleTimeout | **string** (duration)

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "loadBalancerId": "string",
    "listenerName": "string",
    "sniMatchName": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddSniMatchMetadata](#yandex.cloud.apploadbalancer.v1.AddSniMatchMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddSniMatchMetadata {#yandex.cloud.apploadbalancer.v1.AddSniMatchMetadata}

#|
||Field | Description ||
|| loadBalancerId | **string**

ID of the application load balancer that the SNI handler is being added to. ||
|| listenerName | **string**

Name of the listener that the SNI handler is being added to. ||
|| sniMatchName | **string**

Name of the SNI handler that is being added to the listener. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#