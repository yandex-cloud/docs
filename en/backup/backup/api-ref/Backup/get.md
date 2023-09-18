---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/get.md
---

# Cloud Backup API, REST: Backup.get
Get backup by its id.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. Backup ID.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "vaultId": "string",
  "archiveId": "string",
  "createdAt": "string",
  "lastSeenAt": "string",
  "size": "string",
  "deduplicatedSize": "string",
  "backedUpDataSize": "string",
  "originalDataSize": "string",
  "attributes": {
    "streamName": "string",
    "uri": "string"
  },
  "computeInstanceId": "string",
  "disks": [
    {
      "deviceModel": "string",
      "name": "string",
      "size": "string",
      "volumes": [
        {
          "freeSpace": "string",
          "isBootable": true,
          "isSystem": true,
          "name": "string",
          "size": "string",
          "mountStrid": "string"
        }
      ]
    }
  ],
  "type": "string",
  "deleted": true,
  "policyId": "string",
  "resourceId": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the backup.</p> 
vaultId | **string**<br><p>ID of the backup vault.</p> 
archiveId | **string**<br><p>ID of the backup archive.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lastSeenAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
size | **string** (int64)<br><p>Backup size.</p> 
deduplicatedSize | **string** (int64)<br><p>Deduplicated backup size.</p> 
backedUpDataSize | **string** (int64)<br><p>Backed up data size.</p> 
originalDataSize | **string** (int64)<br><p>Original data size.</p> 
attributes | **object**<br><p>Backup attributes.</p> 
attributes.<br>streamName | **string**<br><p>Backup stream name.</p> 
attributes.<br>uri | **string**<br><p>URI of the backup archive.</p> 
computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
disks[] | **object**
disks[].<br>deviceModel | **string**<br><p>Device model.</p> 
disks[].<br>name | **string**<br><p>Disk name.</p> 
disks[].<br>size | **string** (int64)<br><p>Disk size.</p> 
disks[].<br>volumes[] | **object**
disks[].<br>volumes[].<br>freeSpace | **string** (int64)<br><p>Free space in the volume.</p> 
disks[].<br>volumes[].<br>isBootable | **boolean** (boolean)<br><p>If this field is true, it means that the volume is bootable.</p> 
disks[].<br>volumes[].<br>isSystem | **boolean** (boolean)<br><p>If this field is true, it means that the volume is a system volume.</p> 
disks[].<br>volumes[].<br>name | **string**<br><p>Volume name.</p> 
disks[].<br>volumes[].<br>size | **string** (int64)<br><p>Volume size.</p> 
disks[].<br>volumes[].<br>mountStrid | **string**<br><p>Mount string ID.</p> 
type | **string**<br><p>Backup type. For detailed information, please see <a href="/docs/backup/concepts/backup#types">Backup types</a>.</p> 
deleted | **boolean** (boolean)<br><p>If this field is true, it means that the backup was deleted.</p> 
policyId | **string**<br><p><a href="/docs/backup/concepts/policy">Policy</a> ID.</p> 
resourceId | **string**<br><p>Resource ID. It identifies Compute Cloud instance in backup service.</p> 