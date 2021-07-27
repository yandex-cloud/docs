---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# PutBucketPolicy method

Applies the access policy to the specified bucket.

## Request {#request}

```http
PUT /{bucket}?policy HTTP/1.1
```

### Path parameters {#path-parameters}

Parameter | Description
--- | ---
`bucket` | Bucket name.

### Query parameters {#request-params}

Parameter | Description
--- | ---
`policy` | Required parameter that indicates the type of operation.

### Headings {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

### Data schema {#request-scheme}

Data is transmitted in JSON format. For more information, see [{#T}](scheme.md).

## Response {#response}

### Headings {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).