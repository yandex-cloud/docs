# Object Storage API, Amazon S3-compatible REST: RestoreObject

The method ensures compatibility with other solutions, e.g., you can use the same logic as for Amazon S3 Glacier when working with {{ objstorage-name }}. However, unlike Amazon S3 Glacier, objects in {{ objstorage-name }} are immediately available for reading and do not need to be moved to hotter storage, so the method always returns `200 OK`.

`RestoreObject` also counts as accessing an object in an `INTELLIGENT_TIERING` [storage](../../../concepts/storage-class.md#features-intelligent-tiering). The method can move the object to a more frequent access tier.

{% note warning %}

Object restoration using S3 Select is not supported. A request specifying `SELECT` within `Type` will return the `501 Not Implemented` error.

{% endnote %}

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
POST /{bucket}/{key}?restore HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name
`key` | Object key

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.

#### Related articles {#related-articles}

* [{#T}](../../../concepts/object.md)

* [{#T}](../../../concepts/storage-class.md#features-intelligent-tiering)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
