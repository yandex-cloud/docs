---
editable: false
sourcePath: en/_api-ref/organizationmanager/api-ref/Organization/get.md
---


# Method get
Returns the specified Organization resource.
 
To get the list of available Organization resources, make a [list](/docs/organization-manager/api-ref/Organization/list) request.
 
## HTTP request {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/{organizationId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
organizationId | Required. ID of the Organization resource to return. To get the organization ID, use a [list](/docs/organization-manager/api-ref/Organization/list) request.  The maximum string length in characters is 50.
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the organization. 3-63 characters long.</p> 
description | **string**<br><p>Description of the organization. 0-256 characters long.</p> 
title | **string**<br><p>Display name of the organization. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 