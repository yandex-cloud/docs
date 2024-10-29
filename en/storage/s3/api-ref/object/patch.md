# PATCH method

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
`key` | Object key. The ID used to store the object in {{ objstorage-name }}.

### Headers {#request-headers}

Use [common headers](../common-request-headers.md) in the request, as well as the headers presented below:

Header | Description
----- | -----
`Content-Range` | Required parameter.<br/>Value: `bytes {<start_byte>}-{<end_byte>}/*`.<br/>Range boundaries are included. Maximum range length is 5 GB.<br/>`Content-Length` [header](../common-request-headers.md) must be equal to the `Content-Range` length.<br/>To append data to an object, specify the end byte value larger than the object size.<br/>The start byte value cannot exceed the object size.<br/>The header format complies with the [RFC 9110](https://www.rfc-editor.org/rfc/rfc9110#name-content-range) specification with the following exceptions:<ul><li>The `complete-length` header parameter is ignored.</li><li>The `last-pos` header parameter is optional.</li></ul>
`X-Yc-S3-Patch-Append-Part-Size` | Optional parameter.<br/>Value: `{size_of_new_part}`.<br/>The size of new parts of an object [uploaded in parts](../multipart.md), if appending to the end of the object. In bytes.<br/>If the object's last part has reached the specified size, the next append will be saved as a new part.<br/>The default value is 25 MB.
`If-Match` | Optional parameter.<br/>Condition for partial object update.<br/>If `ETag` of an object is the same as in the header, the operation is performed.<br/>If the condition is not met, {{ objstorage-name }} returns the 412 error (`Precondition Failed`).<br/>You can use it with the `If-Unmodified-Since` header.
`If-Unmodified-Since` | Optional parameter.<br/>Condition for partial object update.<br/>The operation is performed if the object has not been modified since the specified time.<br/>If the condition is not met, {{ objstorage-name }} returns the 412 error (`Precondition Failed`).<br/>You can use it with the `If-Match` header.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

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
`LastModified` | Date and time of the last object update. During the partial object update, the tag does not change.
`ETag` | ETag of the updated object. For more details, see [common headers](../common-response-headers.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}