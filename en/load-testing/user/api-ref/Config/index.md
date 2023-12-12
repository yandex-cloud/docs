---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Config/index.md
---

# Load Testing API, REST: Config methods
A set of methods for managing test configurations.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "yamlString": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the test config. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the config belongs to.</p> 
yamlString | **string**<br><p>Config content in YAML format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a test config in the specified folder.
[get](get.md) | Returns the specified config.
[list](list.md) | Retrieves the list of configs in the specified folder.