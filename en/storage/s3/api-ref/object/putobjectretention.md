# putObjectRetention method

Puts [retention](../../../concepts/object-lock.md) on the object version or enables/disables a previously set lock.

To be able to put locks on object versions, enable object lock in the bucket. For this, use the [putObjectLockConfiguration](../bucket/putobjectlockconfiguration.md) method.

Only a user with the [`storage.admin` role](../../../security/index.md) can change a lock once it was set. For a [governance-mode](../../../concepts/object-lock.md#types) retention, use a header that confirms retention bypass (see [below](#request-headers)). You can only extend compliance-mode retention. To check retention status, use the [getObjectRetention](getobjectretention.md) method.

## Request {#request}

```
PUT /{bucket}/{key}?retention&versionId={versionId} HTTP/2
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

Moreover, if [governance-mode retention](../../../concepts/object-lock.md#types) is set for an object version, make sure to use the below-specified header to bypass the retention and confirm its change.

| Header | Description |
--- | ---
| `X-Amz-Bypass-Governance-Retention` | Header that confirms bypassing of the governance retention. Enter `true`. |

### Data schema {#request-schema}

```xml
<Retention xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <Mode>string</Mode>
    <RetainUntilDate>timestamp</RetainUntilDate>
</Retention>
```

| Element | Description |
----- | -----
| `Retention` | <p>Root element with retention settings.</p><p>To release governance-mode retention (if you have the `storage.admin` role), leave the element empty.</p><p>Path: `Retention`.</p> |
| `Mode` | <p>[Type](../../../concepts/object-lock.md#types) of retention:</p><ul><li>`GOVERNANCE`: An object lock with a predefined retention period that can be managed.</li><li>`COMPLIANCE`: An object lock with a predefined retention period with strict compliance.</li></ul><p>Path: `Retention\Mode`.</p> |
| `RetainUntilDate` | <p>Date and time until which the object is retained, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats). For example, `Mon, 12 Dec 2022 09:00:00 GMT`.</p><p>Path: `Retention\RetainUntilDate`.</p> |

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).
