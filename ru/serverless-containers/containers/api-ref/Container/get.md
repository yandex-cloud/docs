---
editable: false
sourcePath: en/_api-ref/serverless/containers/v1/containers/api-ref/Container/get.md
---

# Serverless Containers Service, REST: Container.get
Returns the specified container.
 
To get the list of all available containers, make a [list](/docs/serverless/containers/api-ref/Container/list) request.
 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/containers/{containerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
containerId | <p>Required. ID of the container to return.</p> <p>To get a container ID make a <a href="/docs/serverless/containers/api-ref/Container/list">list</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "url": "string",
  "status": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the container. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the container belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the container.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the container. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the container.</p> 
labels | **object**<br><p>Container labels as ``key:value`` pairs.</p> 
url | **string**<br><p>URL that needs to be requested to call the container.</p> 
status | **string**<br><p>Status of the container.</p> <ul> <li>CREATING: Container is being created.</li> <li>ACTIVE: Container is ready for use.</li> <li>DELETING: Container is being deleted.</li> <li>ERROR: Container failed. The only allowed action is delete.</li> </ul> 