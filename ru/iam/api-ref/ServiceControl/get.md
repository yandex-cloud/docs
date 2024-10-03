---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceControl/get.md
---

# Identity and Access Management API, REST: ServiceControl.get
Returns the Service information in the specified resource container.
 
To get the list of available Services, make a [list](/docs/iam/api-ref/ServiceControl/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/services/{serviceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
serviceId | <p>Required. ID of the Service.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resource.id | <p>Required. ID of the resource.</p> <p>The maximum string length in characters is 50.</p> 
resource.type | <p>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.</p> <p>The maximum string length in characters is 64.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "serviceId": "string",
  "resource": {
    "id": "string",
    "type": "string"
  },
  "updatedAt": "string",
  "status": "string"
}
```
A Service.
 
Field | Description
--- | ---
serviceId | **string**<br><p>ID of the service.</p> 
resource | **object**<br><p>Resource that the service belongs to.</p> <p>A Resource. For more information, see <a href="/docs/iam/concepts/access-control/resources-with-access-control">Resource</a>.</p> 
resource.<br>id | **string**<br><p>Required. ID of the resource.</p> <p>The maximum string length in characters is 50.</p> 
resource.<br>type | **string**<br><p>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.</p> <p>The maximum string length in characters is 64.</p> 
updatedAt | **string** (date-time)<br><p>Time of the last status update of the service.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
status | **string**<br><p>Current status of the service.</p> <ul> <li>ENABLED: The service is enabled.</li> <li>PAUSED: The service is paused.</li> <li>DISABLED: The service is disabled.</li> <li>ENABLING: The service is being enabled.</li> <li>RESUMING: The service is being resumed.</li> <li>PAUSING: The service is being paused.</li> <li>DISABLING: The service is being disabled.</li> <li>ERROR: The service is in error state.</li> <li>DEFAULT: The service could be auto enabled.</li> </ul> 