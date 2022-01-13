---
editable: false
---

# Method getStats
Fetch stats of the bucket.
 

 
## HTTP request {#https-request}
```
GET https://storage.api.cloud.yandex.net/storage/v1/buckets/{name}:getStats
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
name | Required.
 
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
BucketStats describes bucket statistics.
 
Field | Description
--- | ---
name | **string**<br><p>Counters holds amount and size of various type of objects. Requested bucket name.</p> 
maxSize | **integer** (int64)<br><p>Maximum size of bucket.</p> 
usedSize | **string** (int64)<br><p>Size of used space in bucket.</p> 
storageClassMaxSizes[] | **object**<br><p>Maximum size of bucket in projection of storage classes.</p> 
storageClassMaxSizes[].<br>storageClass | **string**<br>
storageClassMaxSizes[].<br>classSize | **integer** (int64)<br>
storageClassUsedSizes[] | **object**<br><p>Size of used space in projection of storage classes.</p> 
storageClassUsedSizes[].<br>storageClass | **string**<br>
storageClassUsedSizes[].<br>classSize | **string** (int64)<br>
storageClassCounters[] | **object**<br><p>Meta-info about objects stored in bucket in projection of storage classes.</p> 
storageClassCounters[].<br>storageClass | **string**<br>
storageClassCounters[].<br>counters | **object**<br>
storageClassCounters[].<br>counters.<br>simpleObjectSize | **string** (int64)<br>
storageClassCounters[].<br>counters.<br>simpleObjectCount | **string** (int64)<br>
storageClassCounters[].<br>counters.<br>objectsPartsSize | **string** (int64)<br>
storageClassCounters[].<br>counters.<br>objectsPartsCount | **string** (int64)<br>
storageClassCounters[].<br>counters.<br>multipartObjectsSize | **string** (int64)<br>
storageClassCounters[].<br>counters.<br>multipartObjectsCount | **string** (int64)<br>
storageClassCounters[].<br>counters.<br>activeMultipartCount | **string** (int64)<br>
defaultStorageClass | **string**<br><p>Bucket's default storage class.</p> 
anonymousAccessFlags | **object**<br>
anonymousAccessFlags.<br>read | **boolean** (boolean)<br>
anonymousAccessFlags.<br>list | **boolean** (boolean)<br>
anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
updatedAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 