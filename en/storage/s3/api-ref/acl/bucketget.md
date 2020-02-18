# bucketGetAcl method

Returns the access control list for a bucket.

## Request {#request}

```
GET /{bucket}?acl HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `acl` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Data schema {#response-scheme}

For a description of the structure returned, see [ACL XML schema](xml-config.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

