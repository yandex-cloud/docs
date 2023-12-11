# Partial object updates

{{ objstorage-name }} has a mechanism for _partial updating and appending of objects data_ in a bucket.

{% include [patch-disclaimer](../../_includes/storage/patch-disclaimer.md) %}

With partial updates, you can store data (e.g., logs) in a bucket as a single file and append data to it from time to time.

This also simplifies large file processing. For example, to change one byte of information in a large file, you can use:
* Standard [get](../s3/api-ref/object/get.md) and [upload](../s3/api-ref/object/upload.md) S3 API methods by fully downloading and uploading the object back to the storage.
* [Patch](../s3/api-ref/object/patch.md) method by uploading only the changed/new part of the file to the storage.

Such partial overwrite streamlines your {{ objstorage-name }} operations and reduces costs.

With partial overwrite, the following will be overwritten on the server side:
* Object as a whole, if initially uploaded using the [PUT](../s3/api-ref/object/upload.md) method.
* Object components falling within the update range, if the object was initially [uploaded in parts](multipart.md).

This functionality is implemented as a [patch](../s3/api-ref/object/patch.md) method and is supported in [GeeseFS](../tools/geesefs.md#patch).

GeeseFS is the recommended tool for partial updating of objects in a bucket.

You can also directly [send patch requests](../s3/index.md) to the {{ objstorage-name }} API, or extend the set of [AWS SDK](../tools/) methods using the patch method [specification](#specification).

## Concurrent object updates {#concurrent-patch}

{{ objstorage-name }} supports concurrent partial object updates.

With a partial update, each parallel request is executed on a dedicated object snapshot. Therefore, different update requests for the same object are processed independently.

All changes during parallel requests are applied atomically.

## Conflict resolution {#conflicts}

A conflict resolution mechanism has been implemented for concurrent partial updates.

In a successful conflict resolution, the more recent update is applied.

The number of overwrite retries on the server side is limited. If the server fails to resolve conflicts, the user gets the `ConcurrentUpdatesPatchConflict` error.

## Specification {#specification}

```json
"PatchObject":{
  "name":"PatchObject",
  "http":{
    "method":"PATCH",
    "requestUri":"/{Bucket}/{Key+}"
  },
  "input":{"shape":"PatchObjectRequest"},
  "output":{"shape":"PatchObjectOutput"},
  "httpChecksum":{
    "requestAlgorithmMember":"ChecksumAlgorithm",
    "requestChecksumRequired":false
  }
},
"PatchAppendPartSize":{"type": "integer"},
"PatchedObjectInfo":{
  "type":"structure",
  "members":{
    "ETag":{"shape":"ETag"},
    "LastModified":{"shape":"LastModified"}
  }
},
"PatchObjectOutput":{
  "type":"structure",
  "members":{
    "Object":{"shape":"PatchedObjectInfo"}
  }
},
"PatchObjectRequest":{
  "type":"structure",
  "required":[
    "Bucket",
    "Key",
    "ContentRange"
  ],
  "members":{
    "Body":{
      "shape":"Body",
      "streaming":true
    },
    "Bucket":{
      "shape":"BucketName",
      "location":"uri",
      "locationName":"Bucket"
    },
    "ContentLength":{
      "shape":"ContentLength",
      "location":"header",
      "locationName":"Content-Length"
    },
    "ContentMD5":{
      "shape":"ContentMD5",
      "location":"header",
      "locationName":"Content-MD5"
    },
    "ContentRange":{
      "shape":"ContentRange",
      "location":"header",
      "locationName":"Content-Range"
    },
    "IfMatch":{
      "shape":"IfMatch",
      "location":"header",
      "locationName":"If-Match"
    },
    "IfUnmodifiedSince":{
      "shape":"IfUnmodifiedSince",
      "location":"header",
      "locationName":"If-Unmodified-Since"
    },
    "Key":{
      "shape":"ObjectKey",
      "location":"uri",
      "locationName":"Key"
    },
    "PatchAppendPartSize":{
      "shape":"PatchAppendPartSize",
      "location":"header",
      "locationName":"X-Yc-S3-Patch-Append-Part-Size"
    }
  },
  "payload":"Body"
},
```
