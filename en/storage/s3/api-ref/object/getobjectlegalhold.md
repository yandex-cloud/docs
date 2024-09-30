# getObjectLegalHold method

Returns the settings of the legal [hold](../../../concepts/object-lock.md) placed on the object version.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```
GET /{bucket}/{key}?legal-hold&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.

### Query parameters {#request-params}

Parameter | Description
----- | -----
`legal-hold` | Required parameter that indicates the type of operation.
`versionId` | Object version ID. This is a required parameter.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

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

Element | Description
----- | -----
`Status` | <p>Legal hold status:</p><ul><li>`ON`: Enabled.</li><li>`OFF`: Disabled.</li></ul><p>Path: `LegalHold\Status`.</p>

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}