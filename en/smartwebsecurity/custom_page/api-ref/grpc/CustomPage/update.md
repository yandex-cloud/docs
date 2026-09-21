---
editable: false
---

# SmartWebSecurity CustomPage API, gRPC: CustomPageService.Update

Updates the specified CustomPage resource.

## gRPC request

**rpc Update ([UpdateCustomPageRequest](#yandex.cloud.smartwebsecurity.v1.custom_page.UpdateCustomPageRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateCustomPageRequest {#yandex.cloud.smartwebsecurity.v1.custom_page.UpdateCustomPageRequest}

```json
{
  "custom_page_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "labels": "map<string, string>",
  "name": "string",
  "description": "string",
  "content": "string",
  "content_type": "string",
  "status_code": "StatusCode",
  "headers": "map<string, string>"
}
```

#|
||Field | Description ||
|| custom_page_id | **string**

Required field. ID of the custom page to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the custom page are going to be updated. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Name of the custom page.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Description of the custom page.

The maximum string length in characters is 512. ||
|| content | **string**

Content of the custom page. ||
|| content_type | **string**

MIME type of the custom page content.

Value must match the regular expression ` [\t\x20-\x7E]* `. ||
|| status_code | enum **StatusCode**

HTTP status code returned with the custom page.

- `OK`: HTTP 200 OK.
- `CREATED`: HTTP 201 Created.
- `ACCEPTED`: HTTP 202 Accepted.
- `NON_AUTHORITATIVE_INFORMATION`: HTTP 203 Non-Authoritative Information.
- `NO_CONTENT`: HTTP 204 No Content.
- `RESET_CONTENT`: HTTP 205 Reset Content.
- `PARTIAL_CONTENT`: HTTP 206 Partial Content.
- `MULTI_STATUS`: HTTP 207 Multi-Status.
- `ALREADY_REPORTED`: HTTP 208 Already Reported.
- `IM_USED`: HTTP 226 IM Used.
- `MULTIPLE_CHOICES`: HTTP 300 Multiple Choices.
- `MOVED_PERMANENTLY`: HTTP 301 Moved Permanently.
- `FOUND`: HTTP 302 Found.
- `SEE_OTHER`: HTTP 303 See Other.
- `NOT_MODIFIED`: HTTP 304 Not Modified.
- `USE_PROXY`: HTTP 305 Use Proxy.
- `TEMPORARY_REDIRECT`: HTTP 307 Temporary Redirect.
- `PERMANENT_REDIRECT`: HTTP 308 Permanent Redirect.
- `BAD_REQUEST`: HTTP 400 Bad Request.
- `UNAUTHORIZED`: HTTP 401 Unauthorized.
- `PAYMENT_REQUIRED`: HTTP 402 Payment Required.
- `FORBIDDEN`: HTTP 403 Forbidden.
- `NOT_FOUND`: HTTP 404 Not Found.
- `METHOD_NOT_ALLOWED`: HTTP 405 Method Not Allowed.
- `NOT_ACCEPTABLE`: HTTP 406 Not Acceptable.
- `PROXY_AUTHENTICATION_REQUIRED`: HTTP 407 Proxy Authentication Required.
- `REQUEST_TIMEOUT`: HTTP 408 Request Timeout.
- `CONFLICT`: HTTP 409 Conflict.
- `GONE`: HTTP 410 Gone.
- `LENGTH_REQUIRED`: HTTP 411 Length Required.
- `PRECONDITION_FAILED`: HTTP 412 Precondition Failed.
- `PAYLOAD_TOO_LARGE`: HTTP 413 Content Too Large.
- `URI_TOO_LONG`: HTTP 414 URI Too Long.
- `UNSUPPORTED_MEDIA_TYPE`: HTTP 415 Unsupported Media Type.
- `RANGE_NOT_SATISFIABLE`: HTTP 416 Range Not Satisfiable.
- `EXPECTATION_FAILED`: HTTP 417 Expectation Failed.
- `MISDIRECTED_REQUEST`: HTTP 421 Misdirected Request.
- `UNPROCESSABLE_ENTITY`: HTTP 422 Unprocessable Content.
- `LOCKED`: HTTP 423 Locked.
- `FAILED_DEPENDENCY`: HTTP 424 Failed Dependency.
- `UPGRADE_REQUIRED`: HTTP 426 Upgrade Required.
- `PRECONDITION_REQUIRED`: HTTP 428 Precondition Required.
- `TOO_MANY_REQUESTS`: HTTP 429 Too Many Requests.
- `REQUEST_HEADER_FIELDS_TOO_LARGE`: HTTP 431 Request Header Fields Too Large.
- `INTERNAL_SERVER_ERROR`: HTTP 500 Internal Server Error.
- `NOT_IMPLEMENTED`: HTTP 501 Not Implemented.
- `BAD_GATEWAY`: HTTP 502 Bad Gateway.
- `SERVICE_UNAVAILABLE`: HTTP 503 Service Unavailable.
- `GATEWAY_TIMEOUT`: HTTP 504 Gateway Timeout.
- `HTTP_VERSION_NOT_SUPPORTED`: HTTP 505 HTTP Version Not Supported.
- `VARIANT_ALSO_NEGOTIATES`: HTTP 506 Variant Also Negotiates.
- `INSUFFICIENT_STORAGE`: HTTP 507 Insufficient Storage.
- `LOOP_DETECTED`: HTTP 508 Loop Detected.
- `NOT_EXTENDED`: HTTP 510 Not Extended.
- `NETWORK_AUTHENTICATION_REQUIRED`: HTTP 511 Network Authentication Required. ||
|| headers | **object** (map<**string**, **string**>)

HTTP response headers returned with the custom page.

The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ``` [!#$%&'*+.^_\x60|~0-9A-Za-z-]* ```. Each value must match the regular expression ` [\t\x20-\x7E]* `. No more than 10 per resource. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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