# get method

Returns a bucket's object lifecycle configuration from {{ objstorage-name }}.

## Request {#request}

```
GET /{bucket}?lifecycle HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `lifecycle` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

If there is no configuration, {{ objstorage-name }} returns error code 404 `NoSuchLifecycleConfiguration`.

For a list of other possible responses, see [{#T}](../response-codes.md).

### Data schema {#response-scheme}

The structure of returned data is the same as that of the data passed by the [upload](upload.md) method. The structure is described in [{#T}](../../../lifecycles/configuration.md).

