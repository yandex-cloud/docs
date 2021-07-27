---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method get
Returns the specified placement group.
 
To get the list of all available placement groups, make a [list](/docs/compute/api-ref/PlacementGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/placementGroups/{placementGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
placementGroupId | ID of the placement group to return.  To get a placement group ID make a [list](/docs/compute/api-ref/PlacementGroup/list) request.
 
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
  "spreadPlacementStrategy": {}
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the placement group. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the placement group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the placement group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the placement group. 0-256 characters long.</p> 
labels | **object**<br><p>Placement group labels as ``key:value`` pairs.</p> 
spreadPlacementStrategy | **object**<br>Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains.<br><p>This is an empty structure that must be passed to explicitly specify the required placement strategy.</p> 