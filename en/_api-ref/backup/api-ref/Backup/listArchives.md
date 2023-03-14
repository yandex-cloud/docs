---
editable: false
---

# Cloud Backup API, REST: Backup.listArchives
List Acrhives that holds backups for specified folder_id or
specified compute_isntance_id.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/backups/{computeInstanceId}/archives
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
computeInstanceId | <p>List of archives of the specified compute_instance_id.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>List of archives in specified folder.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "archives": [
    {
      "id": "string",
      "name": "string",
      "vaultId": "string",
      "attributes": {
        "aaib": "string",
        "uri": "string"
      },
      "size": "string",
      "compressedDataSize": "string",
      "dataSize": "string",
      "originalDataSize": "string",
      "logicalSize": "string",
      "format": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "lastBackupCreatedAt": "string",
      "lastSeenAt": "string",
      "protectedByPassword": true,
      "encryptionAlgorithm": "string",
      "fileName": "string",
      "sourceKey": "string",
      "sourceUsn": "string",
      "actions": [
        "string"
      ],
      "centralizedPlanId": "string",
      "backupPlanId": "string",
      "backupPlanName": "string",
      "description": "string",
      "displayName": "string",
      "computeInstanceId": "string",
      "consistent": true,
      "markedForDeletion": true,
      "deletedImmutable": true,
      "deleted": true,
      "resourceId": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
archives[] | **object**<br><p>Archive is a container that holds backups of Instance.</p> 
archives[].<br>id | **string**
archives[].<br>name | **string**
archives[].<br>vaultId | **string**
archives[].<br>attributes | **object**
archives[].<br>attributes.<br>aaib | **string**
archives[].<br>attributes.<br>uri | **string**
archives[].<br>size | **string** (int64)
archives[].<br>compressedDataSize | **string** (int64)
archives[].<br>dataSize | **string** (int64)
archives[].<br>originalDataSize | **string** (int64)
archives[].<br>logicalSize | **string** (int64)
archives[].<br>format | **string**<br><p>Format of the backup in policy. For backup locations that can be browsed with a file manager, the backup format detemines the number of files and their extention.</p> <ul> <li>VERSION_11: A legacy backup format used in older versions. It's not recommended to use.</li> <li>VERSION_12: A new format recommende din most cases for fast backup and recovery.</li> <li>AUTO: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li> </ul> 
archives[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>lastBackupCreatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>lastSeenAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>protectedByPassword | **boolean** (boolean)<br><p>If this field is true, it means that any of encryption algorithm has been choosen.</p> 
archives[].<br>encryptionAlgorithm | **string**<br><p>Encryption Algorithm for underlying backups.</p> 
archives[].<br>fileName | **string**
archives[].<br>sourceKey | **string**
archives[].<br>sourceUsn | **string** (int64)
archives[].<br>actions[] | **string**
archives[].<br>centralizedPlanId | **string**
archives[].<br>backupPlanId | **string**
archives[].<br>backupPlanName | **string**
archives[].<br>description | **string**
archives[].<br>displayName | **string**
archives[].<br>computeInstanceId | **string**
archives[].<br>consistent | **boolean** (boolean)
archives[].<br>markedForDeletion | **boolean** (boolean)
archives[].<br>deletedImmutable | **boolean** (boolean)
archives[].<br>deleted | **boolean** (boolean)
archives[].<br>resourceId | **string**