# upload method

Loads the bucket object lifecycle configuration to {{ objstorage-name }}.

## Request {#request}

```
PUT /{bucket}?lifecycle HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |


### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `lifecycle` | Required parameter that indicates the type of operation. |


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your requests.

You must use the `Content-MD5` header.

### Data schema {#request-scheme}

The configuration type is described in [{#T}](xml-config.md).

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}