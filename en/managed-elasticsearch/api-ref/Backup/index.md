---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Backup/index.md
---

# Managed Service for Elasticsearch API, REST: Backup methods

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
  "elasticsearchVersion": "string",
  "sizeBytes": "string",
  "indicesTotal": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the backup.</p> 
folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
sourceClusterId | **string**<br><p>ID of the associated Elasticsearch cluster.</p> 
startedAt | **string** (date-time)<br><p>The time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdAt | **string** (date-time)<br><p>The time when the backup was created (i.e. when the backup operation completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
indices[] | **string**<br><p>Indices names. (max 100)</p> <p>The maximum number of elements is 100.</p> 
elasticsearchVersion | **string**<br><p>Elasticsearch version used to create the snapshot</p> 
sizeBytes | **string** (int64)<br><p>Total size of all indices in backup. in bytes</p> 
indicesTotal | **string** (int64)<br><p>Total count of indices in backup</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified backup of Elasticsearch cluster.
[list](list.md) | Returns the list of available backups for the specified Elasticsearch cluster.