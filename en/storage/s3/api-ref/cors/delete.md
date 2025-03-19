# delete method

Deletes a CORS configuration for a bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
DELETE /{bucket}?cors HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Request parameters {#parameters}

Parameter | Description
----- | -----
`cors` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use only [common headers](../common-request-headers.md) in your requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If the CORS configuration does not exist, {{ objstorage-name }} will return the `204 No Content` code.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}