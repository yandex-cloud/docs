# GetMeta method

Returns the bucket's metadata or an error.

Use this method to check:

- Whether the bucket exists.
- Whether the user has sufficient permissions to access the bucket.



## Request {#request}

```
HEAD /{bucket} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |


### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data and means that the bucket exists and the user has sufficient permissions to access it.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}