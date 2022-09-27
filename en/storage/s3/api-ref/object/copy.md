# copy method

Creates a copy of an object stored in {{ objstorage-name }}. Objects up to 5 GB can be copied with a single `copy` operation. For objects larger than 5 GB, use the [copyPart](../multipart/copypart.md) operation.

To specify the copy source, use the `X-Amz-Copy-Source` header. The copy request must not pass any data other than headers.

{% note info %}

{{ objstorage-name }} does not lock an object for writing and can simultaneously accept multiple requests that copy objects to the same resulting object. After all the requests are completed, the resulting object is the one whose copy operation was run last.

{% endnote %}

The object metadata is copied along with the object. If necessary, you can change the metadata by explicitly setting the appropriate headers.

You can also use headers to:

- Change an object's storage class.
- Add conditions for copying an object.

The user must have permission to read the source object and write data to the resulting bucket.

## Request {#request}

```
PUT /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Name of the resulting bucket. |
| `key` | Key of the resulting object. ID that the object is saved with in {{ objstorage-name }}. |


### Headers {#request-headers}

Required headers are listed in the table below.

| Header | Description |
----- | -----
| `X-Amz-Copy-Source` | The name of the bucket and the key of the object to copy separated by `/`.<br/><br/>For example, `X-Amz-Copy-Source: /source_bucket/sourceObject`.<br/><br/>If the bucket has [versioning](../../../../storage/concepts/versioning.md) enabled, you can copy a specific version of the object. To do this, specify the object version ID in the header by adding `?versionId=<version-id>` to the value of the header, for example: `/mybucket/image.png?versionId=0005E4A66AD990A4`. If you do not specify a version ID, the most recent version of the object will be copied. |

You should also use the necessary [common request headers](../common-request-headers.md).

Use the headers from the table below if you need to change the default behavior of the `copy` method.

| Header | Description |
----- | -----
| `X-Amz-Metadata-Directive` | Metadata copy mode.<br/><br/>If the header value is `COPY`, the object metadata is copied and all the `X-Amz-Meta-*` headers are ignored. Default behavior of the `copy` method.<br/><br/>If the header value is `REPLACE`, the object metadata is replaced with the metadata specified in the request.<br/><br/>The `X-Amz-Storage-Class` header is not copied; add it to the request if necessary. |
| `X-Amz-Copy-Source-If-Match` | Condition for copying an object.<br/><br/>If the object's `ETag` matches the one specified in the header, the object is copied.<br/><br/>If the condition is not met, {{ objstorage-name }} returns error 412.<br/><br/>Can be used with the `X-Amz-Copy-Source-If-Unmodified-Since`. |
| `X-Amz-Copy-Source-If-None-Match` | Condition for copying an object.<br/><br/>If the object's `ETag` does not match the one specified in the header, the object is copied.<br/><br/>If the condition is not met, {{ objstorage-name }} returns error 412.<br/><br/>Can be used with the `X-Amz-Copy-Source-If-Unmodified-Since`. |
| `X-Amz-Copy-Source-If-Unmodified-Since` | Condition for copying an object.<br/><br/>The object is copied if it has not been modified since the specified time.<br/><br/>If the condition is not met, {{ objstorage-name }} returns error 412.<br/><br/>Can be used with the `X-Amz-Copy-Source-If-Match`. |
| `X-Amz-Copy-Source-If-Modified-Since` | Condition for copying an object.<br/><br/>The object is copied if it has been modified since the specified time.<br/><br/>If the condition is not met, {{ objstorage-name }} returns error 412.<br/><br/>Can be used with the `X-Amz-Copy-Source-If-None-Match`. |
| `X-Amz-Server-Side-Encryption` | Default encryption algorithm used for new objects. |
| `X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id` | ID of the [key {{ kms-short-name }}](../../../../kms/concepts/key.md) used by default to encrypt new objects. |
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/><br/>Possible values:<ul><li>`STANDARD`: Standard storage.</li><li>`COLD`, `STANDARD_IA`, or `NEARLINE`: Cold storage.</li><li>`ICE` or `GLACIER`: Ice storage.</li></ul>If the header isn't specified, the object is stored in the storage defined in the bucket settings. |
| `X-Amz-Meta-*` | User-defined metadata.<br/><br/>{{ objstorage-name }} transforms all headers starting with `X-Amz-Meta-` as follows: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>Total user-defined header size must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. Both the headers and their values are included in the size.<br/><br/>Headers that have `X-Amz-Metadata-Directive: COPY` are ignored. |


## Response {#response}

### Headers {#response-headers}

A response may contain [common response headers](../common-response-headers.md) and the headers listed in the table below.

| Header | Description |
----- | -----
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/><br/>Possible values:<ul><li>`STANDARD`: Standard storage.</li><li>`COLD`: Cold storage.</li><li>`ICE`: Ice storage.</li></ul> |

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

```
<CopyObjectResult>
   <LastModified>2019-02-15T14:32:00</LastModified>
   <ETag>"9bgh7535f2734ec974343yuc93985328"</ETag>
</CopyObjectResult>
```

| Element | Description |
----- | -----
| `CopyObjectResult` | Contains response elements.<br/><br/>Path: `/CopyObjectResult`. |
| `ETag` | `ETag` of the resulting object. Because metadata is not taken into account when calculating the `ETag`, the `ETag` of the source and resulting objects must match.<br/><br/>Path: `/CopyObjectResult/ETag`. |
| `LastModified` | Date when the object was last modified.<br/><br/>Path: `/CopyObjectResult/LastModified`. |
