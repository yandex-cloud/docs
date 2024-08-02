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
| `versionId` | Object version ID. This is a required parameter. |

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in requests.

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
| `Mode` | <p>[Type](../../../concepts/object-lock.md#types) of retention:</p><ul><li>`GOVERNANCE`: Object lock with a predefined retention period that can be managed.</li><li>`COMPLIANCE`: Object lock with a predefined retention period with strict compliance.</li></ul><p>Path: `Retention\Mode`.</p> |
| `RetainUntilDate` | <p>Lock end date and time in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2025-01-01T00:00:00`. The lock end time value is specified in the [UTC±00:00](https://en.wikipedia.org/wiki/UTC%2B00:00) time zone. To use a different time zone, add `+` or `-` and a UTC±00:00 offset to the end of the record.</p><p>Path: `Retention\RetainUntilDate`.</p> |

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}