---
editable: false
sourcePath: en/_api-ref/marketplace/licensemanager/saas/v1/license-manager/saas/api-ref/Lock/index.md
---

# Yandex Cloud Marketplace License Manager for SaaS, REST: Lock methods
A set of methods for managing subscription locks.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "instanceId": "string",
  "resourceId": "string",
  "startTime": "string",
  "endTime": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "state": "string",
  "templateId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the subscription lock.</p> 
instanceId | **string**<br><p>ID of the subscription instance.</p> 
resourceId | **string**<br><p>ID of the resource.</p> 
startTime | **string** (date-time)<br><p>Timestamp of the start of the subscription lock.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
endTime | **string** (date-time)<br><p>Timestamp of the end of the subscription lock.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
state | **string**<br><p>Subscription lock state.</p> <ul> <li>UNLOCKED: Subscription unlocked.</li> <li>LOCKED: Subscription locked to the resource.</li> <li>DELETED: Subscription lock deleted.</li> </ul> 
templateId | **string**<br><p>ID of the subscription template.</p> 

## Methods {#methods}
Method | Description
--- | ---
[ensure](ensure.md) | Checks if the she specified subscription is already locked to the specified resource. If it is not locked, locks the subscription to the resource.
[get](get.md) | Returns the specified subscription lock.