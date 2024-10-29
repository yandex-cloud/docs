# delete method

Deletes a bucket object lifecycle configuration from {{ objstorage-name }}.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
DELETE /{bucket}?lifecycle HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Query parameters {#parameters}

Parameter | Description
----- | -----
`lifecycle` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in your requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

If there is no bucket object lifecycle configuration, {{ objstorage-name }} will return code 200.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}