---
editable: false
sourcePath: en/_api-ref/organizationmanager/api-ref/Organization/get.md
---

# Cloud Organization API, REST: Organization.get
Returns the specified Organization resource.
 
To get the list of available Organization resources, make a [list](/docs/organization/api-ref/Organization/list) request.
 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
organizationId | <p>Required. ID of the Organization resource to return. To get the organization ID, use a <a href="/docs/organization/api-ref/Organization/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "title": "string",
  "labels": "object"
}
```
An Organization resource. For more information, see [Organization](/docs/organization/enable-org).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the organization.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the organization. 3-63 characters long.</p> 
description | **string**<br><p>Description of the organization. 0-256 characters long.</p> 
title | **string**<br><p>Display name of the organization. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 