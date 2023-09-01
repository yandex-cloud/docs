---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/list.md
---

# Cloud Backup API, REST: Backup.list
List backups using filters.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/backups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
computeInstanceId | <p>List backups that belongs to specific Compute Cloud instance.</p> 
archive.archiveId | <p>Required. Archive ID.</p> 
archive.folderId | <p>Required. Folder ID.</p> 
folderId | <p>List backups that belongs to specific folder.</p> 
instancePolicy.computeInstanceId | <p>Compute Cloud instance ID.</p> 
instancePolicy.policyId | <p>Policy ID.</p> 
resourceId | <p>List backups by specific resource ID.</p> 
policyId | <p>List backups by specific policy ID.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "createdAt desc" if omitted.</p> 
filter | <p>Filter list by various parameters. Supported parameters are:</p> <ul> <li>created_at</li> </ul> <p>Supported logic operators:</p> <ul> <li>AND</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "backups": [
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
  ]
}
```

 
Field | Description
--- | ---
backups[] | **object**
backups[].<br>id | **string**<br><p>ID of the backup.</p> 
backups[].<br>vaultId | **string**<br><p>ID of the backup vault.</p> 
backups[].<br>archiveId | **string**<br><p>ID of the backup archive.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>lastSeenAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>size | **string** (int64)<br><p>Backup size.</p> 
backups[].<br>deduplicatedSize | **string** (int64)<br><p>Deduplicated backup size.</p> 
backups[].<br>backedUpDataSize | **string** (int64)<br><p>Backed up data size.</p> 
backups[].<br>originalDataSize | **string** (int64)<br><p>Original data size.</p> 
backups[].<br>attributes | **object**<br><p>Backup attributes.</p> 
backups[].<br>attributes.<br>streamName | **string**<br><p>Backup stream name.</p> 
backups[].<br>attributes.<br>uri | **string**<br><p>URI of the backup archive.</p> 
backups[].<br>computeInstanceId | **string**<br><p>Compute Cloud instance ID.</p> 
backups[].<br>disks[] | **object**
backups[].<br>disks[].<br>deviceModel | **string**<br><p>Device model.</p> 
backups[].<br>disks[].<br>name | **string**<br><p>Disk name.</p> 
backups[].<br>disks[].<br>size | **string** (int64)<br><p>Disk size.</p> 
backups[].<br>disks[].<br>volumes[] | **object**
backups[].<br>disks[].<br>volumes[].<br>freeSpace | **string** (int64)<br><p>Free space in the volume.</p> 
backups[].<br>disks[].<br>volumes[].<br>isBootable | **boolean** (boolean)<br><p>If this field is true, it means that the volume is bootable.</p> 
backups[].<br>disks[].<br>volumes[].<br>isSystem | **boolean** (boolean)<br><p>If this field is true, it means that the volume is a system volume.</p> 
backups[].<br>disks[].<br>volumes[].<br>name | **string**<br><p>Volume name.</p> 
backups[].<br>disks[].<br>volumes[].<br>size | **string** (int64)<br><p>Volume size.</p> 
backups[].<br>disks[].<br>volumes[].<br>mountStrid | **string**<br><p>Mount string ID.</p> 
backups[].<br>type | **string**<br><p>Backup type. For detailed information, please see <a href="/docs/backup/concepts/backup#types">Backup types</a>.</p> 
backups[].<br>deleted | **boolean** (boolean)<br><p>If this field is true, it means that the backup was deleted.</p> 
backups[].<br>policyId | **string**<br><p><a href="/docs/backup/concepts/policy">Policy</a> ID.</p> 
backups[].<br>resourceId | **string**<br><p>Resource ID. It identifies Compute Cloud instance in backup service.</p> 