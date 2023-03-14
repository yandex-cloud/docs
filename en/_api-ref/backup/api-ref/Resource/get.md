---
editable: false
---

# Cloud Backup API, REST: Resource.get
Get specific compute instance.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/resources/{computeInstanceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
computeInstanceId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resource": {
    "computeInstanceId": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "online": true,
    "enabled": true,
    "status": "string",
    "statusDetails": "string",
    "statusProgress": "string",
    "lastBackupTime": "string",
    "nextBackupTime": "string",
    "resourceId": "string",
    "isActive": true
  }
}
```

 
Field | Description
--- | ---
resource | **object**
resource.<br>computeInstanceId | **string**
resource.<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>online | **boolean** (boolean)
resource.<br>enabled | **boolean** (boolean)
resource.<br>status | **string**<br><ul> <li>IDLE: Instance is doing nothing right now.</li> <li>BACKUPING: Instance currently backing up itself.</li> <li>RECOVERING: Instance currently recovering itself.</li> <li>FAILED: Instance in failure state, check content of status_details field for more information.</li> <li>OTHER: Unspecified state, check status_details field for more information.</li> </ul> 
resource.<br>statusDetails | **string**<br><p>If status value is one of OTHER or FAILED, detailed info might be stored here.</p> 
resource.<br>statusProgress | **string** (int64)<br><p>In case status is one of BACKUPING or RECOVERING, progress value might be found here.</p> 
resource.<br>lastBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>nextBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>resourceId | **string**<br><p>Resource Identifier used to identify instance in backup service.</p> 
resource.<br>isActive | **boolean** (boolean)<br><p>is_active shows whether current instance controls cloud backup resource. If is_active is false it means instance is not able to manipulate cloud backup resource.</p> 