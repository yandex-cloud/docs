---
editable: false
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/LoadBalancer/removeSniMatch.md
---

# Application Load Balancer API, REST: LoadBalancer.RemoveSniMatch {#RemoveSniMatch}

Deletes the specified SNI handler.

This request does not allow to delete [TlsListener.defaultHandler](/docs/application-load-balancer/api-ref/LoadBalancer/get#yandex.cloud.apploadbalancer.v1.TlsListener).

## HTTP request

```
POST https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}:removeSniMatch
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the application load balancer to remove the SNI handler from. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.RemoveSniMatchRequest}

```json
{
  "listenerName": "string",
  "sniMatchName": "string"
}
```

#|
||Field | Description ||
|| listenerName | **string**

Required field. Name of the listener te remove the SNI handler from. ||
|| sniMatchName | **string**

Required field. Name of the SNI handler to remove. ||
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
|| metadata | **[RemoveSniMatchMetadata](#yandex.cloud.apploadbalancer.v1.RemoveSniMatchMetadata)**

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

## RemoveSniMatchMetadata {#yandex.cloud.apploadbalancer.v1.RemoveSniMatchMetadata}

#|
||Field | Description ||
|| loadBalancerId | **string**

ID of the application load balancer that the SNI handler is being removed from. ||
|| listenerName | **string**

Name of the listener that the SNI handler is being removed from. ||
|| sniMatchName | **string**

Name of the SNI handler that is being removed. ||
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