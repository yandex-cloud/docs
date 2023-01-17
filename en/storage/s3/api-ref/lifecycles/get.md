# get method

Returns the bucket object lifecycle configuration from {{ objstorage-name }}.

## Request {#request}

```
GET /{bucket}?lifecycle HTTP/2
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

Use the necessary [common request headers](../common-request-headers.md) in requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

If there is no configuration, {{ objstorage-name }} returns error code 404 `NoSuchLifecycleConfiguration`.

For a list of other possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

The structure of returned data is the same as the structure of the data passed by the [upload](upload.md) method. The structure is described in [{#T}](xml-config.md).
