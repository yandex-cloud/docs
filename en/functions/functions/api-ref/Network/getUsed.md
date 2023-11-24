---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/getUsed.md
---

# Cloud Functions Service, REST: Network.getUsed
Returns the specified network used in serverless resources.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/networks/used/{networkId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | <p>Required. ID of the network to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "networkId": "string",
  "cloudId": "string",
  "folderId": "string",
  "status": "string",
  "willBeCleanedUpAt": "string",
  "connectionsCount": "string"
}
```
A VPC network used in serverless resources.
 
Field | Description
--- | ---
networkId | **string**<br><p>ID of the VPC network.</p> 
cloudId | **string**<br><p>ID of the cloud that the network belongs to.</p> 
folderId | **string**<br><p>ID of the folder that the network belongs to.</p> 
status | **string**<br><p>Status of the network.</p> <ul> <li>CREATING: Network is connecting to its first serverless resource.</li> <li>ACTIVE: Network is already being used by some serverless resources.</li> <li>OBSOLETE: Network is no longer used by any serverless resources. It will be cleaned-up after a while.</li> </ul> 
willBeCleanedUpAt | **string** (date-time)<br><p>Clean-up timestamp of the obsolete network.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
connectionsCount | **string** (int64)<br><p>Number of serverless resources connected to the network.</p> 