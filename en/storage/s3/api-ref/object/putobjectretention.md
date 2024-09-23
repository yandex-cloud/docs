# putObjectRetention method

Puts [retention](../../../concepts/object-lock.md) on the object version or enables/disables a previously set lock.

To be able to put locks on object versions, enable object lock in the bucket. For this, use the [putObjectLockConfiguration](../bucket/putobjectlockconfiguration.md) method.

Only a user with the [`storage.admin` role](../../../security/index.md) can change a lock once it was set. For a [governance-mode](../../../concepts/object-lock.md#types) retention, use a header that confirms retention bypass (see [below](#request-headers)). You can only extend compliance-mode retention. To check retention status, use the [getObjectRetention](getobjectretention.md) method.

## Request {#request}

```http
PUT /{bucket}/{key}?retention&versionId={versionId} HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.
`key` | Object key.

### Query parameters {#request-params}

Parameter | Description
----- | -----
`retention` | Required parameter that indicates the type of operation.
`versionId` | Object version ID. This is a required parameter.

### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

Moreover, if [governance-mode retention](../../../concepts/object-lock.md#types) is set for an object version, make sure to use the below-specified header to bypass the retention and confirm its change.

Header | Description
--- | ---
`X-Amz-Bypass-Governance-Retention` | Header that confirms bypassing of the governance retention. Set it to `true`.

### Data schema {#request-schema}

```xml
<Retention xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Mode>string</Mode>
    <RetainUntilDate>timestamp</RetainUntilDate>
</Retention>
```

Element | Description
----- | -----
`Retention` | <p>Root element with retention settings.</p><p>To remove governance-mode retention (if you have the `storage.admin` role), leave the element empty.</p><p>Path: `Retention`.</p>
`Mode` | <p>[Type](../../../concepts/object-lock.md#types) of retention:</p><ul><li>`GOVERNANCE`: Object lock with governance-mode retention.</li><li>`COMPLIANCE`: Object lock with compliance-mode retention.</li></ul><p>Path: `Retention\Mode`.</p>
`RetainUntilDate` | <p>Lock end date and time in the [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format, e.g., `2025-01-01T00:00:00`. The lock end time value is specified in the [UTC±00:00](https://en.wikipedia.org/wiki/UTC%2B00:00) time zone. To use a different time zone, add `+` or `-` and a UTC±00:00 offset to the end of the record.</p><p>Path: `Retention\RetainUntilDate`.</p>

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}