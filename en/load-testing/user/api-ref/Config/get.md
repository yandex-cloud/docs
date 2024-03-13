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
  "yamlString": "string",
  "name": "string",
  "createdAt": "string",
  "createdBy": "string"
}
```
Test config.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the test config. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the config belongs to.</p> 
yamlString | **string**<br><p>Config content in YAML format.</p> 
name | **string**<br><p>Name of the config.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>UA or SA that created the config.</p> 