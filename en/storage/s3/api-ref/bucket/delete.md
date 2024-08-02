# deleteBucket method

Deletes an empty bucket. If the bucket isn't empty, first delete all the objects inside the bucket.


## Request {#request}

```
DELETE /{bucket} HTTP/2
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

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}