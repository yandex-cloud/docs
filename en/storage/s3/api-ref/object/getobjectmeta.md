# GetObjectMeta method

Returns object metadata.

The method is equivalent to [get](get.md), but the object itself is not included in the response.

## Request {#request}

```http
HEAD /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

You can also use the following headers in your request:

Header | Description
----- | -----
`Range` | It defines the range of bytes to load from the object.<br/><br/>For more information about the `Range` header, see the HTTP specification [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35).
`If-Modified-Since` | If specified, {{ objstorage-name }} returns the following:<br/>- Object. If it has been modified since the specified time.<br/>- Code 304. If the object has not been modified since the specified time.<br/><br/>If a request has both the `If-Modified-Since` and `If-None-Match` headers and their checks result in `If-Modified-Since -> true` and `If-None-Match -> false`, {{ objstorage-name }} returns a 304 code. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232).
`If-Unmodified-Since` | If specified, {{ objstorage-name }} returns the following:<br/>- Object. If it has not been modified since the specified time.<br/>- Code 412. If the object has not been modified since the specified time.<br/><br/>If a request has both the `If-Unmodified-Since` and `If-Match` headers and their checks result in `If-Unmodified-Since -> false` and `If-Match -> true`, {{ objstorage-name }} returns a 200 code and the requested data. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232).
`If-Match` | If specified, {{ objstorage-name }} returns the following:<br/><br/>- Object. If its `ETag` matches the sent one.<br/>- Code 412. If its `ETag` mismatches the sent one.<br/><br/><br/>If a request has both the `If-Unmodified-Since` and `If-Match` headers and their checks result in `If-Unmodified-Since -> false` and `If-Match -> true`, {{ objstorage-name }} returns a 200 code and the requested data. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232).
`If-None-Match` | If specified, {{ objstorage-name }} returns the following:<br/><br/>- Object. If its `ETag` mismatches the sent one.<br/>- Code 304. If its `ETag` matches the sent one.<br/><br/><br/>If a request has both the `If-Modified-Since` and `If-None-Match` headers and their checks result in `If-Modified-Since -> true` and `If-None-Match -> false`, {{ objstorage-name }} returns a 304 code. For more information, see [RFC 7232](https://tools.ietf.org/html/rfc7232).

## Response {#response}

### Headers {#response-headers}

In addition to [common response headers](../common-response-headers.md), you can see in a response the headers listed in the table below.


Header | Description
----- | -----
`X-Amz-Meta-*` | Object user-defined metadata.
`X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/>It has the `COLD` value if the object is in cold storage, or `ICE` if in ice storage.<br/><br/>If the object is in standard storage, there is no header.
`X-Amz-Server-Side-Encryption` | Encryption algorithm used to encrypt the object. Returned if the object was loaded with enabled [encryption](../../../operations/buckets/encrypt.md).
`X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id` | [{{ kms-short-name }}](../../../../kms/concepts/key.md) Key ID. Returned if the object was loaded with enabled [encryption](../../../operations/buckets/encrypt.md).
`X-Amz-Object-Lock-Mode` | <p>Type of [retention](../../../concepts/object-lock.md) put on the object (if the bucket is [versioned](../../../concepts/versioning.md) with object lock enabled):</p><ul><li>`GOVERNANCE`: Object lock with a predefined manageable retention.</li><li>`COMPLIANCE`: Object lock with a predefined retention with strict compliance.</li></ul><p>For an object version, you can use only retention (the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers), only legal hold (`X-Amz-Object-Lock-Legal-Hold`), or both at the same time. For more information about their combined use, see [{#T}](../../../concepts/object-lock.md#types).</p>
`X-Amz-Object-Lock-Retain-Until-Date` | Date and time of end of retention in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`. Specify it only with the `X-Amz-Object-Lock-Mode` header.
`X-Amz-Object-Lock-Legal-Hold` | <p>Type of [legal hold](../../../concepts/object-lock.md) put on the object (if the bucket is [versioned](../../../concepts/versioning.md) with object lock enabled):</p><ul><li>`ON`: Enabled.</li><li>`OFF`: Disabled.</li></ul><p>For an object version, you can use only retention (the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers), only legal hold (`X-Amz-Object-Lock-Legal-Hold`), or both at the same time. For more information about their combined use, see [{#T}](../../../concepts/object-lock.md#types).</p>


### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}