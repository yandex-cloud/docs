---
editable: false
sourcePath: en/_api-ref/marketplace/licensemanager/v1/license-manager/api-ref/Instance/index.md
---

# Yandex Cloud Marketplace License Manager, REST: Instance methods
A set of methods for managing subscription instances.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "cloudId": "string",
  "folderId": "string",
  "templateId": "string",
  "templateVersionId": "string",
  "description": "string",
  "startTime": "string",
  "endTime": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "state": "string",
  "locks": [
    {
      "id": "string",
      "instanceId": "string",
      "resourceId": "string",
      "startTime": "string",
      "endTime": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "state": "string"
    }
  ],
  "licenseTemplate": {
    "id": "string",
    "versionId": "string",
    "name": "string",
    "publisherId": "string",
    "productId": "string",
    "tariffId": "string",
    "licenseSkuId": "string",
    "period": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "state": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the subscription instance.</p> 
cloudId | **string**<br><p>ID of the cloud that the subscription instance belongs to.</p> 
folderId | **string**<br><p>ID of the folder that the subscription instance belongs to.</p> 
templateId | **string**<br><p>ID of the subscription template that was used to create subscription instance.</p> 
templateVersionId | **string**<br><p>ID of the version of subscription template.</p> 
description | **string**<br><p>Description of the subscription instance.</p> 
startTime | **string** (date-time)<br><p>Timestamp of the start of the subscription.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
endTime | **string** (date-time)<br><p>Timestamp of the end of the subscription.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
state | **string**<br><p>Subscription state.</p> <ul> <li>PENDING: Subscription created but not active yet.</li> <li>ACTIVE: Subscription is active.</li> <li>CANCELLED: Subscription canceled. It is still active, but won't be automatically renewed after the end of the current period.</li> <li>EXPIRED: Subscription expired.</li> <li>DEPRECATED: Subscription deprecated.</li> <li>DELETED: Subscription deleted.</li> </ul> 
locks[] | **object**<br><p>List of subscription locks.</p> 
locks[].<br>id | **string**<br><p>ID of the subscription lock.</p> 
locks[].<br>instanceId | **string**<br><p>ID of the subscription instance.</p> 
locks[].<br>resourceId | **string**<br><p>ID of the resource.</p> 
locks[].<br>startTime | **string** (date-time)<br><p>Timestamp of the start of the subscription lock.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
locks[].<br>endTime | **string** (date-time)<br><p>Timestamp of the end of the subscription lock.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
locks[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
locks[].<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
locks[].<br>state | **string**<br><p>Subscription lock state.</p> <ul> <li>UNLOCKED: Subscription unlocked.</li> <li>LOCKED: Subscription locked to the resource.</li> <li>DELETED: Subscription lock deleted.</li> </ul> 
licenseTemplate | **object**<br><p>Subscription template.</p> 
licenseTemplate.<br>id | **string**<br><p>ID of the subscription template.</p> 
licenseTemplate.<br>versionId | **string**<br><p>Version of the subscription template.</p> 
licenseTemplate.<br>name | **string**<br><p>Name of the subscription template.</p> 
licenseTemplate.<br>publisherId | **string**<br><p>ID of publisher.</p> 
licenseTemplate.<br>productId | **string**<br><p>ID of product.</p> 
licenseTemplate.<br>tariffId | **string**<br><p>ID of tariff.</p> 
licenseTemplate.<br>licenseSkuId | **string**<br><p>ID of subscription SKU.</p> 
licenseTemplate.<br>period | **string**<br><p>Subscription period.</p> 
licenseTemplate.<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
licenseTemplate.<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
licenseTemplate.<br>state | **string**<br><p>Subscription template state.</p> <ul> <li>PENDING: Subscription template created but not active yet.</li> <li>ACTIVE: Subscription template is active.</li> <li>DEPRECATED: Subscription template deprecated.</li> <li>DELETED: Subscription template deleted.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified subscription instance.
[list](list.md) | Retrieves the list of subscription instances in the specified folder.