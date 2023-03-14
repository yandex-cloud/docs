---
editable: false
---

# Cloud Backup API, REST: Backup methods
A set of methods for managing backups.
## JSON Representation {#representation}
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
  "sourceKey": "string",
  "sourceUsn": "string",
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
  "markedForDeletion": true,
  "notarized": true,
  "deletedImmutable": true,
  "validationStatus": true,
  "createdInNetworkIsolation": true,
  "deleted": true,
  "policyId": "string",
  "resourceId": "string"
}
```
 
Field | Description
--- | ---
id | **string**
vaultId | **string**
archiveId | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lastSeenAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
size | **string** (int64)
deduplicatedSize | **string** (int64)
backedUpDataSize | **string** (int64)
originalDataSize | **string** (int64)
attributes | **object**
attributes.<br>streamName | **string**
attributes.<br>uri | **string**
computeInstanceId | **string**
sourceKey | **string**
sourceUsn | **string** (int64)
disks[] | **object**
disks[].<br>deviceModel | **string**
disks[].<br>name | **string**
disks[].<br>size | **string** (int64)
disks[].<br>volumes[] | **object**
disks[].<br>volumes[].<br>freeSpace | **string** (int64)
disks[].<br>volumes[].<br>isBootable | **boolean** (boolean)
disks[].<br>volumes[].<br>isSystem | **boolean** (boolean)
disks[].<br>volumes[].<br>name | **string**
disks[].<br>volumes[].<br>size | **string** (int64)
disks[].<br>volumes[].<br>mountStrid | **string**
type | **string**<br><p>Backup type For detailed information, please see <a href="/docs/backup/concepts/backup#types">backup types</a></p> 
markedForDeletion | **boolean** (boolean)
notarized | **boolean** (boolean)
deletedImmutable | **boolean** (boolean)
validationStatus | **boolean** (boolean)
createdInNetworkIsolation | **boolean** (boolean)
deleted | **boolean** (boolean)
policyId | **string**
resourceId | **string**

## Methods {#methods}
Method | Description
--- | ---
[delete](delete.md) | Delete specific backup.
[list](list.md) | List backups using filters.
[listArchives](listArchives.md) | List Acrhives that holds backups for specified folder_id or specified compute_isntance_id.
[startRecovery](startRecovery.md) | Start recovery process of specified backup id to specific compute instance.