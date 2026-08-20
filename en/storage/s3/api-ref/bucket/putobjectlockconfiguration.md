# Object Storage API, Amazon S3-compatible REST: PutObjectLockConfiguration

Sets up [object locks](../../../concepts/object-lock.md) in a [versioned bucket](../../../concepts/versioning.md): enables or disables object locks and configures default locks.

{% include [versioning-block-relations](../../../../_includes/storage/versioning-block-relations.md) %}

With object lock enabled, you can lock an object version so that it cannot be deleted or overwritten:

* When uploading the object (the [upload](../object/upload.md) method).
* After uploading the object (the [putObjectRetention](../object/putobjectretention.md) and [putObjectLegalHold](../object/putobjectlegalhold.md) methods).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
PUT /{bucket}?object-lock HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Headings {#request-headers}

Use only [common headers](../common-request-headers.md) in your requests.

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
|| `ObjectLockConfiguration` | Root element.

To disable object lock, provide this parameter with an empty value, e.g., `<ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />`.

Path: `ObjectLockConfiguration`. ||
|| `ObjectLockEnabled` | Object lock status:

* `Enabled`: You can use object locks.

If you do not specify this item, you will get the `InvalidRequest` error message, and object lock will not get enabled.

Path: `ObjectLockConfiguration\ObjectLockEnabled`. ||
|| `Rule` | Lock settings.

Path: `ObjectLockConfiguration\Rule`. ||
|| `DefaultRetention` | Default lock settings.

Path: `ObjectLockConfiguration\Rule\DefaultRetention`. ||
|| `Mode` | Default retention [type](../../../concepts/object-lock.md#types):

* `GOVERNANCE`: Governance-mode retention.
* `COMPLIANCE`: Compliance-mode retention.

Path: `ObjectLockConfiguration\Rule\DefaultRetention\Mode`. ||
|| `Days` | Default retention period in days since the object version upload. It must be a positive integer. You cannot use it together with `Years`.

Path: `ObjectLockConfiguration\Rule\DefaultRetention\Days`. ||
|| `Years` | Default retention period in years since the object version upload. It must be a positive integer. You cannot use it together with `Days`.

Path: `ObjectLockConfiguration\Rule\DefaultRetention\Years`. ||
|#

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

#### Related articles {#related-articles}

* [{#T}](../../../concepts/bucket.md)

* [{#T}](../../../../storage/concepts/object-lock.md)

* [Managing object locks in a bucket](../../../operations/buckets/configure-object-lock.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
