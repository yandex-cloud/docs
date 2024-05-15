# {{ objstorage-name }} log reference


This section describes the log fields delivered by the bucket.

{{ objstorage-name }} logs are stored in JSON format. A single log entry represents one request to a bucket.


For more information, see [{#T}](concepts/server-logs.md).


## Log fields {#log-fields}

| Field | Type | Description |
--- | --- | ---
| `bucket` | String | Bucket name. |
| `bytes_received` | Int64 | Size of the request in bytes. |
| `bytes_send` | Int64 | Response size in bytes. |
| `handler` | String | [Request method](#bucket-methods) in `REST.<HTTP method>.<subject>` format. |
| `http_referer` | String | URL of the request source. |
| `ip` | String | User IP address. |
| `method` | String | HTTP request method. |
| `object_key` | String | [Object key](concepts/object.md#key) in [URL-encoded](https://en.wikipedia.org/wiki/Percent-encoding) format. |
| `protocol` | String | Data transfer protocol version. |
| `range` | String | HTTP header that defines the range of bytes to load from the object. |
| `requester` | String | User ID. |
| `request_args` | String | Arguments of the URL request. |
| `request_id` | String | Query ID. |
| `request_path` | String | Full path of the request. |
| `request_time` | Int64 | Request processing time in milliseconds. |
| `scheme` | String | Type of data transfer protocol. <br>Possible values:<br>- `http`: Application layer protocol.<br>- `https`: Application layer protocol with encryption support. |
| `ssl_protocol` | String | Security protocol. |
| `status` | Int64 | HTTP [response](s3/api-ref/response-codes.md) code. |
| `storage_class` | String | [Storage class](concepts/storage-class.md) of the object. |
| `timestamp` | String | Date and time of the operation with the bucket in the `YYYY-MM-DDTHH:MM:MMZ` format. |
| `user_agent` | String | Client application (user agent) that executed the request. |
| `version_id` | String | Object version. |
| `vhost` | String | Virtual host of the request.<br>Possible values:<br>– `{{ s3-storage-host }}`.<br>– `<bucket_name>.{{ s3-storage-host }}`.<br>– `{{ s3-web-host }}`.<br> – `<bucket_name>.{{ s3-web-host }}`. |

## Bucket request methods {#bucket-methods}

| HTTP method | Subject | Description |
|---|---|---|
| `GET` | `SERVICE` | Listing available buckets. |
| `GET` | `LOCATION` | Outputting the region where a bucket resides. |
| `PUT` | `BUCKET` | Creating a bucket. |
| `HEAD` | `BUCKET` | Outputting bucket metadata. |
| `GET` | `BUCKET` | Listing bucket objects (previous method version). |
| `GET` | `BUCKET_V1EXT` | Listing bucket objects (previous extended method version). |
| `GET` | `BUCKET_V2` | Listing bucket objects (current method version). |
| `DELETE` | `BUCKET` | Deleting a bucket. |
| `OPTIONS` | `BUCKET` | Checking whether a [CORS](concepts/cors.md) request to a bucket can be made. |
| `GET` | `BUCKETVERSIONS` | Outputting [metadata](concepts/object.md#metadata) for all versions of bucket objects. |
| `GET` | `VERSIONING` | Outputting the bucket [versioning](concepts/versioning.md) status. |
| `PUT` | `VERSIONING` | Enabling or pausing bucket versioning. |
| `PUT` | `BUCKET_ACL` | Uploading the [access control list](concepts/acl.md) for a bucket. |
| `GET` | `BUCKET_ACL` | Outputting the access control list for a bucket. |
| `PUT` | `BUCKET_CORS` | Uploading a CORS configuration for a bucket. |
| `GET` | `BUCKET_CORS` | Outputting a CORS configuration for a bucket. |
| `DELETE` | `BUCKET_CORS` | Deleting a CORS configuration for a bucket. |
| `PUT` | `BUCKET_LIFECYCLE` | Uploading a bucket object [lifecycle](concepts/lifecycles.md) configuration. |
| `GET` | `BUCKET_LIFECYCLE` | Outputting a bucket object lifecycle configuration. |
| `DELETE` | `BUCKET_LIFECYCLE` | Deleting a bucket object lifecycle configuration. |
| `PUT` | `BUCKET_ENCRYPTION` | Enabling bucket [encryption](concepts/encryption.md). |
| `GET` | `BUCKET_ENCRYPTION` | Outputting information about bucket encryption. |
| `DELETE` | `BUCKET_ENCRYPTION` | Disabling bucket encryption. |
| `PUT` | `BUCKET_WEBSITES` | Uploading a [static website hosting](concepts/hosting.md) configuration for a bucket. |
| `GET` | `BUCKET_WEBSITES` | Outputting a static website hosting configuration for a bucket. |
| `DELETE` | `BUCKET_WEBSITES` | Deleting a static website hosting configuration for a bucket. |
| `GET` | `BUCKET_LOGGING` | Outputting settings for bucket actions logging. |
| `PUT` | `BUCKET_LOGGING` | [Enabling](operations/buckets/enable-logging.md#enable) and [disabling](operations/buckets/enable-logging.md#stop-logging) bucket actions logging. |
| `PUT` | `BUCKETPOLICY` | Applying [bucket policies](concepts/policy.md) to the specified bucket. |
| `GET` | `BUCKETPOLICY` | Outputting bucket policies for the specified bucket. |
| `DELETE` | `BUCKETPOLICY` | Deleting bucket policies for the specified bucket. |
| `PUT` | `BUCKET_TAGGING` | Setting [tags](concepts/tags.md) for a bucket. |
| `GET` | `BUCKET_TAGGING` | Outputting bucket tags. |
| `DELETE` | `BUCKET_TAGGING` | Deleting bucket tags. |
| `PUT` | `OBJECT` | Uploading an object and its metadata to a bucket. |
| `POST` | `OBJECT` | Uploading an object and its metadata to a bucket via an HTML form. |
| `POST` | `OBJECT_RESTORE` | Restoring a bucket object from an archive. {{ objstorage-name }} is not supported. |
| `PUT` | `OBJECT_COPY` | Creating a bucket object copy. |
| `DELETE` | `OBJECT` | Deleting an object. |
| `DELETE` | `MULTIPLE_OBJECTS` | Deleting objects based on a list of keys provided in a request. |
| `HEAD` | `OBJECT` | Outputting object metadata. |
| `GET` | `OBJECT` | Getting an object from a bucket. |
| `OPTIONS` | `OBJECT` | Checking whether a CORS request to an object can be made. |
| `GET` | `OBJECT_ACL` | Outputting the access control list for an object. |
| `PUT` | `OBJECT_ACL` | Uploading the access control list for an object. |
| `SELECT` | `OBJECT_CONTENT` | Filtering and outputting the contents of an object based on an [S3 Select query](concepts/s3-select-language.md). |
| `PUT` | `OBJECT_TAGGING` | Setting tags for an object. |
| `GET` | `OBJECT_TAGGING` | Outputting object tags. |
| `DELETE` | `OBJECT_TAGGING` | Deleting object tags. |
| `GET` | `MULTIPART` | Listing current [multipart uploads](concepts/multipart.md). |
| `POST` | `INIT_MULTIPART` | Outputting the ID to be used for further operations with an object multipart upload. |
| `POST` | `COMPLETE_MULTIPART` | Completing an object multipart upload. |
| `DELETE` | `ABORT_MULTIPART` | Aborting a multipart upload and deleting from a bucket all object parts that have already been saved. |
| `PUT` | `UPLOAD_PART` | Saving an object part. |
| `PUT` | `UPLOAD_PART_COPY` | Copying an object part. |
| `GET` | `UPLOAD_PART` | Listing uploaded object parts for the specified multipart upload. |
