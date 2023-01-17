# getObjectLegalHold method

Returns the settings of legal [hold](../../../concepts/object-lock.md) put on the object version.

## Request {#request}

```
GET /{bucket}/{key}?legal-hold&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `legal-hold` | Required parameter that indicates the type of operation. |
| `versionId` | Object version ID. Required parameter. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).


### Data schema {#response-schema}

```xml
<LegalHold xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Status>string</Status>
</LegalHold>
```

| Element | Description |
----- | -----
| `Status` | <p>Status of legal hold:</p><ul><li>`ON`: Enabled.</li><li>`OFF`: Disabled.</li></ul><p>Path: `LegalHold\Status`.</p> |