---
editable: false
sourcePath: en/_api-ref/marketplace/licensemanager/v1/license-manager/api-ref/Instance/list.md
---

# Yandex Cloud Marketplace License Manager, REST: Instance.list
Retrieves the list of subscription instances in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://marketplace.{{ api-host }}/marketplace/license-manager/v1/instances
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the subscription instance belongs to.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/marketplace/license-manager/api-ref/Instance/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/marketplace/license-manager/api-ref/Instance/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters subscription instances listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on [Instance.name] field.</li> <li>An operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be in double quotes ``""``. Must be 3-63 characters long and match the regular expression ``^[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name="my-subscription-instance"``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>Sorting order for the list of subscription instances.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instances": [
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
          "state": "string",
          "templateId": "string"
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
instances[] | **object**<br><p>List of subscription instances.</p> 
instances[].<br>id | **string**<br><p>ID of the subscription instance.</p> 
instances[].<br>cloudId | **string**<br><p>ID of the cloud that the subscription instance belongs to.</p> 
instances[].<br>folderId | **string**<br><p>ID of the folder that the subscription instance belongs to.</p> 
instances[].<br>templateId | **string**<br><p>ID of the subscription template that was used to create subscription instance.</p> 
instances[].<br>templateVersionId | **string**<br><p>ID of the version of subscription template.</p> 
instances[].<br>description | **string**<br><p>Description of the subscription instance.</p> 
instances[].<br>startTime | **string** (date-time)<br><p>Timestamp of the start of the subscription.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>endTime | **string** (date-time)<br><p>Timestamp of the end of the subscription.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>state | **string**<br><p>Subscription state.</p> <ul> <li>PENDING: Subscription created but not active yet.</li> <li>ACTIVE: Subscription is active.</li> <li>CANCELLED: Subscription canceled. It is still active, but won't be automatically renewed after the end of the current period.</li> <li>EXPIRED: Subscription expired.</li> <li>DEPRECATED: Subscription deprecated.</li> <li>DELETED: Subscription deleted.</li> </ul> 
instances[].<br>locks[] | **object**<br><p>List of subscription locks.</p> 
instances[].<br>locks[].<br>id | **string**<br><p>ID of the subscription lock.</p> 
instances[].<br>locks[].<br>instanceId | **string**<br><p>ID of the subscription instance.</p> 
instances[].<br>locks[].<br>resourceId | **string**<br><p>ID of the resource.</p> 
instances[].<br>locks[].<br>startTime | **string** (date-time)<br><p>Timestamp of the start of the subscription lock.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>locks[].<br>endTime | **string** (date-time)<br><p>Timestamp of the end of the subscription lock.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>locks[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>locks[].<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>locks[].<br>state | **string**<br><p>Subscription lock state.</p> <ul> <li>UNLOCKED: Subscription unlocked.</li> <li>LOCKED: Subscription locked to the resource.</li> <li>DELETED: Subscription lock deleted.</li> </ul> 
instances[].<br>locks[].<br>templateId | **string**<br><p>ID of the subscription template.</p> 
instances[].<br>licenseTemplate | **object**<br><p>Subscription template.</p> 
instances[].<br>licenseTemplate.<br>id | **string**<br><p>ID of the subscription template.</p> 
instances[].<br>licenseTemplate.<br>versionId | **string**<br><p>Version of the subscription template.</p> 
instances[].<br>licenseTemplate.<br>name | **string**<br><p>Name of the subscription template.</p> 
instances[].<br>licenseTemplate.<br>publisherId | **string**<br><p>ID of publisher.</p> 
instances[].<br>licenseTemplate.<br>productId | **string**<br><p>ID of product.</p> 
instances[].<br>licenseTemplate.<br>tariffId | **string**<br><p>ID of tariff.</p> 
instances[].<br>licenseTemplate.<br>licenseSkuId | **string**<br><p>ID of subscription SKU.</p> 
instances[].<br>licenseTemplate.<br>period | **string**<br><p>Subscription period.</p> 
instances[].<br>licenseTemplate.<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>licenseTemplate.<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>licenseTemplate.<br>state | **string**<br><p>Subscription template state.</p> <ul> <li>PENDING: Subscription template created but not active yet.</li> <li>ACTIVE: Subscription template is active.</li> <li>DEPRECATED: Subscription template deprecated.</li> <li>DELETED: Subscription template deleted.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/marketplace/license-manager/api-ref/Instance/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/marketplace/license-manager/api-ref/Instance/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 