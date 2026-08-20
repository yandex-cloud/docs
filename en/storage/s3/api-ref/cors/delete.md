# Object Storage API, Amazon S3-compatible REST: DeleteBucketCors

Deletes a CORS configuration for a bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
DELETE /{bucket}?cors HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query parameters {#parameters}

{% include [query-parameters](../../../_includes_service/storage-cors-query-parameters.md) %}

### Headings {#request-headers}

Use only [common headers](../common-request-headers.md) in your requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If the CORS configuration does not exist, {{ objstorage-name }} will return the `204 No Content` code.

#### Related articles {#related-articles}

* [{#T}](../../../concepts/cors.md)

* [{#T}](../../../operations/buckets/cors.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
