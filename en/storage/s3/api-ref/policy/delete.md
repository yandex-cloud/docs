# DeleteBucketPolicy method

Removes the access policy from the specified bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```bash
DELETE /{bucket}?policy HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Request parameters {#request-params}

Parameter | Description
----- | -----
`policy` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

## Response {#response}

If the request is successful, the service will return a response with `HTTP 204` code and an empty body.

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}