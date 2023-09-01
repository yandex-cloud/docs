---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/listArchives.md
---

# Cloud Backup API, REST: Backup.listArchives
List archives that holds backups for specified folder or
specified [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/backups/{computeInstanceId}/archives
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
computeInstanceId | <p>List of archives of the specified Compute Cloud instance.</p> 
 
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
      "actions": [
        "string"
      ],
      "backupPlanId": "string",
      "backupPlanName": "string",
      "description": "string",
      "displayName": "string",
      "computeInstanceId": "string",
      "consistent": true,
      "deleted": true,
      "resourceId": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
archives[] | **object**<br><p>Archive is a container that holds backups of Compute Cloud instance.</p> 
archives[].<br>id | **string**<br><p>ID of the backup.</p> 
archives[].<br>name | **string**<br><p>Name of the backup.</p> 
archives[].<br>vaultId | **string**<br><p>ID of the backup vault.</p> 
archives[].<br>attributes | **object**<br><p>Archive attributes.</p> <p>Archive attributes.</p> 
archives[].<br>attributes.<br>aaib | **string**<br><p>Archive attribute. Default value: ``0``.</p> 
archives[].<br>attributes.<br>uri | **string**<br><p>URI of the backup archive.</p> 
archives[].<br>size | **string** (int64)<br><p>Archive size.</p> 
archives[].<br>compressedDataSize | **string** (int64)<br><p>Compressed data size.</p> 
archives[].<br>dataSize | **string** (int64)<br><p>Data size.</p> 
archives[].<br>originalDataSize | **string** (int64)<br><p>Original data size.</p> 
archives[].<br>logicalSize | **string** (int64)<br><p>Logical size.</p> 
archives[].<br>format | **string**<br><p>Format of the backup in policy. For backup locations that can be browsed with a file manager, the backup format determines the number of files and their extension.</p> <ul> <li>VERSION_11: A legacy backup format used in older versions. It's not recommended to use.</li> <li>VERSION_12: A new format recommended in most cases for fast backup and recovery.</li> <li>AUTO: Automatic version selection. Will be used version 12 unless the protection plan (policy) appends backups to the ones created by earlier product versions.</li> </ul> 
archives[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>lastBackupCreatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>lastSeenAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
archives[].<br>protectedByPassword | **boolean** (boolean)<br><p>If this field is true, it means that any of encryption algorithm has been chosen.</p> 
archives[].<br>encryptionAlgorithm | **string**<br><p>Encryption Algorithm for underlying backups: ``ENCRYPTION_ALGORITHM_UNSPECIFIED``, ``NONE``, ``AES128``, ``AES192``, ``AES256``.</p> 
archives[].<br>actions[] | **string**<br><p>Action with archive backup: ``ACTION_UNSPECIFIED``, ``REFRESH``, ``DELETE_BY_AGENT``.</p> 
archives[].<br>backupPlanId | **string**<br><p>Backup plan ID.</p> 
archives[].<br>backupPlanName | **string**<br><p>Backup plan name.</p> 
archives[].<br>description | **string**<br><p>Backup plan description.</p> 
archives[].<br>displayName | **string**<br><p>Display name, e.g. ``INSTANCE_NAME - POLICY_NAME``.</p> 
archives[].<br>computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
archives[].<br>consistent | **boolean** (boolean)<br><p>If this field is true, it means that the archive is consistent.</p> 
archives[].<br>deleted | **boolean** (boolean)<br><p>If this field is true, it means that the archive was deleted.</p> 
archives[].<br>resourceId | **string**<br><p>Resource ID.</p> 