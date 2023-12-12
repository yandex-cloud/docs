---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Config/get.md
---

# Load Testing API, REST: Config.get
Returns the specified config.
 
To get the list of all available configs, make a [list](/docs/load-testing/user/api-ref/Config/list) request.
 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/configs/{configId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
configId | <p>ID of the config to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "yamlString": "string"
}
```
Test config.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the test config. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the config belongs to.</p> 
yamlString | **string**<br><p>Config content in YAML format.</p> 