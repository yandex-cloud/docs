---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Policy/listApplications.md
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
policyId | <p>Policy ID.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Folder ID.</p> 
computeInstanceId | <p>Compute Cloud instance ID.</p> 
showProcessing | <p>If true, also returns applications that in the process of binding.</p> 
 
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
      "createdAt": "string",
      "isProcessing": true
    }
  ]
}
```

 
Field | Description
--- | ---
applications[] | **object**
applications[].<br>policyId | **string**<br><p>Policy ID.</p> 
applications[].<br>computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
applications[].<br>enabled | **boolean** (boolean)
applications[].<br>status | **string**<br><ul> <li>OK: Application is applied and everything is OK.</li> <li>RUNNING: Application is currently running.</li> <li>DISABLED: Application is disabled.</li> </ul> 
applications[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
applications[].<br>isProcessing | **boolean** (boolean)<br><p>If true, then the policy is in in the process of binding to the instance.</p> 