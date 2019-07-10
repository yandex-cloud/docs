---
editable: false
---

# Method listDeviceTopicAliases

 

 
## HTTP request {#https-request}
```
GET undefined/iot-devices/v1/registries/{registryId}:listDeviceTopicAliases
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
registryId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "aliases": [
    {
      "deviceId": "string",
      "topicPrefix": "string",
      "alias": "string"
    }
  ],
  "nextToken": "string"
}
```

 
Field | Description
--- | ---
aliases[] | **object**<br>
aliases[].<br>deviceId | **string**<br>
aliases[].<br>topicPrefix | **string**<br><p>prefix of canonical topic name to be aliased, e.g. $devices/abcdef</p> 
aliases[].<br>alias | **string**<br>
nextToken | **string**<br>