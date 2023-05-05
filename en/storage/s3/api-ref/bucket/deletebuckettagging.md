# DeleteBucketTagging method

Deletes bucket [tags](../../../../resource-manager/concepts/labels.md).

## Query {#request}

```http
DELETE /{bucket}?tagging HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
--- | ---
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
--- | ---
| `tagging` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.
