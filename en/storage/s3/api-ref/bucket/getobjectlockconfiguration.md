# getObjectLockConfiguration method

Returns the settings of [object locks](../../../concepts/object-lock.md) for a [versioned bucket](../../../concepts/versioning.md).

## Request {#request}

```
GET /{bucket}?object-lock HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |


### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).


### Data schema {#request-scheme}

```xml
<ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
   <ObjectLockEnabled>string</ObjectLockEnabled>
   <Rule>
      <DefaultRetention>
         <Mode>string</Mode>
         <Days>integer</Days>
         <Years>integer</Years>
      </DefaultRetention>
   </Rule>
</ObjectLockConfiguration>
```

| Element | Description |
----- | -----
| `ObjectLockEnabled` | <p>Object lock status:</p><ul><li>`Enabled`: Object lock is enabled.</li></ul><p>If the element is omitted, object lock is disabled.</p><p>Path: `ObjectLockConfiguration\ObjectLockEnabled`.</p> |
| `Rule` | <p>Lock settings.</p><p>Path: `ObjectLockConfiguration\Rule`.</p> |
| `DefaultRetention` | <p>Default retention settings.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention`.</p> |
| `Mode` | <p>Default retention [type](../../../concepts/object-lock.md#types):</p><ul><li>`GOVERNANCE`: An object lock with a predefined retention period that can be managed.</li><li>`COMPLIANCE`: An object lock with a predefined retention period with strict compliance.</li></ul><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`.</p> |
| `Days` | <p>Retention period in days since the object version upload. It must be a positive integer.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Days`.</p> |
| `Years` | <p>Retention period in years since the object version upload. It must be a positive integer.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Years`.</p> |