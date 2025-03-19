# upload method

Uploads the bucket object lifecycle configuration to {{ objstorage-name }}.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}?lifecycle HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Request parameters {#request-params}

Parameter | Description
----- | -----
`lifecycle` | Required parameter that indicates the type of operation.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

The `Content-MD5` header is required.

### Data schema {#request-scheme}

The configuration type is described in [{#T}](xml-config.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}