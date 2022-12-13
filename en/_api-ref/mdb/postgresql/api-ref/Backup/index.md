---
editable: false
---

# Managed Service for PostgreSQL API, REST: Backup methods
A set of methods for managing PostgreSQL Backup resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "size": "string",
  "type": "string",
  "method": "string",
  "journalSize": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
sourceClusterId | **string**<br><p>ID of the PostgreSQL cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
size | **string** (int64)<br><p>Size of backup, in bytes</p> 
type | **string**<br><p>How this backup was created (manual/automatic/etc...)</p> <ul> <li>AUTOMATED: Backup created by automated daily schedule</li> <li>MANUAL: Backup created by user request</li> </ul> 
method | **string**<br><p>Method of backup creation</p> <ul> <li>BASE: Base backup</li> <li>INCREMENTAL: Delta (incremental) PostgreSQL backup</li> </ul> 
journalSize | **string** (int64)<br><p>Size of the journal associated with backup, in bytes</p> 

## Methods {#methods}
Method | Description
--- | ---
[delete](delete.md) | Deletes the specified PostgreSQL cluster backup.
[get](get.md) | Returns the specified PostgreSQL Backup resource.
[list](list.md) | Retrieves the list of Backup resources available for the specified folder.