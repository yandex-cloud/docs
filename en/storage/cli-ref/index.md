---
editable: false
sourcePath: en/_cli-ref/cli-ref/storage/cli-ref/index.md
---

# yc storage

Manage Yandex Object Storage resources

#### Command Usage

Syntax: 

`yc storage <group>`

#### Command Tree

- [yc storage bucket](bucket/index.md) — Manage buckets
	- [yc storage bucket create](bucket/create.md) — Create new bucket
	- [yc storage bucket delete](bucket/delete.md) — Delete the specified bucket
	- [yc storage bucket delete-https](bucket/delete-https.md) — Deletes bucket https settings
	- [yc storage bucket get](bucket/get.md) — Show information about the specified bucket
	- [yc storage bucket get-https](bucket/get-https.md) — Shows bucket https settings
	- [yc storage bucket list](bucket/list.md) — Lists buckets of specified folder id
	- [yc storage bucket set-https](bucket/set-https.md) — Sets bucket https settings
	- [yc storage bucket stats](bucket/stats.md) — Shows bucket stats
	- [yc storage bucket update](bucket/update.md) — Update the specified bucket
- [yc storage s3](s3/index.md) — [PREVIEW] An aws s3-like interface
	- [yc storage s3 cp](s3/cp.md) — Copies a local file or S3 object to another location locally or in S3
	- [yc storage s3 mv](s3/mv.md) — Moves a local file or S3 object to another location locally or in S3
	- [yc storage s3 presign](s3/presign.md) — Generate pre-signed URLs for S3 objects
	- [yc storage s3 rm](s3/rm.md) — Deletes an S3 object
- [yc storage s3api](s3api/index.md) — [PREVIEW] An aws s3api-like interface for accessing Object Storage
	- [yc storage s3api abort-multipart-upload](s3api/abort-multipart-upload.md) — Aborts a multipart upload
	- [yc storage s3api complete-multipart-upload](s3api/complete-multipart-upload.md) — Completes a multipart upload
	- [yc storage s3api copy-object](s3api/copy-object.md) — Creates a copy of an object that is already stored in Object Storage
	- [yc storage s3api create-multipart-upload](s3api/create-multipart-upload.md) — Creates a new multipart upload
	- [yc storage s3api delete-object](s3api/delete-object.md) — Deletes an object from Object Storage
	- [yc storage s3api delete-object-tagging](s3api/delete-object-tagging.md) — Deletes all objects labels from a bucket
	- [yc storage s3api delete-objects](s3api/delete-objects.md) — Deletes objects based on a list of keys passed in a request
	- [yc storage s3api get-bucket-acl](s3api/get-bucket-acl.md) — Returns bucket access control list
	- [yc storage s3api get-object](s3api/get-object.md) — Returns an object from Object Storage
	- [yc storage s3api get-object-acl](s3api/get-object-acl.md) — Returns bucket object access control list
	- [yc storage s3api get-object-legal-hold](s3api/get-object-legal-hold.md) — Returns the settings of the legal hold placed on the object version
	- [yc storage s3api get-object-retention](s3api/get-object-retention.md) — Returns settings of the retention put on an object version
	- [yc storage s3api get-object-tagging](s3api/get-object-tagging.md) — Returns bucket object labels
	- [yc storage s3api head-object](s3api/head-object.md) — Returns object metadata from Object Storage
	- [yc storage s3api list-multipart-uploads](s3api/list-multipart-uploads.md) — Lists in-progress multipart uploads
	- [yc storage s3api list-objects](s3api/list-objects.md) — Lists objects in a bucket using listObjectsV2 http method
	- [yc storage s3api list-parts](s3api/list-parts.md) — Lists parts of a multipart upload
	- [yc storage s3api put-bucket-acl](s3api/put-bucket-acl.md) — Sets bucket access control list
	- [yc storage s3api put-object](s3api/put-object.md) — Puts an object and its metadata to Object Storage
	- [yc storage s3api put-object-acl](s3api/put-object-acl.md) — Sets bucket object access control list
	- [yc storage s3api put-object-legal-hold](s3api/put-object-legal-hold.md) — Puts or removes legal hold for an object version
	- [yc storage s3api put-object-retention](s3api/put-object-retention.md) — Puts retention on the object version or enables/disables a previously set lock
	- [yc storage s3api put-object-tagging](s3api/put-object-tagging.md) — Adds labels to a bucket object. This overwrites any existing object labels
	- [yc storage s3api upload-part](s3api/upload-part.md) — Uploads a part in a multipart upload
	- [yc storage s3api upload-part-copy](s3api/upload-part-copy.md) — Uploads a part by copying data from an existing object as data source

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
