---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Backup/index.md
---

# Managed Service for OpenSearch API, REST: Backup methods
A set of methods for managing backups.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "createdAt": "string",
  "indices": [
    "string"
  ],
  "opensearchVersion": "string",
  "sizeBytes": "string",
  "indicesTotal": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
sourceClusterId | **string**<br><p>ID of the OpenSearch cluster that the backup was created for.</p> 
startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdAt | **string** (date-time)<br><p>Time when the backup operation was completed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
indices[] | **string**<br><p>Names of indices in the backup.</p> <p>The maximum number of elements is 100.</p> 
opensearchVersion | **string**<br><p>OpenSearch version used to create the backup.</p> 
sizeBytes | **string** (int64)<br><p>Size of the backup in bytes.</p> 
indicesTotal | **string** (int64)<br><p>The number of indices in the backup.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified backup of an OpenSearch cluster.
[list](list.md) | Returns the list of available backups for the specified OpenSearch cluster.