# create method

Creates a bucket.

## Request {#request}

```
PUT /{bucket} HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name.<br/><br/>When creating a bucket, follow the [bucket naming guidelines](../../../concepts/bucket.md#naming). |

### Headers {#request-headers}

In a request, use only [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [[!TITLE]](../response-codes.md).

A successful response does not contain any additional data.

