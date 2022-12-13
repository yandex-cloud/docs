---
editable: false
sourcePath: en/_api-ref/storage/api-ref/Bucket/getStats.md
---

# Object Storage API, REST: Bucket.getStats
Returns the statistics for the specified bucket.
 

 
## HTTP request {#https-request}
```
GET https://storage.{{ api-host }}/storage/v1/buckets/{name}:getStats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | <p>Required. Name of the bucket to return the statistics for.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "maxSize": "integer",
  "usedSize": "string",
  "storageClassMaxSizes": [
    {
      "storageClass": "string",
      "classSize": "integer"
    }
  ],
  "storageClassUsedSizes": [
    {
      "storageClass": "string",
      "classSize": "string"
    }
  ],
  "storageClassCounters": [
    {
      "storageClass": "string",
      "counters": {
        "simpleObjectSize": "string",
        "simpleObjectCount": "string",
        "objectsPartsSize": "string",
        "objectsPartsCount": "string",
        "multipartObjectsSize": "string",
        "multipartObjectsCount": "string",
        "activeMultipartCount": "string"
      }
    }
  ],
  "defaultStorageClass": "string",
  "anonymousAccessFlags": {
    "read": true,
    "list": true,
    "configRead": true
  },
  "createdAt": "string",
  "updatedAt": "string"
}
```
A bucket statistics resource.
 
Field | Description
--- | ---
name | **string**<br><p>Name of the bucket.</p> 
maxSize | **integer** (int64)<br><p>Maximum size of the bucket, in bytes.</p> 
usedSize | **string** (int64)<br><p>Size of used space in the bucket, in bytes.</p> 
storageClassMaxSizes[] | **object**<br><p>Size of available space in the bucket by storage class, in bytes.</p> 
storageClassMaxSizes[].<br>storageClass | **string**<br><p>Storage class. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ICE`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
storageClassMaxSizes[].<br>classSize | **integer** (int64)<br><p>Size of available space in the bucket for the storage class.</p> 
storageClassUsedSizes[] | **object**<br><p>Size of used space in the bucket by storage class, in bytes.</p> 
storageClassUsedSizes[].<br>storageClass | **string**<br><p>Storage class. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ICE`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
storageClassUsedSizes[].<br>classSize | **string** (int64)<br><p>Size of used space in the bucket for the storage class.</p> 
storageClassCounters[] | **object**<br><p>Object-related statistics by storage class and type of upload (simple vs. multipart), in bytes.</p> 
storageClassCounters[].<br>storageClass | **string**<br><p>Storage class. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ice`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
storageClassCounters[].<br>counters | **object**<br><p>Object-related statistics for the storage class by type of upload.</p> 
storageClassCounters[].<br>counters.<br>simpleObjectSize | **string** (int64)<br><p>Total size of objects uploaded in single operation, in bytes.</p> 
storageClassCounters[].<br>counters.<br>simpleObjectCount | **string** (int64)<br><p>Number of objects uploaded in single operation.</p> 
storageClassCounters[].<br>counters.<br>objectsPartsSize | **string** (int64)<br><p>Total size of uploaded parts in incomplete multipart uploads, in bytes.</p> 
storageClassCounters[].<br>counters.<br>objectsPartsCount | **string** (int64)<br><p>Number of uploaded parts in incomplete multipart uploads.</p> 
storageClassCounters[].<br>counters.<br>multipartObjectsSize | **string** (int64)<br><p>Total size of objects uploaded in multiple parts, in bytes.</p> 
storageClassCounters[].<br>counters.<br>multipartObjectsCount | **string** (int64)<br><p>Number of objects uploaded in multiple parts.</p> 
storageClassCounters[].<br>counters.<br>activeMultipartCount | **string** (int64)<br><p>Number of incomplete multipart uploads.</p> 
defaultStorageClass | **string**<br><p>Default storage class for objects in the bucket. Supported classes are standard storage (``STANDARD``), cold storage (``COLD``, ``STANDARD_IA``, ``NEARLINE`` all synonyms), and ice storage (``ICE`` and ``GLACIER`` are synonyms). For details, see <a href="/docs/storage/concepts/storage-class">documentation</a>.</p> 
anonymousAccessFlags | **object**<br><p>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see <a href="/docs/storage/concepts/bucket#bucket-access">documentation</a>.</p> 
anonymousAccessFlags.<br>read | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read objects in the bucket is enabled.</p> 
anonymousAccessFlags.<br>list | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.</p> 
anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br><p>Specifies whether public (anonymous) access to read <a href="/docs/storage/concepts/cors">CORS</a>, <a href="/docs/storage/concepts/hosting">static website hosting</a>, and <a href="/docs/storage/concepts/lifecycles">object lifecycles</a> settings of the bucket is enabled.</p> 
createdAt | **string** (date-time)<br><p>Bucket creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Bucket latest update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 