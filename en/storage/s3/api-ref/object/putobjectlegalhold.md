# putObjectLegalHold method

Puts or removes [legal hold](../../../concepts/object-lock.md) for an object version.

To be able to put locks on object versions, enable object lock in the bucket using the [putObjectLockConfiguration](../bucket/putobjectlockconfiguration.md) method.

Users with the [`storage.uploader` role](../../../security/index.md) can place or release a lock. To check a legal hold, use the [getObjectLegalHold](getobjectlegalhold.md) method.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```
PUT /{bucket}/{key}?legal-hold&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.

### Request parameters {#request-params}

Parameter | Description
----- | -----
`legal-hold` | Required parameter that indicates the type of operation.
`versionId` | Object version ID. This is a required parameter.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

### Data schema {#request-schema}

```xml
<LegalHold xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Status>string</Status>
</LegalHold>
```

Element | Description
----- | -----
`Status` | <p>Legal hold status:</p><ul><li>`ON`: Enabled.</li><li>`OFF`: Disabled.</li></ul><p>Path: `LegalHold\Status`.</p>

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}