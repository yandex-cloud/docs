# All services and methods

Object Storage The HTTP API provides the following services:

| Service | Description |
| ------- | --------- |
| [Bucket](bucket.md) | Manages the buckets. |
| [Object](object.md) | Performs object management. |
| [Multipart upload](multipart.md) | Controls uploading of large objects. |
| [Static Website Hosting](hosting.md) | Manages bucket configurations for static web hosting. |
| [CORS](cors.md) | Manages CORS configurations for buckets. |
| [Lifecycles](lifecycles.md) | Manages bucket object lifecycle configurations. |
| [ACL](acl.md) | Manages access control lists. |

## Supported methods {#operations-list}

### Bucket service

| Method | Description |
| ----- | ----- |
| [create](bucket/create.md) | Creates a bucket. |
| [getMeta](bucket/getmeta.md) | Checks the existence of a bucket and access to it. |
| [listObjects](bucket/listobjects.md) | Returns a list of bucket objects. |
| [listBuckets](bucket/list.md) | Returns a list of buckets. |
| [deleteBucket](bucket/delete.md) | Deletes a bucket. |

### Object service

| Method | Description |
| ----- | ----- |
| [upload](object/upload.md) | Uploads an object to Object Storage. |
| [get](object/get.md) | Retrieves an object from Object Storage. |
| [copy](object/copy.md) | Copies an object stored in Object Storage. |
| [getObjectMeta](object/getobjectmeta.md) | Retrieves object metadata. |
| [delete](object/delete.md) | Deletes an object. |
| [deleteMultipleObjecs](object/deletemultipleobjects.md) | Deletes objects based on a list. |
| [options](object/options.md) | Checks whether a CORS request to an object can be made. |

### Multipart Upload service

| Method | Description |
| ----- | ----- |
| [startUpload](multipart/startupload.md) | Starts multipart upload. |
| [uploadPart](multipart/uploadpart.md) | Uploads a part of an object. |
| [copyPart](multipart/copypart.md) | Copies part of an object. |
| [listParts](multipart/listparts.md) | Displays a list of uploaded parts. |
| [abortUpload](multipart/abortupload.md) | Aborts multipart upload. |
| [completeUpload](multipart/completeupload.md) | Completes multipart upload. |
| [listUploads](multipart/listuploads.md) | Returns a list of incomplete uploads. |

### Static Website Hosting service

| Method | Description |
| ----- | ----- |
| [upload](hosting/upload.md) | Uploads a bucket's configuration for static website hosting to Object Storage. |
| [get](hosting/get.md) | Returns a bucket's configuration for static website hosting from Object Storage. |
| [delete](hosting/delete.md) | Deletes a bucket's configuration for static website hosting. |

### CORS service

| Method | Description |
| ----- | ----- |
| [upload](cors/upload.md) | Uploads a CORS configuration for a bucket. |
| [get](cors/get.md) | Returns a CORS configuration for a bucket. |
| [delete](cors/delete.md) | Deletes a CORS configuration for a bucket. |

### Lifecycles service

| Method | Description |
| ----- | ----- |
| [upload](lifecycles/upload.md) | Uploads an object lifecycle configuration to Object Storage. |
| [get](lifecycles/get.md) | Returns an object lifecycle configuration from Object Storage. |
| [delete](lifecycles/delete.md) | Deletes an object lifecycle configuration from Object Storage. |

### ACL service

| Method | Description |
| ----- | ----- |
| [objectGetAcl](acl/objectget.md) | Returns the access control list for an object. |
| [objectPutAcl](acl/objectput.md) | Uploads an access control list for an object. |
| [bucketGetAcl](acl/bucketget.md) | Returns the access control list for a bucket. |
| [bucketPutAcl](acl/bucketput.md) | Uploads an access control list for a bucket. |

## See also

- [#T](../../s3/index.md)
- [#T](../../instruments/index.md)

