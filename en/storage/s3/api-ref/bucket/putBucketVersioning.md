# putBucketVersioning method

Enables or pauses versioning of the bucket.

Versioning can be set to one of two statuses:
- `Enabled`: Turn on version management for objects in the bucket.  All new objects added to the bucket get a unique version ID.
- `Suspended`: Suspends version management for objects in the bucket.  All new objects added to the bucket get `null` as the version ID.

## Request {#request}

```
PUT /{bucket}?versioning HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `versioning` | Required parameter that indicates the type of operation. |

### Data schema {#request-scheme}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<VersioningConfiguration>
   <Status>string</Status>
</VersioningConfiguration>
```

| Element | Description |
----- | -----
| `Status` | Status of the bucket versioning option.<br/><br/>Type: String<br/>Possible values: `Enabled \| Suspended` |

### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response does not contain any additional data.
