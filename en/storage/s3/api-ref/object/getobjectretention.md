# getObjectRetention method

Returns settings of the [retention](../../../concepts/object-lock.md) put on an object version.

## Request {#request}

```
GET /{bucket}/{key}?retention&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `retention` | Required parameter that indicates the type of operation. |
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
<Retention xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Mode>string</Mode>
    <RetainUntilDate>timestamp</RetainUntilDate>
</Retention>
```

| Element | Description |
----- | -----
| `Mode` | <p>[Type](../../../concepts/object-lock.md#types) of retention:</p><ul><li>`GOVERNANCE`: An object lock with a predefined retention period that can be managed.</li><li>`COMPLIANCE`: An object lock with a predefined retention period with strict compliance.</li></ul><p>Path: `Retention\Mode`.</p> |
| `RetainUntilDate` | <p>Date and time until which the object is retained, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). For example, `Mon, 12 Dec 2022 09:00:00 GMT`.</p><p>Path: `Retention\RetainUntilDate`.</p> |
