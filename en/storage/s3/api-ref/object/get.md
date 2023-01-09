# get method

Returns an object from {{ objstorage-name }}.


## Request {#request}

```
GET /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. |


### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `response-content-type` | Sets the `Content-Type` response header. |
| `response-content-language` | Sets the `Content-Language` response header. |
| `response-expires` | Sets the `Expires` response header. |
| `response-cache-control` | Sets the `Cache-Control` response header. |
| `response-content-disposition` | Sets the `Content-Disposition` response header. |
| `response-content-encoding` | Sets the `Content-Encoding` response header. |
| `versionId` | Link to a specific version of the object. |


### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

You can also use the following headers in requests:

| Header | Description |
----- | -----
| `Range` | Sets the byte range to be uploaded from the object.<br/><br/>For more information about the Range header, see the HTTP specification [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35). |
| `If-Modified-Since` | If specified, {{ objstorage-name }} returns:<br/>- Object. If it has been modified since the specified time.<br/>- Code 304. If the object hasn't been modified since the specified time.<br/><br/>If a request has both the `If-Modified-Since` and `If-None-Match` headers and their checks result in `If-Modified-Since -> true` and `If-None-Match -> false`, then {{ objstorage-name }} returns a 304 code. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |
| `If-Unmodified-Since` | If specified, {{ objstorage-name }} returns:<br/>- Object. If it has not been modified since the specified time.<br/>- Code 412. If the object hasn't been modified since the specified time.<br/><br/>If a request has both the `If-Unmodified-Since` and `If-Match` headers and their checks result in `If-Unmodified-Since -> false` and `If-Match -> true`, then {{ objstorage-name }} returns a 200 code and the requested data. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |
| `If-Match` | If specified, {{ objstorage-name }} returns:<br/>- Object. If its `ETag` matches the one sent.<br/>- Code 412. If its `ETag` doesn't match the one sent one.<br/><br/><br/>If a request has both the `If-Unmodified-Since` and `If-Match` headers and their checks result in `If-Unmodified-Since -> false` and `If-Match -> true`, then {{ objstorage-name }} returns a 200 code and the requested data. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |
| `If-None-Match` | If specified, {{ objstorage-name }} returns:<br/>- Object. If its `ETag` matches the one sent.<br/>- Code 304. If its `ETag` matches the one sent.<br/><br/><br/>If a request has both the `If-Modified-Since` and `If-None-Match` headers and their checks result in `If-Modified-Since -> true` and `If-None-Match -> false`, then {{ objstorage-name }} returns a 304 code. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232). |

## Response {#response}

### Headers {#response-headers}

In addition to [common response headers](../common-response-headers.md), you can see in a response the headers listed in the table below.

{% if product == "yandex-cloud" and audience != "internal" %}

| Header | Description |
----- | -----
| `X-Amz-Meta-*` | Object user-defined metadata. |
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/>Has the `COLD` value if the object is in cold storage, or `ICE` if in ice storage.<br/><br/>If the object is stored in standard storage, there's no header. |
| `X-Amz-Server-Side-Encryption` | Encryption algorithm used to encrypt the object. Returned if the object was loaded with enabled [encryption](../../../operations/buckets/encrypt.md). |
| `X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id` | ID of the {% if audience != "internal" %}[key {{ kms-short-name }}](../../../../kms/concepts/key.md){% else %}key {{ kms-short-name }}{% endif %}. Returned if the object was loaded with enabled [encryption](../../../operations/buckets/encrypt.md). |

{% endif %}

{% if audience == "internal" or product == "cloud-il" %}

| Header | Description |
----- | -----
| `X-Amz-Meta-*` | Object user-defined metadata. |
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/>Has the `COLD` value if the object is in cold storage, or `ICE` if in ice storage.<br/><br/>If the object is stored in standard storage, there's no header. |

{% endif %}

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

