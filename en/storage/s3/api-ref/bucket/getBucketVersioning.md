# getBucketVersioning method

Returns the bucket versioning status.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?versioning HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Request parameters {#request-params}

Parameter | Description
----- | -----
`versioning` | Required parameter that indicates the type of operation.

### Headers {#request-headers}
Use [common headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

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

Element | Description
----- | -----
`VersioningConfiguration` | Root element.
`Status` | Bucket versioning status.<br/><br/>Path: `/VersioningConfiguration/Status`.<br/>Type: String.<br/>The possible values are: `Enabled | Suspended`

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}