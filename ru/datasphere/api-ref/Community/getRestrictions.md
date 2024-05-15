---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/getRestrictions.md
---

# DataSphere API v2, REST: Community.getRestrictions
Get current community restrictions.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}:restrictions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
communityId | <p>Required. ID of the community.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "restrictions": [
    {
      "name": "string",
      "boolValue": [
        true
      ],
      "longValue": [
        "string"
      ],
      "stringValue": [
        "string"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
restrictions[] | **object**<br><p>List of restrictions.</p> 
restrictions[].<br>name | **string**<br><p>Name of restriction.</p> 
restrictions[].<br>boolValue[] | **boolean** (boolean)<br><p>List of boolean restriction values. Empty if value type is not boolean.</p> 
restrictions[].<br>longValue[] | **string** (int64)<br><p>List of long restriction values. Empty if value type is not long.</p> 
restrictions[].<br>stringValue[] | **string**<br><p>List of string restriction values. Empty if value type is not string.</p> 