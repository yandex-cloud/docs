---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Resource/list.md
---

# Cloud Backup API, REST: Resource.list
List resources: Compute Cloud instances.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/resources
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>Number of results per page.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Token for the results page.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resources": [
    {
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resources[] | **object**<br><p>Set of resource parameters.</p> 
resources[].<br>computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
resources[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resources[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resources[].<br>online | **boolean** (boolean)<br><p>If this field is true, it means that instance is online.</p> 
resources[].<br>enabled | **boolean** (boolean)<br><p>If this field is true, it means that backup is enabled to instance.</p> 
resources[].<br>status | **string**<br><ul> <li>IDLE: Compute Cloud instance is doing nothing right now.</li> <li>BACKUPING: Compute Cloud instance is currently backing up itself.</li> <li>RECOVERING: Compute Cloud instance is currently recovering itself.</li> <li>FAILED: Compute Cloud instance is in failure state, check content of ``status_details`` field for more information.</li> <li>OTHER: Unspecified state, check ``status_details`` field for more information.</li> </ul> 
resources[].<br>statusDetails | **string**<br><p>If status value is one of ``OTHER`` or ``FAILED``, detailed info might be stored here.</p> 
resources[].<br>statusProgress | **string** (int64)<br><p>In case status is one of ``BACKUPING`` or ``RECOVERING``, progress value might be found here.</p> 
resources[].<br>lastBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resources[].<br>nextBackupTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resources[].<br>resourceId | **string**<br><p>Resource ID is used to identify Compute Cloud instance in backup service.</p> 
resources[].<br>isActive | **boolean** (boolean)<br><p>Status ``is_active`` shows whether current Compute Cloud instance controls Cloud Backup resource. If status ``is_active`` is false it means Compute Cloud instance is not able to manipulate Cloud Backup resource.</p> 
nextPageToken | **string**<br><p>Token for the next results page.</p> 