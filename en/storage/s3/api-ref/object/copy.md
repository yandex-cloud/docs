# copy method

Creates a copy of an object stored in {{ objstorage-name }}. Objects up to 5 GB can be copied with a single `copy` operation. For objects larger than 5 GB, use the [copyPart](../multipart/copypart.md) operation.

To specify the copy source, use the `X-Amz-Copy-Source` header. The copy request must not provide any data other than headers.

{% note info %}

{{ objstorage-name }} does not lock an object for writing and can simultaneously accept multiple requests that copy objects to the same target object. After all the requests are completed, the target object is the one whose copy operation was run last.

{% endnote %}

The object metadata is copied along with the object. If required, you can change the metadata by explicitly setting the appropriate headers.

You can also use headers to:

- Change an object's storage class.
- Add conditions for copying an object.
- Put a [lock](../../../concepts/object-lock.md) on an object (if the bucket is [versioned](../../../concepts/versioning.md) and object lock is enabled).

The user must have permission to read the source object and write data to the target bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Name of the bucket.
`key` | Key of the target object, which is the ID the object is saved with in {{ objstorage-name }}.


### Headers {#request-headers}

The required headers are listed in the table below.

Header | Description
----- | -----
`X-Amz-Copy-Source` | Name of the bucket and the object key to copy, separated by `/`.<br/><br/>For example, `X-Amz-Copy-Source: /source_bucket/sourceObject`.<br/><br/>If the bucket has [versioning](../../../../storage/concepts/versioning.md) enabled, you can copy a specific version of the object. To do this, specify the object version ID in the header by adding `?versionId=<version-id>` to the header value, e.g., `/mybucket/image.png?versionId=0005E4A66AD990A4`. If you do not specify a version ID, the most recent version of the object will be copied.

Make sure to also use the required [common headers](../common-request-headers.md).

Use the headers from the table below if you need to change the default behavior for the `copy` method.


Header | Description
----- | -----
`X-Amz-Metadata-Directive` | Metadata copying mode.<br/><br/>If the header value is `COPY`, the object metadata is copied and all `X-Amz-Meta-*` headers are ignored. This is how the `copy` method works by default.<br/><br/>If the header value is `REPLACE`, the object metadata is replaced with that provided in the request.<br/><br/>The `X-Amz-Storage-Class` header is not copied; you have to add it to the request manually, if required.
`X-Amz-Copy-Source-If-Match` | Object copy condition.<br/><br/>If `ETag` of an object matches the one specified in the header, the object is copied.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-Unmodified-Since` header.
`X-Amz-Copy-Source-If-None-Match` | Object copy condition.<br/><br/>If `ETag` of an object does not match the one specified in the header, the object is copied.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-Modified-Since` header.
`X-Amz-Copy-Source-If-Unmodified-Since` | Object copy condition.<br/><br/>The object is copied if it has not been modified since the specified time.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-Match` header.
`X-Amz-Copy-Source-If-Modified-Since` | Object copy condition.<br/><br/>The object is copied if it has been modified since the specified time.<br/><br/>If the condition is not met, {{ objstorage-name }} returns the 412 error.<br/><br/>You can use it with the `X-Amz-Copy-Source-If-None-Match` header.
`X-Amz-Server-Side-Encryption` | Default encryption algorithm used for new objects.
`X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id` | ID of the [{{ kms-short-name }} key](../../../../kms/concepts/key.md) used by default to encrypt new objects.
`X-Amz-Storage-Class` | [Storage class](../../../concepts/storage-class.md) of the object.<br/><br/>It may have any of the following values:<ul><li>`STANDARD`: Standard storage</li><li>`COLD`, `STANDARD_IA`, or `NEARLINE`: Cold storage</li><li>`ICE` or `GLACIER`: Ice storage</li></ul>If the header is not specified, the object storage is defined in the bucket settings.
`X-Amz-Object-Lock-Mode` | <p>Type of [retention](../../../concepts/object-lock.md) put on the object (if the bucket is [versioned](../../../concepts/versioning.md) and object lock is enabled in it):</p><ul><li>`GOVERNANCE`: Governance-mode retention.</li><li>`COMPLIANCE`: Compliance-mode retention.</li></ul><p>For an object version, you can use only retention (the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers), only legal hold (`X-Amz-Object-Lock-Legal-Hold`), or both at the same time. For more information about their combined use, see [{#T}](../../../concepts/object-lock.md#types).</p>
`X-Amz-Object-Lock-Retain-Until-Date` | Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`. Specify it only with the `X-Amz-Object-Lock-Mode` header.
`X-Amz-Object-Lock-Legal-Hold` | <p>Type of [legal hold](../../../concepts/object-lock.md) put on the object (if the bucket is [versioned](../../../concepts/versioning.md) and object lock is enabled in it):</p><ul><li>`ON`: Enabled.</li><li>`OFF`: Disabled.</li></ul><p>For an object version, you can use only retention (the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers), only legal hold (`X-Amz-Object-Lock-Legal-Hold`), or both at the same time. For more information about their combined use, see [{#T}](../../../concepts/object-lock.md#types).</p>
`X-Amz-Meta-*` | User-defined object metadata.<br/><br/>{{ objstorage-name }} converts all headers starting with `X-Amz-Meta-` as follows: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>The total size of user-defined headers must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The size includes header names and their values.<br/><br/>With `X-Amz-Metadata-Directive: COPY`, these headers are ignored.



## Response {#response}

### Headers {#response-headers}

A response may contain [common headers](../common-response-headers.md) and the headers listed in the table below.

Header | Description
----- | -----
`X-Amz-Storage-Class` | [Storage class](../../../concepts/storage-class.md) of the object.<br/><br/>It may have the following values:<ul><li>`STANDARD`: Standard storage</li><li>`COLD`: Cold storage</li><li>`ICE`: Ice storage</li></ul>

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

```xml
<CopyObjectResult>
   <LastModified>2019-02-15T14:32:00</LastModified>
   <ETag>"9bgh7535f2734ec974343yuc93985328"</ETag>
</CopyObjectResult>
```

Element | Description
----- | -----
`CopyObjectResult` | It contains response elements.<br/><br/>Path: `/CopyObjectResult`.
`ETag` | `ETag` of the target object. Since metadata does not count when calculating `ETag`, the source and target object `ETag` values must match.<br/><br/>Path: `/CopyObjectResult/ETag`.
`LastModified` | Date when the object was last modified.<br/><br/>Path: `/CopyObjectResult/LastModified`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}