# get method

Returns an object from {{ objstorage-name }}.

## Request {#request}

```
GET /{bucket}/{key} HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `response-content-type` | Sets the `Content-Type` response header. |
| `response-content-language` | Sets the `Content-Language` response header. |
| `response-expires` | Sets the `Expires` response header. |
| `response-cache-control` | Sets the `Cache-Control` response header. |
| `response-content-disposition` | Sets the `Content-Disposition` response header. |
| `response-content-encoding` | Sets the `Content-Encoding` response header. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

You can also use the following headers in requests:

| Header | Description |
| ----- | ----- |
| `Range` | Sets the byte range to be uploaded from the object.<br/><br/>For more information about the Range header, see the HTTP specification [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35). |
| `If-Modified-Since` | If specified, {{ objstorage-name }} returns:<br/>- The object. If it has been modified since the specified time.<br/>- Code 304. If the object hasn't been modified since the specified time.<br/><br/>If a request has both the `If-Modified-Since` and `If-None-Match` headers and their checks result in `If-Modified-Since -> true` and `If-None-Match -> false`, then {{ objstorage-name }} returns a 304 code. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |
| `If-Unmodified-Since` | If specified, {{ objstorage-name }} returns:<br/>- The object. If it has not been modified since the specified time.<br/>- Code 412. If the object hasn't been modified since the specified time.<br/><br/>If a request has both the `If-Unmodified-Since` and `If-Match` headers and their checks result in `If-Unmodified-Since -> false` and `If-Match -> true`, then {{ objstorage-name }} returns a 200 code and the requested data. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |
| `If-Match` | If specified, {{ objstorage-name }} returns:<br/>- The object. If its `ETag` matches the sent one.<br/>- Code 412. If its `ETag` doesn't match the one sent.<br/><br/><br/>If a request has both the `If-Unmodified-Since` and `If-Match` headers and their checks result in `If-Unmodified-Since -> false` and `If-Match -> true`, then {{ objstorage-name }} returns a 200 code and the requested data. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |
| `If-None-Match` | If specified, {{ objstorage-name }} returns:<br/>- The object. If its `ETag` doesn't match the sent one.<br/>- Code 304. If its `ETag` matches the one sent.<br/><br/><br/>If a request has both the `If-Modified-Since` and `If-None-Match` headers and their checks result in `If-Modified-Since -> true` and `If-None-Match -> false`, then {{ objstorage-name }} returns a 304 code. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |

## Response {#response}

### Headers {#response-headers}

In addition to [common response headers](../common-response-headers.md), responses may have headers listed in the table below.

| Header | Description |
| ----- | ----- |
| `x-amz-meta-*` | User-defined object metadata that is stored with the object. |
| `x-amz-storage-class` | Object storage class.<br/>The value is `COLD` if the object is stored in cold storage.<br/><br/>If it is stored in standard storage, the header is omitted. |

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

