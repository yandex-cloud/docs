---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# copy method

Creates a copy of an object stored in {{ objstorage-name }}. Objects up to 5 GB can be copied with a single `copy` operation. For objects larger than 5 GB, use the [copyPart](../multipart/copypart.md) operation.

To specify the copy source, use the `x-amz-copy-source` header. The copy request must not pass any data other than headers.

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
PUT /{bucket}/{key} HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the resulting bucket. |
| `key` | Key of the resulting object. ID that the object is saved with in {{ objstorage-name }}. |

### Headers {#request-headers}

Required headers are listed in the table below.

| Header | Description |
| ----- | ----- |
| `x-amz-copy-source` | The name of the bucket and the key of the object to copy, separated by the `/` character.<br/><br/>For example, `x-amz-copy-source: /source_bucket/sourceObject`. |

You should also use the necessary [common request headers](../common-request-headers.md).

Use the headers from the table below if you need to change the default behavior of the `copy` method.

| Header | Description |
| ----- | ----- |
| `x-amz-metadata-directive` | Metadata copy mode.<br/><br/>If the header value is `COPY`, the object metadata is copied and all the `x-amz-meta-*` headers are ignored. Default behavior of the `copy` method.<br/><br/>If the header value is `REPLACE`, the object metadata is replaced with the metadata specified in the request.<br/><br/>The `x-amz-storage-class` header is not copied; add it to the request if necessary. |
| `x-amz-copy-source-if-match` | Object copying criteria.<br/><br/>If the `ETag` of an object is the same as in the header, the object is copied.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the `x-amz-copy-source-if-unmodified-since` header. |
| `x-amz-copy-source-if-none-match` | Object copying criteria.<br/><br/>If the `ETag` of the object isn't the same as in the header, the object is copied.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the  `x-amz-copy-source-if-modified-since` method. |
| `x-amz-copy-source-if-unmodified-since` | Object copying criteria.<br/><br/>The object is copied if it didn't change since the specified time.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the `x-amz-copy-source-if-match` header. |
| `x-amz-copy-source-if-modified-since` | Object copying criteria.<br/><br/>The object is copied if it changed since the specified time.<br/><br/>If the criteria isn't met, {{ objstorage-name }} returns a 412 error.<br/><br/>Can be used with the `x-amz-copy-source-if-none-match` header. |
| `x-amz-server-side-encryption` | Default encryption algorithm used for new objects. |
| `x-amz-server-side-encryption-aws-kms-key-id` | ID of the [{{ kms-short-name }} key](../../../../kms/concepts/key.md) used by default to encrypt new objects. |
| `x-amz-storage-class` | Object storage class.<br/><br/>Possible values:<br/>- `STANDARD` for uploading an object to standard storage.<br/>- `COLD`, `STANDARD_IA`, and `NEARLINE` for uploading an object to cold storage.<br/><br/>If the header is omitted, the object is saved to the storage specified in the bucket settings. |
| `x-amz-meta-*` | User-defined object metadata.<br/><br/>{{ objstorage-name }} considers all headers starting with `x-amz-meta-` as user-defined. It doesn't process these headers. Instead, it saves them in their original format.<br/><br/>The total size of user-defined headers must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. Both the headers and their values are included in the size.<br/><br/>Headers that have `x-amz-metadata-directive: COPY` are ignored. |

## Response {#response}

### Headers {#response-headers}

A response may contain [common response headers](../common-response-headers.md) and the headers listed in the table below.

| Header | Description |
| ----- | ----- |
| `x-amz-storage-class` | Object storage class.<br/><br/>Possible values:<br/>- `STANDARD` for an object stored in standard storage.<br/>- `COLD` for an object stored in cold storage. |

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
| ----- | ----- |
| `CopyObjectResult` | Contains response elements.<br/><br/>Path: `/CopyObjectResult`. |
| `ETag` | `ETag` of the resulting object. Because metadata is not taken into account when calculating the `ETag`, the `ETag` of the source and resulting objects must match.<br/><br/>Path: `/CopyObjectResult/ETag`. |
| `LastModified` | Date when the object was last modified.<br/><br/>Path: `/CopyObjectResult/LastModified`. |    