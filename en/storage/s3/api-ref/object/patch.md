# patch method

[Partially updates and appends object data](../../../concepts/object-patch.md) in {{ objstorage-full-name }}.

{% include [patch-disclaimer](../../../../_includes/storage/patch-disclaimer.md) %}

The request includes the updated object range and the new data.

[Objects can be updated concurrently](../../../concepts/object-patch.md#concurrent-patch) with multiple requests.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PATCH /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key, which is the ID the object is saved with in {{ objstorage-name }}.

### Headers {#request-headers}

Use [common headers](../common-request-headers.md) in your request, as well as the headers below:

Header | Description
----- | -----
`Content-Range` | This is a required parameter.<br/>It takes the `bytes {<start_byte>}-{<end_byte>}/*` value.<br/>Range boundaries are included. The maximum range length is 5 GB.<br/>The `Content-Length` [header](../common-request-headers.md) must be equal to the `Content-Range` length.<br/>To append data to an object, specify the end byte value larger than the object size.<br/>The start byte value cannot exceed the object size.<br/>The header format complies with [RFC 9110](https://www.rfc-editor.org/rfc/rfc9110#name-content-range) with the following exceptions:<ul><li>The `complete-length` header parameter is ignored.</li><li>The `last-pos` header parameter is optional.</li></ul>
`X-Yc-S3-Patch-Append-Part-Size` | This is an optional parameter.<br/>It takes the `{size_of_new_part}` value.<br/>It defines the size (in bytes) of new parts of an object [uploaded in parts](../multipart.md), if appending to the end of the object.<br/>If the object's last part has reached the specified size, the next append will be saved as a new part.<br/>The default value is 25 MB.
`If-Match` | This is an optional parameter.<br/>It defines the condition for partial object update.<br/>If `ETag` of an object matches the one specified in the header, the object is updated.<br/>If the condition is not met, {{ objstorage-name }} returns the 412 `Precondition Failed` error.<br/>You can use it with the `If-Unmodified-Since` header.
`If-Unmodified-Since` | This is an optional parameter.<br/>It defines the condition for partial object update.<br/>The objest is updated if it has not been modified since the specified time.<br/>If the condition is not met, {{ objstorage-name }} returns the 412 `Precondition Failed` error.<br/>You can use it with the `If-Match` header.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

In addition, {{ objstorage-name }} can return other errors described in the table below.

Error | Description
----- | -----
`MissingContentRange` | The `Content-Range` header is missing from the request.
`MalformedPatchAppendPartSize` | The `X-Yc-S3-Patch-Append-Part-Size` header in the request is invalid.
`ObjectVersionPatchConflict` | During the partial update, the object was overwritten with a new version.
`ConcurrentUpdatesPatchConflict` | The conflict could not be resolved due to a high number of concurrent requests.

### Data schema {#response-scheme}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<PatchObjectResult>
    <Object>
    	<LastModified>2023-07-21T11:46:16.357Z</LastModified>
        <ETag>&#34;daebcb5e72f14b690c18018c9f92af05-2&#34;</ETag>
    </Object>
</PatchObjectResult>
```

Tag | Description
----- | -----
`PatchObjectResult` | Root element.
`Object` | Parent tag for update results.
`LastModified` | Date and time when the object was last modified. In case of the partial object update, the tag does not change.
`ETag` | ETag of the updated object. For more details, see [common headers](../common-response-headers.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}