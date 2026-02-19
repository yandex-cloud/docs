---
editable: false
noIndex: true
---

# yc beta storage

Manage Object Storage resources

#### Command Usage

Syntax:

`yc beta storage <group>`

#### Command Tree

- [yc beta storage bucket](bucket/index.md) — A set of methods for managing buckets.

  - [yc beta storage bucket create](bucket/create.md) — Creates a bucket in the specified folder.

  - [yc beta storage bucket create-inventory-configuration](bucket/create-inventory-configuration.md) — Create/Update an inventory configuration with the corresponding ID

  - [yc beta storage bucket delete](bucket/delete.md) — Deletes the specified bucket.

  - [yc beta storage bucket delete-https-config](bucket/delete-https-config.md) — Deletes the HTTPS configuration for the specified bucket.

  - [yc beta storage bucket delete-inventory-configuration](bucket/delete-inventory-configuration.md) — Delete an inventory configuration with the corresponding ID

  - [yc beta storage bucket get](bucket/get.md) — Returns the specified bucket.

  - [yc beta storage bucket get-https-config](bucket/get-https-config.md) — Returns the HTTPS configuration for the specified bucket.

  - [yc beta storage bucket get-inventory-configuration](bucket/get-inventory-configuration.md) — Get an inventory configuration with the corresponding ID

  - [yc beta storage bucket get-stats](bucket/get-stats.md) — Returns the statistics for the specified bucket.

  - [yc beta storage bucket list](bucket/list.md) — Retrieves the list of buckets in the specified folder.

  - [yc beta storage bucket list-access-bindings](bucket/list-access-bindings.md) — Lists access bindings for the specified bucket.

  - [yc beta storage bucket list-inventory-configurations](bucket/list-inventory-configurations.md) — Listing inventory configurations

  - [yc beta storage bucket set-access-bindings](bucket/set-access-bindings.md) — Sets access bindings for the specified bucket.

  - [yc beta storage bucket set-https-config](bucket/set-https-config.md) — Updates the HTTPS configuration for the specified bucket.

  - [yc beta storage bucket update](bucket/update.md) — Updates the specified bucket.

  - [yc beta storage bucket update-access-bindings](bucket/update-access-bindings.md) — Updates access bindings for the specified bucket.

- [yc beta storage presign](presign/index.md) — PresignService provides URL presigning functionality

  - [yc beta storage presign create](presign/create.md) — Create generates presigned URLs for the specified objects

- [yc beta storage s3](s3/index.md) — [PREVIEW] An aws s3-like interface

  - [yc beta storage s3 cp](s3/cp.md) — Copies a local file or S3 object to another location locally or in S3

  - [yc beta storage s3 mv](s3/mv.md) — Moves a local file or S3 object to another location locally or in S3

  - [yc beta storage s3 presign](s3/presign.md) — Generate pre-signed URLs for S3 objects

  - [yc beta storage s3 rm](s3/rm.md) — Deletes an S3 object

- [yc beta storage s3api](s3api/index.md) — [PREVIEW] An aws s3api-like interface for accessing Object Storage

  - [yc beta storage s3api abort-multipart-upload](s3api/abort-multipart-upload.md) — Aborts a multipart upload

  - [yc beta storage s3api complete-multipart-upload](s3api/complete-multipart-upload.md) — Completes a multipart upload

  - [yc beta storage s3api copy-object](s3api/copy-object.md) — Creates a copy of an object that is already stored in Object Storage

  - [yc beta storage s3api create-multipart-upload](s3api/create-multipart-upload.md) — Creates a new multipart upload

  - [yc beta storage s3api delete-object](s3api/delete-object.md) — Deletes an object from Object Storage

  - [yc beta storage s3api delete-object-tagging](s3api/delete-object-tagging.md) — Deletes all objects labels from a bucket

  - [yc beta storage s3api delete-objects](s3api/delete-objects.md) — Deletes objects based on a list of keys passed in a request

  - [yc beta storage s3api get-bucket-acl](s3api/get-bucket-acl.md) — Returns bucket access control list

  - [yc beta storage s3api get-object](s3api/get-object.md) — Returns an object from Object Storage

  - [yc beta storage s3api get-object-acl](s3api/get-object-acl.md) — Returns bucket object access control list

  - [yc beta storage s3api get-object-legal-hold](s3api/get-object-legal-hold.md) — Returns the settings of the legal hold placed on the object version

  - [yc beta storage s3api get-object-retention](s3api/get-object-retention.md) — Returns settings of the retention put on an object version

  - [yc beta storage s3api get-object-tagging](s3api/get-object-tagging.md) — Returns bucket object labels

  - [yc beta storage s3api head-object](s3api/head-object.md) — Returns object metadata from Object Storage

  - [yc beta storage s3api list-multipart-uploads](s3api/list-multipart-uploads.md) — Lists in-progress multipart uploads

  - [yc beta storage s3api list-objects](s3api/list-objects.md) — Lists objects in a bucket using listObjectsV2 http method

  - [yc beta storage s3api list-parts](s3api/list-parts.md) — Lists parts of a multipart upload

  - [yc beta storage s3api put-bucket-acl](s3api/put-bucket-acl.md) — Sets bucket access control list

  - [yc beta storage s3api put-object](s3api/put-object.md) — Puts an object and its metadata to Object Storage

  - [yc beta storage s3api put-object-acl](s3api/put-object-acl.md) — Sets bucket object access control list

  - [yc beta storage s3api put-object-legal-hold](s3api/put-object-legal-hold.md) — Puts or removes legal hold for an object version

  - [yc beta storage s3api put-object-retention](s3api/put-object-retention.md) — Puts retention on the object version or enables/disables a previously set lock

  - [yc beta storage s3api put-object-tagging](s3api/put-object-tagging.md) — Adds labels to a bucket object. This overwrites any existing object labels

  - [yc beta storage s3api upload-part](s3api/upload-part.md) — Uploads a part in a multipart upload

  - [yc beta storage s3api upload-part-copy](s3api/upload-part-copy.md) — Uploads a part by copying data from an existing object as data source

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#