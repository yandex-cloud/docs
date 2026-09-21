[Документация Yandex Cloud](../../../../../index.md) > [Yandex Smart Web Security](../../../../index.md) > Справочник API > gRPC (англ.) > [SmartWebSecurity CustomPage API](../index.md) > [CustomPage](index.md) > List

# SmartWebSecurity CustomPage API, gRPC: CustomPageService.List

Retrieves the list of CustomPage resources in the specified folder.

## gRPC request

**rpc List ([ListCustomPagesRequest](#yandex.cloud.smartwebsecurity.v1.custom_page.ListCustomPagesRequest)) returns ([ListCustomPagesResponse](#yandex.cloud.smartwebsecurity.v1.custom_page.ListCustomPagesResponse))**

## ListCustomPagesRequest {#yandex.cloud.smartwebsecurity.v1.custom_page.ListCustomPagesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list custom pages in. ||
|| page_size | **int64**

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set to the `next_page_token` returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters custom pages listed in the response.

The maximum string length in characters is 1000. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction.

The maximum string length in characters is 100. ||
|#

## ListCustomPagesResponse {#yandex.cloud.smartwebsecurity.v1.custom_page.ListCustomPagesResponse}

```json
{
  "custom_pages": [
    {
      "id": "string",
      "folder_id": "string",
      "cloud_id": "string",
      "labels": "map<string, string>",
      "name": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "content": "string",
      "content_type": "string",
      "status_code": "StatusCode",
      "headers": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| custom_pages[] | **[CustomPage](#yandex.cloud.smartwebsecurity.v1.custom_page.CustomPage)**

List of custom page resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
|#

## CustomPage {#yandex.cloud.smartwebsecurity.v1.custom_page.CustomPage}

A custom page resource.

#|
||Field | Description ||
|| id | **string**

ID of the custom page. ||
|| folder_id | **string**

ID of the folder that the custom page belongs to. ||
|| cloud_id | **string**

ID of the cloud that the custom page belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Name of the custom page.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Description of the custom page.

The maximum string length in characters is 512. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the custom page was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the custom page was last updated. ||
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