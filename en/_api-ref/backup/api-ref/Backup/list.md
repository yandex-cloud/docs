---
editable: false
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
computeInstanceId | <p>List backups that belongs to specific Compute Instance.</p> 
archive.archiveId | <p>Required.</p> 
archive.folderId | <p>Required.</p> 
folderId | <p>List backups that belongs to specific folder id.</p> 
 
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
  ]
}
```

 
Field | Description
--- | ---
backups[] | **object**
backups[].<br>id | **string**
backups[].<br>vaultId | **string**
backups[].<br>archiveId | **string**
backups[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>lastSeenAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backups[].<br>size | **string** (int64)
backups[].<br>deduplicatedSize | **string** (int64)
backups[].<br>backedUpDataSize | **string** (int64)
backups[].<br>originalDataSize | **string** (int64)
backups[].<br>attributes | **object**
backups[].<br>attributes.<br>streamName | **string**
backups[].<br>attributes.<br>uri | **string**
backups[].<br>computeInstanceId | **string**
backups[].<br>sourceKey | **string**
backups[].<br>sourceUsn | **string** (int64)
backups[].<br>disks[] | **object**
backups[].<br>disks[].<br>deviceModel | **string**
backups[].<br>disks[].<br>name | **string**
backups[].<br>disks[].<br>size | **string** (int64)
backups[].<br>disks[].<br>volumes[] | **object**
backups[].<br>disks[].<br>volumes[].<br>freeSpace | **string** (int64)
backups[].<br>disks[].<br>volumes[].<br>isBootable | **boolean** (boolean)
backups[].<br>disks[].<br>volumes[].<br>isSystem | **boolean** (boolean)
backups[].<br>disks[].<br>volumes[].<br>name | **string**
backups[].<br>disks[].<br>volumes[].<br>size | **string** (int64)
backups[].<br>disks[].<br>volumes[].<br>mountStrid | **string**
backups[].<br>type | **string**<br><p>Backup type For detailed information, please see <a href="/docs/backup/concepts/backup#types">backup types</a></p> 
backups[].<br>markedForDeletion | **boolean** (boolean)
backups[].<br>notarized | **boolean** (boolean)
backups[].<br>deletedImmutable | **boolean** (boolean)
backups[].<br>validationStatus | **boolean** (boolean)
backups[].<br>createdInNetworkIsolation | **boolean** (boolean)
backups[].<br>deleted | **boolean** (boolean)
backups[].<br>policyId | **string**
backups[].<br>resourceId | **string**