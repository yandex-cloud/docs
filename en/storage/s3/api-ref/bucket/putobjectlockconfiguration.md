# putObjectLockConfiguration method

Sets up [object lock](../../../concepts/object-lock.md) in a [versioned bucket](../../../concepts/versioning.md): enables or disables object locks and configures default locks.

When object lock is enabled, you can lock an object version so that it can't be deleted or overwritten:

* When loading the object ([upload](../object/upload.md) method).
* On object upload (the [putObjectRetention](../object/putobjectretention.md) and [putObjectLegalHold](../object/putobjectlegalhold.md) methods).

## Query {#request}

```
PUT /{bucket}?object-lock HTTP/2
```

### Path parameters {#path-parameters}

| Option | Description |
----- | -----
| `bucket` | Bucket name. |


### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in requests.


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
| `ObjectLockConfiguration` | <p>Root element.</p><p>To disable object lock, send this parameter with an empty value, for example: `<ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />`.</p><p>Path: `ObjectLockConfiguration`.</p> |
| `ObjectLockEnabled` | <p>Object lock status:</p><ul><li>`Enabled`: Object lock is enabled.</li></ul><p>If you omit this element, you'll see the `InvalidRequest` error message, and object lock will not be enabled.</p><p>Path: `ObjectLockConfiguration\ObjectLockEnabled`.</p> |
| `Rule` | <p>Lock settings.</p><p>Path: `ObjectLockConfiguration\Rule`.</p> |
| `DefaultRetention` | <p>Default retention settings.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention`.</p> |
| `Mode` | <p>Default retention [type](../../../concepts/object-lock.md#types):</p><ul><li>`GOVERNANCE`: Object lock with a predefined retention period that can be managed.</li><li>`COMPLIANCE`: Object lock with a predefined retention period with strict compliance.</li></ul><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`.</p> |
| `Days` | <p>Retention period in days since the object version upload. It must be a positive integer. You can't set it simultaneously with `Years`.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Days`.</p> |
| `Years` | <p>Retention period in years since the object version upload. It must be a positive integer. You can't set it simultaneously with `Days`.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Years`.</p> |

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).
