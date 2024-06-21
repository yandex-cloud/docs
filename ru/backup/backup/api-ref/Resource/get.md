---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Resource/get.md
---

# Cloud Backup API, REST: Resource.get
Get specific Compute Cloud instance.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/resources/{computeInstanceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
computeInstanceId | <p>Required. Compute Cloud instance ID.</p> <p>The maximum string length in characters is 50.</p> 
 
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
    "isActive": true,
    "initStatus": "string",
    "metadata": "string"
  }
}
```

 
Field | Description
--- | ---
resource | **object**<br><p>Set of resource parameters.</p> 
resource.<br>computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
resource.<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>online | **boolean** (boolean)<br><p>If this field is true, it means that instance is online.</p> 
resource.<br>enabled | **boolean** (boolean)<br><p>If this field is true, it means that backup is enabled to instance.</p> 
resource.<br>status | **string**<br><ul> <li>IDLE: Compute Cloud instance is doing nothing right now.</li> <li>BACKUPING: Compute Cloud instance is currently backing up itself.</li> <li>RECOVERING: Compute Cloud instance is currently recovering itself.</li> <li>FAILED: Compute Cloud instance is in failure state, check content of ``status_details`` field for more information.</li> <li>OTHER: Unspecified state, check ``status_details`` field for more information.</li> </ul> 
resource.<br>statusDetails | **string**<br><p>If status value is one of ``OTHER`` or ``FAILED``, detailed info might be stored here.</p> 
resource.<br>statusProgress | **string** (int64)<br><p>In case status is one of ``BACKUPING`` or ``RECOVERING``, progress value might be found here.</p> 
resource.<br>lastBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>nextBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resource.<br>resourceId | **string**<br><p>Resource ID is used to identify Compute Cloud instance in backup service.</p> 
resource.<br>isActive | **boolean** (boolean)<br><p>Status ``is_active`` shows whether current Compute Cloud instance controls Cloud Backup resource. If status ``is_active`` is false it means Compute Cloud instance is not able to manipulate Cloud Backup resource.</p> 
resource.<br>initStatus | **string**<br><p>Status of resource initialization in cloud backup service.</p> <ul> <li>REGISTERING: Registration of instance in cloud backups have started.</li> <li>REGISTRED: Instance is registered in cloud backups.</li> <li>FAILED_REGISTRATION: Instance registration failed.</li> <li>DELETED: Instance is deleted from cloud backup service.</li> </ul> 
resource.<br>metadata | **string**<br><p>Metadata to provide details about instance registration process if status is FAILED_REGISTRATION or REGISTERING</p> 