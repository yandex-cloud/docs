# Object Storage API, Amazon S3-compatible REST: GetObjectLockConfiguration

Returns the settings of [object locks](../../../concepts/object-lock.md) for a [versioned bucket](../../../concepts/versioning.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?object-lock HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Headings {#request-headers}

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

#|
|| **Element** | **Description** ||
|| `ObjectLockEnabled` | Object lock status:

* `Enabled`: You can use object locks.

If the element is not specified, object locks are disabled.

Path: `ObjectLockConfiguration\ObjectLockEnabled`. ||
|| `Rule` | Lock settings.

Path: `ObjectLockConfiguration\Rule`. ||
|| `DefaultRetention` | Default lock settings.

Path: `ObjectLockConfiguration\Rule\DefaultRetention`. ||
|| `Mode` | Default retention [type](../../../concepts/object-lock.md#types):

* `GOVERNANCE`: Governance-mode retention.
* `COMPLIANCE`: Compliance-mode retention.

Path: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`. ||
|| `Days` | Default retention period in days since the object version upload. It must be a positive integer.

Path: `ObjectLockConfiguration\Rule\DefaultRetention\Days`. ||
|| `Years` | Default retention period in years since the object version upload. It must be a positive integer.

Path: `ObjectLockConfiguration\Rule\DefaultRetention\Years`. ||
|#

#### Related articles {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [Object lock](../../../concepts/object-lock.md)

* [Managing object locks in a bucket](../../../operations/buckets/configure-object-lock.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
