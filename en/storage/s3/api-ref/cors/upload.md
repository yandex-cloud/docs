# upload method

Uploads a CORS configuration for a bucket. It replaces any existing configuration.

A CORS configuration is an XML file no larger than 64 KB. A configuration may contain no more than 100 rules.

## Request {#request}

```
PUT /{bucket}?cors HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `cors` | Mandatory parameter to indicate the type of operation. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

The `Content-MD5` header is required.

### Data schema {#request-scheme}

A CORS configuration is passed as an XML document. For the schema description, see [{#T}](../../../cors/configuration.md)

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

