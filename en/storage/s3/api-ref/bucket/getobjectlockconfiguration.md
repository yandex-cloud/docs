# getObjectLockConfiguration method

Returns the settings of [object locks](../../../concepts/object-lock.md) for a [versioned bucket](../../../concepts/versioning.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?object-lock HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Headers {#request-headers}
Use only [common headers](../common-request-headers.md) in your requests.


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

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

Element | Description
----- | -----
`ObjectLockEnabled` | <p>Object lock status:</p><ul><li>`Enabled`: You can use object locks.</li></ul><p>If the element is not specified, object locks are disabled.</p><p>Path: `ObjectLockConfiguration\ObjectLockEnabled`.</p>
`Rule` | <p>Lock settings.</p><p>Path: `ObjectLockConfiguration\Rule`.</p>
`DefaultRetention` | <p>Default lock settings.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention`.</p>
`Mode` | <p>Default retention [type](../../../concepts/object-lock.md#types):</p><ul><li>`GOVERNANCE`: Governance-mode retention.</li><li>`COMPLIANCE`: Compliance-mode retention.</li></ul><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`.</p>
`Days` | <p>Default retention period in days since the object version upload. It must be a positive integer.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Days`.</p>
`Years` | <p>Default retention period in years since the object version upload. It must be a positive integer.</p><p>Path: `ObjectLockConfiguration\Rule\DefaultRetention\Years`.</p>

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}