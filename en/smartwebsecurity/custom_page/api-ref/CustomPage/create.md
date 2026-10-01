---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/customPages
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the custom page in.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        name:
          description: |-
            **string**
            Name of the custom page.
            The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
          pattern: '[a-zA-Z0-9][a-zA-Z0-9-_.]*'
          type: string
        description:
          description: |-
            **string**
            Description of the custom page.
            The maximum string length in characters is 512.
          type: string
        content:
          description: |-
            **string**
            Content of the custom page.
          type: string
        contentType:
          description: |-
            **string**
            MIME type of the custom page content.
            Value must match the regular expression ` [\t\x20-\x7E]* `.
          pattern: '[\t\x20-\x7E]*'
          type: string
        statusCode:
          description: |-
            **enum** (StatusCode)
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
            - `NETWORK_AUTHENTICATION_REQUIRED`: HTTP 511 Network Authentication Required.
          type: string
          enum:
            - STATUS_CODE_UNSPECIFIED
            - OK
            - CREATED
            - ACCEPTED
            - NON_AUTHORITATIVE_INFORMATION
            - NO_CONTENT
            - RESET_CONTENT
            - PARTIAL_CONTENT
            - MULTI_STATUS
            - ALREADY_REPORTED
            - IM_USED
            - MULTIPLE_CHOICES
            - MOVED_PERMANENTLY
            - FOUND
            - SEE_OTHER
            - NOT_MODIFIED
            - USE_PROXY
            - TEMPORARY_REDIRECT
            - PERMANENT_REDIRECT
            - BAD_REQUEST
            - UNAUTHORIZED
            - PAYMENT_REQUIRED
            - FORBIDDEN
            - NOT_FOUND
            - METHOD_NOT_ALLOWED
            - NOT_ACCEPTABLE
            - PROXY_AUTHENTICATION_REQUIRED
            - REQUEST_TIMEOUT
            - CONFLICT
            - GONE
            - LENGTH_REQUIRED
            - PRECONDITION_FAILED
            - PAYLOAD_TOO_LARGE
            - URI_TOO_LONG
            - UNSUPPORTED_MEDIA_TYPE
            - RANGE_NOT_SATISFIABLE
            - EXPECTATION_FAILED
            - MISDIRECTED_REQUEST
            - UNPROCESSABLE_ENTITY
            - LOCKED
            - FAILED_DEPENDENCY
            - UPGRADE_REQUIRED
            - PRECONDITION_REQUIRED
            - TOO_MANY_REQUESTS
            - REQUEST_HEADER_FIELDS_TOO_LARGE
            - INTERNAL_SERVER_ERROR
            - NOT_IMPLEMENTED
            - BAD_GATEWAY
            - SERVICE_UNAVAILABLE
            - GATEWAY_TIMEOUT
            - HTTP_VERSION_NOT_SUPPORTED
            - VARIANT_ALSO_NEGOTIATES
            - INSUFFICIENT_STORAGE
            - LOOP_DETECTED
            - NOT_EXTENDED
            - NETWORK_AUTHENTICATION_REQUIRED
        headers:
          description: |-
            **object** (map<**string**, **string**>)
            HTTP response headers returned with the custom page.
            The maximum string length in characters for each value is 256. The string length in characters for each key must be 1-128. Each key must match the regular expression ` [!#$%&'*+.^_\x60|~0-9A-Za-z-]* `. Each value must match the regular expression ` [\t\x20-\x7E]* `. No more than 10 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[\t\x20-\x7E]*'
            maxLength: 256
          propertyNames:
            type: string
            pattern: '[!#$%&''*+.^_\x60|~0-9A-Za-z-]*'
            maxLength: 128
            minLength: 1
          maxProperties: 10
      required:
        - folderId
      additionalProperties: false
    definitions: null
---

# SmartWebSecurity CustomPage API, REST: CustomPage.Create

Creates a CustomPage resource in the specified folder.

## HTTP request

```
POST https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/customPages
```

## Body parameters {#yandex.cloud.smartwebsecurity.v1.custom_page.CreateCustomPageRequest}

```json
{
  "folderId": "string",
  "labels": "object",
  "name": "string",
  "description": "string",
  "content": "string",
  "contentType": "string",
  "statusCode": "string",
  "headers": "object"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the custom page in. ||
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
|| contentType | **string**

MIME type of the custom page content.

Value must match the regular expression ` [\t\x20-\x7E]* `. ||
|| statusCode | **enum** (StatusCode)

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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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