---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/LoadBalancer/addSniMatch.md
---

# Application Load Balancer API, gRPC: LoadBalancerService.AddSniMatch

Adds a SNI handler to the specified listener.

This request does not allow to add [TlsListener.default_handler](/docs/application-load-balancer/api-ref/grpc/LoadBalancer/get#yandex.cloud.apploadbalancer.v1.TlsListener). Make an [UpdateListener](/docs/application-load-balancer/api-ref/grpc/LoadBalancer/updateListener#UpdateListener) request instead.

## gRPC request

**rpc AddSniMatch ([AddSniMatchRequest](#yandex.cloud.apploadbalancer.v1.AddSniMatchRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddSniMatchRequest {#yandex.cloud.apploadbalancer.v1.AddSniMatchRequest}

```json
{
  "load_balancer_id": "string",
  "listener_name": "string",
  "name": "string",
  "server_names": [
    "string"
  ],
  "handler": {
    // Includes only one of the fields `http_handler`, `stream_handler`
    "http_handler": {
      "http_router_id": "string",
      // Includes only one of the fields `http2_options`, `allow_http10`
      "http2_options": {
        "max_concurrent_streams": "int64"
      },
      "allow_http10": "bool",
      // end of the list of possible fields
      "rewrite_request_id": "bool"
    },
    "stream_handler": {
      "backend_group_id": "string",
      "idle_timeout": "google.protobuf.Duration"
    },
    // end of the list of possible fields
    "certificate_ids": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| load_balancer_id | **string**

Required field. ID of the application load balancer to add a SNI handler to. ||
|| listener_name | **string**

Required field. Name of the listener to add a SNI handler to. ||
|| name | **string**

Required field. Name of the SNI handler to add. ||
|| server_names[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| http_handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

HTTP handler.

Includes only one of the fields `http_handler`, `stream_handler`.

Settings for handling requests. ||
|| stream_handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Stream (TCP) handler.

Includes only one of the fields `http_handler`, `stream_handler`.

Settings for handling requests. ||
|| certificate_ids[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler}

An HTTP handler resource.

#|
||Field | Description ||
|| http_router_id | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/grpc/HttpRouter/list#List) request. ||
|| http2_options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

HTTP/2 settings.

If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2_options`, `allow_http10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allow_http10 | **bool**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2_options`, `allow_http10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| rewrite_request_id | **bool**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

An HTTP/2 options resource.

#|
||Field | Description ||
|| max_concurrent_streams | **int64**

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backend_group_id | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/grpc/BackendGroup/list#List) request. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "load_balancer_id": "string",
    "listener_name": "string",
    "sni_match_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddSniMatchMetadata](#yandex.cloud.apploadbalancer.v1.AddSniMatchMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddSniMatchMetadata {#yandex.cloud.apploadbalancer.v1.AddSniMatchMetadata}

#|
||Field | Description ||
|| load_balancer_id | **string**

ID of the application load balancer that the SNI handler is being added to. ||
|| listener_name | **string**

Name of the listener that the SNI handler is being added to. ||
|| sni_match_name | **string**

Name of the SNI handler that is being added to the listener. ||
|#