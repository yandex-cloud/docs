---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/getRestrictionsMeta.md
---

# DataSphere API v2, REST: Project.getRestrictionsMeta
Get meta information about available restrictions.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/projects/restrictionsMeta
```
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "restrictionsMeta": [
    {
      "name": "string",
      "valueType": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
restrictionsMeta[] | **object**<br><p>List of restrictions.</p> 
restrictionsMeta[].<br>name | **string**<br><p>Name of restriction.</p> 
restrictionsMeta[].<br>valueType | **string**<br><p>Value type of restriction.</p> 