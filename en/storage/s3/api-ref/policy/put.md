# Object Storage API, Amazon S3-compatible REST: PutBucketPolicy

Applies the access policy to the specified bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```bash
PUT /{bucket}?policy HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Query parameters {#request-params}

Parameter | Description
----- | -----
`policy` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

### Data schema {#request-scheme}

Data is transmitted in JSON format. For more information, see [{#T}](scheme.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

#### Related articles {#related-articles}

* [{#T}](../../../concepts/policy.md)

* [Applying or updating a policy](../../../operations/buckets/policy.md#apply-policy)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
