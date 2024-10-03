# upload method

Uploads a CORS configuration for a bucket. It replaces any existing configuration.

A CORS configuration is an XML file no larger than 64 KB. A configuration may not contain more than 100 rules.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}?cors HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Query parameters {#request-params}

Parameter | Description
----- | -----
`cors` | Required parameter that indicates the type of operation.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

The `Content-MD5` header is required.

### Data schema {#request-scheme}

A CORS configuration is passed as an XML document. For the schema description, see [{#T}](xml-config.md)

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}