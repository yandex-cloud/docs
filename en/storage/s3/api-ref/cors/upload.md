---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# upload method

Uploads a CORS configuration for a bucket. It replaces any existing configuration.

A CORS configuration is an XML file no larger than 64 KB. Configurations can't contain more than 100 rules.

## Request {#request}

```
PUT /{bucket}?cors HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `cors` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

The `Content-MD5` header is required.

### Data schema {#request-scheme}

A CORS configuration is passed as an XML document. For the schema description, see [{#T}](xml-config.md)

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

