# Object Storage API, Amazon S3-compatible REST: GetBucketWebsite

Returns the static website hosting configuration for a bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?website HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query parameters {#request-params}

{% include [query-parameters](../../../_includes_service/storage-hosting-query-parameters.md) %}

### Headings {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

The structure of returned data is the same as the structure of data provided by the [upload](upload.md) method.

#### Related articles {#related-articles}

[{#T}](../../../operations/hosting/setup.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
