# getBucketVersioning method

Returns the bucket versioning status.

## Request {#request}

```
GET /{bucket}?versioning HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `versioning` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}
Use [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#structure}
```xml
<?xml version="1.0" encoding="UTF-8"?>
<VersioningConfiguration>
   <Status>string</Status>
</VersioningConfiguration>
```

| Element | Description |
----- | -----
| `VersioningConfiguration` | Root element. |
| `Status` | Status of the bucket versioning option.<br/><br/>Path:`/VersioningConfiguration/Status`<br/>Type: String<br/>Possible values: `Enabled | Suspended` |
