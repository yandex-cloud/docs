---
editable: false
apiPlayground:
  - url: https://storage.{{ api-host }}/storage/v1/buckets/{name}:getStats
    method: get
    path:
      type: object
      properties:
        name:
          description: |-
            **string**
            Required field. Name of the bucket to return the statistics for.
          type: string
      required:
        - name
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/storage/v1/api-ref/Bucket/getStats.md
---

# Object Storage API, REST: Bucket.GetStats

Returns the statistics for the specified bucket.

## HTTP request

```
GET https://storage.{{ api-host }}/storage/v1/buckets/{name}:getStats
```

## Path parameters

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket to return the statistics for. ||
|#

## Response {#yandex.cloud.storage.v1.BucketStats}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "maxSize": "string",
  "usedSize": "string",
  "storageClassMaxSizes": [
    {
      "storageClass": "string",
      "classSize": "string"
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
    "read": "boolean",
    "list": "boolean",
    "configRead": "boolean"
  },
  "createdAt": "string",
  "updatedAt": "string"
}
```

A bucket statistics resource.

#|
||Field | Description ||
|| name | **string**

Name of the bucket. ||
|| maxSize | **string** (int64)

Maximum size of the bucket, in bytes. ||
|| usedSize | **string** (int64)

Size of used space in the bucket, in bytes. ||
|| storageClassMaxSizes[] | **[OptionalSizeByClass](#yandex.cloud.storage.v1.OptionalSizeByClass)**

Size of available space in the bucket by storage class, in bytes. ||
|| storageClassUsedSizes[] | **[SizeByClass](#yandex.cloud.storage.v1.SizeByClass)**

Size of used space in the bucket by storage class, in bytes. ||
|| storageClassCounters[] | **[CountersByClass](#yandex.cloud.storage.v1.CountersByClass)**

Object-related statistics by storage class and type of upload (simple vs. multipart), in bytes. ||
|| defaultStorageClass | **string**

Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage
(`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| anonymousAccessFlags | **[AnonymousAccessFlags](#yandex.cloud.storage.v1.AnonymousAccessFlags)**

Flags for configuring public (anonymous) access to the bucket's content and settings.
For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). ||
|| createdAt | **string** (date-time)

Bucket creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Bucket latest update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## OptionalSizeByClass {#yandex.cloud.storage.v1.OptionalSizeByClass}

A resource for size of available space in a bucket for a storage class.

#|
||Field | Description ||
|| storageClass | **string**

Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE`
all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| classSize | **string** (int64)

Size of available space in the bucket for the storage class. ||
|#

## SizeByClass {#yandex.cloud.storage.v1.SizeByClass}

A resource for size of used space in a bucket for a storage class.

#|
||Field | Description ||
|| storageClass | **string**

Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE`
all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| classSize | **string** (int64)

Size of used space in the bucket for the storage class. ||
|#

## CountersByClass {#yandex.cloud.storage.v1.CountersByClass}

A resource for object-related statistics for a storage class by type of upload (simple vs. multipart).

#|
||Field | Description ||
|| storageClass | **string**

Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE`
all synonyms), and ice storage (`ice` and `GLACIER` are synonyms).
For details, see [documentation](/docs/storage/concepts/storage-class). ||
|| counters | **[Counters](#yandex.cloud.storage.v1.Counters)**

Object-related statistics for the storage class by type of upload. ||
|#

## Counters {#yandex.cloud.storage.v1.Counters}

#|
||Field | Description ||
|| simpleObjectSize | **string** (int64)

Total size of objects uploaded in single operation, in bytes. ||
|| simpleObjectCount | **string** (int64)

Number of objects uploaded in single operation. ||
|| objectsPartsSize | **string** (int64)

Total size of uploaded parts in incomplete multipart uploads, in bytes. ||
|| objectsPartsCount | **string** (int64)

Number of uploaded parts in incomplete multipart uploads. ||
|| multipartObjectsSize | **string** (int64)

Total size of objects uploaded in multiple parts, in bytes. ||
|| multipartObjectsCount | **string** (int64)

Number of objects uploaded in multiple parts. ||
|| activeMultipartCount | **string** (int64)

Number of incomplete multipart uploads. ||
|#

## AnonymousAccessFlags {#yandex.cloud.storage.v1.AnonymousAccessFlags}

#|
||Field | Description ||
|| read | **boolean**

Specifies whether public (anonymous) access to read objects in the bucket is enabled. ||
|| list | **boolean**

Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. ||
|| configRead | **boolean**

Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors),
[static website hosting](/docs/storage/concepts/hosting), and
[object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. ||
|#