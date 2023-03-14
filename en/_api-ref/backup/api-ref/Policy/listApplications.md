---
editable: false
---

# Cloud Backup API, REST: Policy.listApplications
List applied policies using filters.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/policies/{policyId}/applications
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
policyId | 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
computeInstanceId | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "applications": [
    {
      "policyId": "string",
      "computeInstanceId": "string",
      "enabled": true,
      "status": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
applications[] | **object**
applications[].<br>policyId | **string**
applications[].<br>computeInstanceId | **string**
applications[].<br>enabled | **boolean** (boolean)
applications[].<br>status | **string**<br><ul> <li>OK: Application is applied and everyhing is ok.</li> <li>RUNNING: Application is currently running.</li> <li>DISABLED: Application is disabled.</li> </ul> 
applications[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 