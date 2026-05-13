# Cloud Functions Service, REST: Function.ListRuntimes

Lists available runtime environments for the specified function.

## HTTP request

```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/runtimes
```

## Response {#yandex.cloud.serverless.functions.v1.ListRuntimesResponse}

**HTTP Code: 200 - OK**

```json
{
  "runtimes": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| runtimes[] | **string**

Runtime environments available for the specified function. ||
|#