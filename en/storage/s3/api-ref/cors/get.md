# get method

Returns a CORS configuration for a bucket.

## Request {#request}

```
GET /{bucket}?cors HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |


### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `cors` | Required parameter that indicates the type of operation. |


### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

The structure of returned data is the same as the structure of the data passed by the [upload](upload.md) method.
