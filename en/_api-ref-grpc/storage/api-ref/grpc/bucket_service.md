---
editable: false
---

# BucketService

A set of methods for managing buckets.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of buckets in the specified folder. |
| [Get](#Get) | Returns the specified bucket. |
| [Create](#Create) | Creates a bucket in the specified folder. |
| [Update](#Update) | Updates the specified bucket. |
| [Delete](#Delete) | Deletes the specified bucket. |
| [GetStats](#GetStats) | Returns the statistics for the specified bucket. |
| [GetHTTPSConfig](#GetHTTPSConfig) | Returns the HTTPS configuration for the specified bucket. |
| [SetHTTPSConfig](#SetHTTPSConfig) | Updates the HTTPS configuration for the specified bucket. |
| [DeleteHTTPSConfig](#DeleteHTTPSConfig) | Deletes the HTTPS configuration for the specified bucket. |

## Calls BucketService {#calls}

## List {#List}

Retrieves the list of buckets in the specified folder. <br>The following fields will not be returned for buckets in the list: [Bucket.policy](#Bucket), [Bucket.acl](#Bucket), [Bucket.cors](#Bucket), [Bucket.website_settings](#Bucket), [Bucket.lifecycle_rules](#Bucket).

**rpc List ([ListBucketsRequest](#ListBucketsRequest)) returns ([ListBucketsResponse](#ListBucketsResponse))**

### ListBucketsRequest {#ListBucketsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list buckets in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.


### ListBucketsResponse {#ListBucketsResponse}

Field | Description
--- | ---
buckets[] | **[Bucket](#Bucket)**<br>List of buckets in the specified folder. 


### Bucket {#Bucket}

Field | Description
--- | ---
id | **string**<br>ID of the bucket. Always equal to `name`, which has priority. 
name | **string**<br>Name of the bucket. <br>The name is unique within the platform. For naming limitations and rules, see [documentation](/docs/storage/concepts/bucket#naming). 
folder_id | **string**<br>ID of the folder that the bucket belongs to. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
default_storage_class | **string**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
versioning | enum **Versioning**<br>Bucket versioning status. For details, see [documentation](/docs/storage/concepts/versioning). <ul><li>`VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of `null`. <br>To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request. Note that this action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.</li><li>`VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests. <br>To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](#Update) request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</li><li>`VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs. <br>To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request.</li></ul>
max_size | **int64**<br>Maximum size of the bucket, in bytes. For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). 
policy | **google.protobuf.Struct**<br>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see [documentation](/docs/storage/concepts/policy). 
acl | **[ACL](#ACL)**<br>Access control list (ACL) of the bucket. For details, see [documentation](/docs/storage/concepts/acl). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
cors[] | **[CorsRule](#CorsRule)**<br>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see [documentation](/docs/storage/concepts/cors). 
website_settings | **[WebsiteSettings](#WebsiteSettings)**<br>Configuration for hosting a static website in the bucket. For details, see [documentation](/docs/storage/concepts/hosting). 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule)**<br>List of object lifecycle rules for the bucket. For details, see [documentation](/docs/storage/concepts/lifecycles). 


### AnonymousAccessFlags {#AnonymousAccessFlags}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


### ACL {#ACL}

Field | Description
--- | ---
grants[] | **[Grant](#Grant)**<br>List of permissions granted and the grantees. 


### Grant {#Grant}

Field | Description
--- | ---
permission | enum **Permission**<br>Required. Permission granted by the grant. <ul><li>`PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP` on the bucket. <br>Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects. <br>Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket. <br>Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ`: Allows grantee to list the objects in the bucket. <br>Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL <br>Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li></ul>
grant_type | enum **GrantType**<br>Required. The grantee type for the grant. <ul><li>`GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts). <br>For this grantee type, you need to specify the user ID in [Bucket.acl.grants.grantee_id](#Bucket1) field. To get user ID, see [instruction](/docs/iam/operations/users/get). <br>Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li></ul>
grantee_id | **string**<br>ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. 


### CorsRule {#CorsRule}

Field | Description
--- | ---
id | **string**<br>ID of the CORS rule. 
allowed_methods[] | enum **Method**<br>List of HTTP methods allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Method` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the `Access-Control-Allow-Methods` header of the response. The number of elements must be greater than 0.<ul><li>`METHOD_GET`: HTTP `GET` method.</li><li>`METHOD_HEAD`: HTTP `HEAD` method.</li><li>`METHOD_POST`: HTTP `POST` method.</li><li>`METHOD_PUT`: HTTP `PUT` method.</li><li>`METHOD_DELETE`: HTTP `DELETE` method.</li></ul>
allowed_headers[] | **string**<br>List of HTTP headers allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Headers` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the `Access-Control-Allow-Headers` header of the response. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `x-amz-*` value will allow all Amazon S3-compatible headers. 
allowed_origins[] | **string**<br>List of request origins allowed by the CORS rule. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `http://*.example.com` value will allow requests originating from all subdomains of `example.com`. The number of elements must be greater than 0.
expose_headers[] | **string**<br>List of headers contained in responses to CORS requests that can be accessed by applications. 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin. 


### WebsiteSettings {#WebsiteSettings}

Field | Description
--- | ---
index | **string**<br>Key of the index page object that is returned when a response is made to the root of the website. <br>Either `index` or `redirect_all_requests` must be specified in order for the bucket to host a static website. <br>If specified, the index page object must be located in the root of the bucket. 
error | **string**<br>Key of the error page object that is returned when an error occurs. 
redirect_all_requests | **[Scheme](#Scheme)**<br>Configuration for redirecting all requests sent to the website. <br>Either `redirect_all_requests` or `index` must be specified in order for the bucket to host a static website. If `redirect_all_requests` is specified, it must be the only field in [Bucket.website_settings](#Bucket1). 
routing_rules[] | **[RoutingRule](#RoutingRule)**<br>List of redirect rules. 


### Scheme {#Scheme}

Field | Description
--- | ---
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
hostname | **string**<br>Hostname of the redirect URI. 


### Condition {#Condition}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br>HTTP status code (number only) that must match for the redirect to apply. 
key_prefix_equals | **string**<br>Prefix of the object key from which requests are redirected. 


### Redirect {#Redirect}

Field | Description
--- | ---
hostname | **string**<br>Hostname of the redirect URI. 
http_redirect_code | **string**<br>HTTP status code of the redirect response. <br>Default value: `"301"`. Value must match the regular expression ` 3(0[1-9]\|[1-9][0-9]) `.
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
replace_key_prefix_with | **string**<br>Substitution for the prefix of the object key specified in [Condition.key_prefix_equals](#Condition). <br>At most one of `replace_key_prefix_with` and `replace_key_with` can be specified. 
replace_key_with | **string**<br>New object key. <br>At most one of `replace_key_with` and `replace_key_prefix_with` can be specified. 


### RoutingRule {#RoutingRule}

Field | Description
--- | ---
condition | **[Condition](#Condition)**<br>Redirect condition. 
redirect | **[Redirect](#Redirect)**<br>Redirect instructions. 


### LifecycleRule {#LifecycleRule}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br>ID of the rule. Provided by the client or generated at creation time. 
enabled | **bool**<br>Indicates whether the rule is in effect. 
filter | **[RuleFilter](#RuleFilter)**<br>Filter that identifies the objects to which the rule applies. <br>If not specified, the rule applies to all objects in the bucket. 
expiration | **[Expiration](#Expiration)**<br>Expiration rule. <br>The expiration of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket1) is `VERSIONING_DISABLED`), the object is deleted and cannot be recovered. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket1) is `VERSIONING_ENABLED`), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object. <br>For the bucket with versioning suspended ([Bucket.versioning](#Bucket1) is `VERSIONING_SUSPENDED`), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object. 
transitions[] | **[Transition](#Transition)**<br>List of transition rules. <br>The transition of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket1) is `VERSIONING_DISABLED`), the object is transitioned to the specified storage class. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket1) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays)**<br>Configuration for aborting incomplete [multipart uploads](/docs/storage/concepts/multipart). 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration)**<br>Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket1) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At expiration, the non-current version of the object is deleted and cannot be recovered. 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition)**<br>List of transition rules for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket1) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At transition, the non-current version of the object is transitioned to the specified storage class. 


### AfterDays {#AfterDays}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted. 


### NoncurrentExpiration {#NoncurrentExpiration}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version expires. 


### NoncurrentTransition {#NoncurrentTransition}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned. 
storage_class | **string**<br>Required. Storage class to which a non-current version of an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Transition {#Transition}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object transition. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately. <br>At most one of `date` and `days` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object is transitioned. <br>At most one of `days` and `date` fields can be specified. 
storage_class | **string**<br>Required. Storage class to which an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Expiration {#Expiration}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object expiration. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately. <br>Exactly one of `date`, `days`, and `expired_object_delete_marker` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object expires. <br>Exactly one of `days`, `date`, and `expired_object_delete_marker` fields can be specified. 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration. <br>Exactly one of `expired_object_delete_marker`, `date`, and `days` fields can be specified. 


### RuleFilter {#RuleFilter}

Field | Description
--- | ---
prefix | **string**<br>Key prefix that the object must have in order for the rule to apply. 


## Get {#Get}

Returns the specified bucket. <br>To get the list of all available buckets, make a [List](#List) request.

**rpc Get ([GetBucketRequest](#GetBucketRequest)) returns ([Bucket](#Bucket1))**

### GetBucketRequest {#GetBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to return. <br>To get the bucket name, make a [BucketService.List](#List) request. 
view | enum **View**<br>Scope of information about the bucket to return. <br>Access to scopes is managed via [Identity and Access Management roles](/docs/storage/security), bucket [ACL](/docs/storage/concepts/acl) and [policies](/docs/storage/concepts/policy). <ul><li>`VIEW_BASIC`: Returns basic information about a bucket. <br>The following fields will _not_ be returned: [Bucket.acl](#Bucket1), [Bucket.cors](#Bucket1), [Bucket.website_settings](#Bucket1), [Bucket.lifecycle_rules](#Bucket1).</li><li>`VIEW_ACL`: Returns basic information and access control list (ACL) for the bucket. <br>The following fields will _not_ be returned: [Bucket.cors](#Bucket1), [Bucket.website_settings](#Bucket1), [Bucket.lifecycle_rules](#Bucket1).</li><li>`VIEW_FULL`: Returns full information about a bucket.</li></ul>


### Bucket {#Bucket1}

Field | Description
--- | ---
id | **string**<br>ID of the bucket. Always equal to `name`, which has priority. 
name | **string**<br>Name of the bucket. <br>The name is unique within the platform. For naming limitations and rules, see [documentation](/docs/storage/concepts/bucket#naming). 
folder_id | **string**<br>ID of the folder that the bucket belongs to. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags1)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
default_storage_class | **string**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
versioning | enum **Versioning**<br>Bucket versioning status. For details, see [documentation](/docs/storage/concepts/versioning). <ul><li>`VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of `null`. <br>To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request. Note that this action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.</li><li>`VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests. <br>To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](#Update) request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</li><li>`VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs. <br>To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request.</li></ul>
max_size | **int64**<br>Maximum size of the bucket, in bytes. For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). 
policy | **google.protobuf.Struct**<br>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see [documentation](/docs/storage/concepts/policy). 
acl | **[ACL](#ACL1)**<br>Access control list (ACL) of the bucket. For details, see [documentation](/docs/storage/concepts/acl). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
cors[] | **[CorsRule](#CorsRule1)**<br>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see [documentation](/docs/storage/concepts/cors). 
website_settings | **[WebsiteSettings](#WebsiteSettings1)**<br>Configuration for hosting a static website in the bucket. For details, see [documentation](/docs/storage/concepts/hosting). 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule1)**<br>List of object lifecycle rules for the bucket. For details, see [documentation](/docs/storage/concepts/lifecycles). 


### AnonymousAccessFlags {#AnonymousAccessFlags1}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


### ACL {#ACL1}

Field | Description
--- | ---
grants[] | **[Grant](#Grant1)**<br>List of permissions granted and the grantees. 


### Grant {#Grant1}

Field | Description
--- | ---
permission | enum **Permission**<br>Required. Permission granted by the grant. <ul><li>`PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP` on the bucket. <br>Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects. <br>Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket. <br>Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ`: Allows grantee to list the objects in the bucket. <br>Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL <br>Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li></ul>
grant_type | enum **GrantType**<br>Required. The grantee type for the grant. <ul><li>`GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts). <br>For this grantee type, you need to specify the user ID in [Bucket.acl.grants.grantee_id](#Bucket2) field. To get user ID, see [instruction](/docs/iam/operations/users/get). <br>Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li></ul>
grantee_id | **string**<br>ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. 


### CorsRule {#CorsRule1}

Field | Description
--- | ---
id | **string**<br>ID of the CORS rule. 
allowed_methods[] | enum **Method**<br>List of HTTP methods allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Method` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the `Access-Control-Allow-Methods` header of the response. The number of elements must be greater than 0.<ul><li>`METHOD_GET`: HTTP `GET` method.</li><li>`METHOD_HEAD`: HTTP `HEAD` method.</li><li>`METHOD_POST`: HTTP `POST` method.</li><li>`METHOD_PUT`: HTTP `PUT` method.</li><li>`METHOD_DELETE`: HTTP `DELETE` method.</li></ul>
allowed_headers[] | **string**<br>List of HTTP headers allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Headers` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the `Access-Control-Allow-Headers` header of the response. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `x-amz-*` value will allow all Amazon S3-compatible headers. 
allowed_origins[] | **string**<br>List of request origins allowed by the CORS rule. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `http://*.example.com` value will allow requests originating from all subdomains of `example.com`. The number of elements must be greater than 0.
expose_headers[] | **string**<br>List of headers contained in responses to CORS requests that can be accessed by applications. 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin. 


### WebsiteSettings {#WebsiteSettings1}

Field | Description
--- | ---
index | **string**<br>Key of the index page object that is returned when a response is made to the root of the website. <br>Either `index` or `redirect_all_requests` must be specified in order for the bucket to host a static website. <br>If specified, the index page object must be located in the root of the bucket. 
error | **string**<br>Key of the error page object that is returned when an error occurs. 
redirect_all_requests | **[Scheme](#Scheme1)**<br>Configuration for redirecting all requests sent to the website. <br>Either `redirect_all_requests` or `index` must be specified in order for the bucket to host a static website. If `redirect_all_requests` is specified, it must be the only field in [Bucket.website_settings](#Bucket2). 
routing_rules[] | **[RoutingRule](#RoutingRule1)**<br>List of redirect rules. 


### Scheme {#Scheme1}

Field | Description
--- | ---
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
hostname | **string**<br>Hostname of the redirect URI. 


### Condition {#Condition1}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br>HTTP status code (number only) that must match for the redirect to apply. 
key_prefix_equals | **string**<br>Prefix of the object key from which requests are redirected. 


### Redirect {#Redirect1}

Field | Description
--- | ---
hostname | **string**<br>Hostname of the redirect URI. 
http_redirect_code | **string**<br>HTTP status code of the redirect response. <br>Default value: `"301"`. Value must match the regular expression ` 3(0[1-9]\|[1-9][0-9]) `.
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
replace_key_prefix_with | **string**<br>Substitution for the prefix of the object key specified in [Condition.key_prefix_equals](#Condition1). <br>At most one of `replace_key_prefix_with` and `replace_key_with` can be specified. 
replace_key_with | **string**<br>New object key. <br>At most one of `replace_key_with` and `replace_key_prefix_with` can be specified. 


### RoutingRule {#RoutingRule1}

Field | Description
--- | ---
condition | **[Condition](#Condition1)**<br>Redirect condition. 
redirect | **[Redirect](#Redirect1)**<br>Redirect instructions. 


### LifecycleRule {#LifecycleRule1}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br>ID of the rule. Provided by the client or generated at creation time. 
enabled | **bool**<br>Indicates whether the rule is in effect. 
filter | **[RuleFilter](#RuleFilter1)**<br>Filter that identifies the objects to which the rule applies. <br>If not specified, the rule applies to all objects in the bucket. 
expiration | **[Expiration](#Expiration1)**<br>Expiration rule. <br>The expiration of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket2) is `VERSIONING_DISABLED`), the object is deleted and cannot be recovered. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket2) is `VERSIONING_ENABLED`), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object. <br>For the bucket with versioning suspended ([Bucket.versioning](#Bucket2) is `VERSIONING_SUSPENDED`), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object. 
transitions[] | **[Transition](#Transition1)**<br>List of transition rules. <br>The transition of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket2) is `VERSIONING_DISABLED`), the object is transitioned to the specified storage class. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket2) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays1)**<br>Configuration for aborting incomplete [multipart uploads](/docs/storage/concepts/multipart). 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration1)**<br>Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket2) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At expiration, the non-current version of the object is deleted and cannot be recovered. 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition1)**<br>List of transition rules for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket2) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At transition, the non-current version of the object is transitioned to the specified storage class. 


### AfterDays {#AfterDays1}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted. 


### NoncurrentExpiration {#NoncurrentExpiration1}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version expires. 


### NoncurrentTransition {#NoncurrentTransition1}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned. 
storage_class | **string**<br>Required. Storage class to which a non-current version of an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Transition {#Transition1}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object transition. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately. <br>At most one of `date` and `days` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object is transitioned. <br>At most one of `days` and `date` fields can be specified. 
storage_class | **string**<br>Required. Storage class to which an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Expiration {#Expiration1}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object expiration. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately. <br>Exactly one of `date`, `days`, and `expired_object_delete_marker` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object expires. <br>Exactly one of `days`, `date`, and `expired_object_delete_marker` fields can be specified. 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration. <br>Exactly one of `expired_object_delete_marker`, `date`, and `days` fields can be specified. 


### RuleFilter {#RuleFilter1}

Field | Description
--- | ---
prefix | **string**<br>Key prefix that the object must have in order for the rule to apply. 


## Create {#Create}

Creates a bucket in the specified folder.

**rpc Create ([CreateBucketRequest](#CreateBucketRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBucketMetadata](#CreateBucketMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Bucket](#Bucket2)<br>

### CreateBucketRequest {#CreateBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket. <br>The name must be unique within the platform. For naming limitations and rules, see [documentation](/docs/storage/concepts/bucket#naming). 
folder_id | **string**<br>Required. ID of the folder to create a bucket in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
default_storage_class | **string**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
max_size | **int64**<br>Maximum size of the bucket. For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags2)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
acl | **[ACL](#ACL2)**<br>Access control list (ACL) of the bucket. For details, see [documentation](/docs/storage/concepts/acl). 


### AnonymousAccessFlags {#AnonymousAccessFlags2}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


### ACL {#ACL2}

Field | Description
--- | ---
grants[] | **[Grant](#Grant2)**<br>List of permissions granted and the grantees. 


### Grant {#Grant2}

Field | Description
--- | ---
permission | enum **Permission**<br>Required. Permission granted by the grant. <ul><li>`PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP` on the bucket. <br>Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects. <br>Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket. <br>Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ`: Allows grantee to list the objects in the bucket. <br>Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL <br>Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li></ul>
grant_type | enum **GrantType**<br>Required. The grantee type for the grant. <ul><li>`GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts). <br>For this grantee type, you need to specify the user ID in [Bucket.acl.grants.grantee_id](#Bucket2) field. To get user ID, see [instruction](/docs/iam/operations/users/get). <br>Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li></ul>
grantee_id | **string**<br>ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateBucketMetadata](#CreateBucketMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Bucket](#Bucket2)>**<br>if operation finished successfully. 


### CreateBucketMetadata {#CreateBucketMetadata}

Field | Description
--- | ---
name | **string**<br>Name of the bucket that is being created. 


### Bucket {#Bucket2}

Field | Description
--- | ---
id | **string**<br>ID of the bucket. Always equal to `name`, which has priority. 
name | **string**<br>Name of the bucket. <br>The name is unique within the platform. For naming limitations and rules, see [documentation](/docs/storage/concepts/bucket#naming). 
folder_id | **string**<br>ID of the folder that the bucket belongs to. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags3)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
default_storage_class | **string**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
versioning | enum **Versioning**<br>Bucket versioning status. For details, see [documentation](/docs/storage/concepts/versioning). <ul><li>`VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of `null`. <br>To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request. Note that this action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.</li><li>`VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests. <br>To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](#Update) request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</li><li>`VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs. <br>To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request.</li></ul>
max_size | **int64**<br>Maximum size of the bucket, in bytes. For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). 
policy | **google.protobuf.Struct**<br>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see [documentation](/docs/storage/concepts/policy). 
acl | **[ACL](#ACL3)**<br>Access control list (ACL) of the bucket. For details, see [documentation](/docs/storage/concepts/acl). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
cors[] | **[CorsRule](#CorsRule2)**<br>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see [documentation](/docs/storage/concepts/cors). 
website_settings | **[WebsiteSettings](#WebsiteSettings2)**<br>Configuration for hosting a static website in the bucket. For details, see [documentation](/docs/storage/concepts/hosting). 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule2)**<br>List of object lifecycle rules for the bucket. For details, see [documentation](/docs/storage/concepts/lifecycles). 


### AnonymousAccessFlags {#AnonymousAccessFlags3}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


### ACL {#ACL3}

Field | Description
--- | ---
grants[] | **[Grant](#Grant3)**<br>List of permissions granted and the grantees. 


### Grant {#Grant3}

Field | Description
--- | ---
permission | enum **Permission**<br>Required. Permission granted by the grant. <ul><li>`PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP` on the bucket. <br>Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects. <br>Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket. <br>Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ`: Allows grantee to list the objects in the bucket. <br>Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL <br>Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li></ul>
grant_type | enum **GrantType**<br>Required. The grantee type for the grant. <ul><li>`GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts). <br>For this grantee type, you need to specify the user ID in [Bucket.acl.grants.grantee_id](#Bucket3) field. To get user ID, see [instruction](/docs/iam/operations/users/get). <br>Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li></ul>
grantee_id | **string**<br>ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. 


### CorsRule {#CorsRule2}

Field | Description
--- | ---
id | **string**<br>ID of the CORS rule. 
allowed_methods[] | enum **Method**<br>List of HTTP methods allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Method` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the `Access-Control-Allow-Methods` header of the response. The number of elements must be greater than 0.<ul><li>`METHOD_GET`: HTTP `GET` method.</li><li>`METHOD_HEAD`: HTTP `HEAD` method.</li><li>`METHOD_POST`: HTTP `POST` method.</li><li>`METHOD_PUT`: HTTP `PUT` method.</li><li>`METHOD_DELETE`: HTTP `DELETE` method.</li></ul>
allowed_headers[] | **string**<br>List of HTTP headers allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Headers` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the `Access-Control-Allow-Headers` header of the response. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `x-amz-*` value will allow all Amazon S3-compatible headers. 
allowed_origins[] | **string**<br>List of request origins allowed by the CORS rule. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `http://*.example.com` value will allow requests originating from all subdomains of `example.com`. The number of elements must be greater than 0.
expose_headers[] | **string**<br>List of headers contained in responses to CORS requests that can be accessed by applications. 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin. 


### WebsiteSettings {#WebsiteSettings2}

Field | Description
--- | ---
index | **string**<br>Key of the index page object that is returned when a response is made to the root of the website. <br>Either `index` or `redirect_all_requests` must be specified in order for the bucket to host a static website. <br>If specified, the index page object must be located in the root of the bucket. 
error | **string**<br>Key of the error page object that is returned when an error occurs. 
redirect_all_requests | **[Scheme](#Scheme2)**<br>Configuration for redirecting all requests sent to the website. <br>Either `redirect_all_requests` or `index` must be specified in order for the bucket to host a static website. If `redirect_all_requests` is specified, it must be the only field in [Bucket.website_settings](#Bucket3). 
routing_rules[] | **[RoutingRule](#RoutingRule2)**<br>List of redirect rules. 


### Scheme {#Scheme2}

Field | Description
--- | ---
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
hostname | **string**<br>Hostname of the redirect URI. 


### Condition {#Condition2}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br>HTTP status code (number only) that must match for the redirect to apply. 
key_prefix_equals | **string**<br>Prefix of the object key from which requests are redirected. 


### Redirect {#Redirect2}

Field | Description
--- | ---
hostname | **string**<br>Hostname of the redirect URI. 
http_redirect_code | **string**<br>HTTP status code of the redirect response. <br>Default value: `"301"`. Value must match the regular expression ` 3(0[1-9]\|[1-9][0-9]) `.
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
replace_key_prefix_with | **string**<br>Substitution for the prefix of the object key specified in [Condition.key_prefix_equals](#Condition2). <br>At most one of `replace_key_prefix_with` and `replace_key_with` can be specified. 
replace_key_with | **string**<br>New object key. <br>At most one of `replace_key_with` and `replace_key_prefix_with` can be specified. 


### RoutingRule {#RoutingRule2}

Field | Description
--- | ---
condition | **[Condition](#Condition2)**<br>Redirect condition. 
redirect | **[Redirect](#Redirect2)**<br>Redirect instructions. 


### LifecycleRule {#LifecycleRule2}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br>ID of the rule. Provided by the client or generated at creation time. 
enabled | **bool**<br>Indicates whether the rule is in effect. 
filter | **[RuleFilter](#RuleFilter2)**<br>Filter that identifies the objects to which the rule applies. <br>If not specified, the rule applies to all objects in the bucket. 
expiration | **[Expiration](#Expiration2)**<br>Expiration rule. <br>The expiration of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket3) is `VERSIONING_DISABLED`), the object is deleted and cannot be recovered. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object. <br>For the bucket with versioning suspended ([Bucket.versioning](#Bucket3) is `VERSIONING_SUSPENDED`), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object. 
transitions[] | **[Transition](#Transition2)**<br>List of transition rules. <br>The transition of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket3) is `VERSIONING_DISABLED`), the object is transitioned to the specified storage class. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays2)**<br>Configuration for aborting incomplete [multipart uploads](/docs/storage/concepts/multipart). 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration2)**<br>Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At expiration, the non-current version of the object is deleted and cannot be recovered. 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition2)**<br>List of transition rules for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At transition, the non-current version of the object is transitioned to the specified storage class. 


### AfterDays {#AfterDays2}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted. 


### NoncurrentExpiration {#NoncurrentExpiration2}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version expires. 


### NoncurrentTransition {#NoncurrentTransition2}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned. 
storage_class | **string**<br>Required. Storage class to which a non-current version of an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Transition {#Transition2}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object transition. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately. <br>At most one of `date` and `days` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object is transitioned. <br>At most one of `days` and `date` fields can be specified. 
storage_class | **string**<br>Required. Storage class to which an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Expiration {#Expiration2}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object expiration. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately. <br>Exactly one of `date`, `days`, and `expired_object_delete_marker` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object expires. <br>Exactly one of `days`, `date`, and `expired_object_delete_marker` fields can be specified. 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration. <br>Exactly one of `expired_object_delete_marker`, `date`, and `days` fields can be specified. 


### RuleFilter {#RuleFilter2}

Field | Description
--- | ---
prefix | **string**<br>Key prefix that the object must have in order for the rule to apply. 


## Update {#Update}

Updates the specified bucket. <br>In most cases, `storage.editor` role (see [documentation](/docs/storage/security/#storage-editor)) should be enough to update a bucket, subject to its [policy](/docs/storage/concepts/policy).

**rpc Update ([UpdateBucketRequest](#UpdateBucketRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBucketMetadata](#UpdateBucketMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Bucket](#Bucket3)<br>

### UpdateBucketRequest {#UpdateBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to update. <br>The name cannot be updated. <br>To get the bucket name, make a [BucketService.List](#List) request. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. Field mask that specifies which attributes of the bucket should be updated. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags4)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
default_storage_class | **string**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
max_size | **int64**<br>Maximum size of the bucket, in bytes. For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). 
cors[] | **[CorsRule](#CorsRule3)**<br>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see [documentation](/docs/storage/concepts/cors). 
website_settings | **[WebsiteSettings](#WebsiteSettings3)**<br>Configuration for hosting a static website in the bucket. For details, see [documentation](/docs/storage/concepts/hosting). 
versioning | enum **Versioning**<br>Bucket versioning status. For details, see [documentation](/docs/storage/concepts/versioning). <ul><li>`VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of `null`. <br>To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request. Note that this action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.</li><li>`VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests. <br>To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](#Update) request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</li><li>`VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs. <br>To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request.</li></ul>
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule3)**<br>List of object lifecycle rules for the bucket. For details, see [documentation](/docs/storage/concepts/lifecycles). 
policy | **google.protobuf.Struct**<br>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see [documentation](/docs/storage/concepts/policy). 
acl | **[ACL](#ACL4)**<br>Access control list (ACL) of the bucket. For details, see [documentation](/docs/storage/concepts/acl). 


### AnonymousAccessFlags {#AnonymousAccessFlags4}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


### CorsRule {#CorsRule3}

Field | Description
--- | ---
id | **string**<br>ID of the CORS rule. 
allowed_methods[] | enum **Method**<br>List of HTTP methods allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Method` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the `Access-Control-Allow-Methods` header of the response. The number of elements must be greater than 0.<ul><li>`METHOD_GET`: HTTP `GET` method.</li><li>`METHOD_HEAD`: HTTP `HEAD` method.</li><li>`METHOD_POST`: HTTP `POST` method.</li><li>`METHOD_PUT`: HTTP `PUT` method.</li><li>`METHOD_DELETE`: HTTP `DELETE` method.</li></ul>
allowed_headers[] | **string**<br>List of HTTP headers allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Headers` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the `Access-Control-Allow-Headers` header of the response. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `x-amz-*` value will allow all Amazon S3-compatible headers. 
allowed_origins[] | **string**<br>List of request origins allowed by the CORS rule. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `http://*.example.com` value will allow requests originating from all subdomains of `example.com`. The number of elements must be greater than 0.
expose_headers[] | **string**<br>List of headers contained in responses to CORS requests that can be accessed by applications. 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin. 


### WebsiteSettings {#WebsiteSettings3}

Field | Description
--- | ---
index | **string**<br>Key of the index page object that is returned when a response is made to the root of the website. <br>Either `index` or `redirect_all_requests` must be specified in order for the bucket to host a static website. <br>If specified, the index page object must be located in the root of the bucket. 
error | **string**<br>Key of the error page object that is returned when an error occurs. 
redirect_all_requests | **[Scheme](#Scheme3)**<br>Configuration for redirecting all requests sent to the website. <br>Either `redirect_all_requests` or `index` must be specified in order for the bucket to host a static website. If `redirect_all_requests` is specified, it must be the only field in [Bucket.website_settings](#Bucket3). 
routing_rules[] | **[RoutingRule](#RoutingRule3)**<br>List of redirect rules. 


### Scheme {#Scheme3}

Field | Description
--- | ---
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
hostname | **string**<br>Hostname of the redirect URI. 


### Condition {#Condition3}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br>HTTP status code (number only) that must match for the redirect to apply. 
key_prefix_equals | **string**<br>Prefix of the object key from which requests are redirected. 


### Redirect {#Redirect3}

Field | Description
--- | ---
hostname | **string**<br>Hostname of the redirect URI. 
http_redirect_code | **string**<br>HTTP status code of the redirect response. <br>Default value: `"301"`. Value must match the regular expression ` 3(0[1-9]\|[1-9][0-9]) `.
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
replace_key_prefix_with | **string**<br>Substitution for the prefix of the object key specified in [Condition.key_prefix_equals](#Condition3). <br>At most one of `replace_key_prefix_with` and `replace_key_with` can be specified. 
replace_key_with | **string**<br>New object key. <br>At most one of `replace_key_with` and `replace_key_prefix_with` can be specified. 


### RoutingRule {#RoutingRule3}

Field | Description
--- | ---
condition | **[Condition](#Condition3)**<br>Redirect condition. 
redirect | **[Redirect](#Redirect3)**<br>Redirect instructions. 


### LifecycleRule {#LifecycleRule3}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br>ID of the rule. Provided by the client or generated at creation time. 
enabled | **bool**<br>Indicates whether the rule is in effect. 
filter | **[RuleFilter](#RuleFilter3)**<br>Filter that identifies the objects to which the rule applies. <br>If not specified, the rule applies to all objects in the bucket. 
expiration | **[Expiration](#Expiration3)**<br>Expiration rule. <br>The expiration of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket3) is `VERSIONING_DISABLED`), the object is deleted and cannot be recovered. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object. <br>For the bucket with versioning suspended ([Bucket.versioning](#Bucket3) is `VERSIONING_SUSPENDED`), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object. 
transitions[] | **[Transition](#Transition3)**<br>List of transition rules. <br>The transition of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket3) is `VERSIONING_DISABLED`), the object is transitioned to the specified storage class. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays3)**<br>Configuration for aborting incomplete [multipart uploads](/docs/storage/concepts/multipart). 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration3)**<br>Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At expiration, the non-current version of the object is deleted and cannot be recovered. 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition3)**<br>List of transition rules for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket3) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At transition, the non-current version of the object is transitioned to the specified storage class. 


### AfterDays {#AfterDays3}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted. 


### NoncurrentExpiration {#NoncurrentExpiration3}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version expires. 


### NoncurrentTransition {#NoncurrentTransition3}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned. 
storage_class | **string**<br>Required. Storage class to which a non-current version of an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Transition {#Transition3}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object transition. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately. <br>At most one of `date` and `days` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object is transitioned. <br>At most one of `days` and `date` fields can be specified. 
storage_class | **string**<br>Required. Storage class to which an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Expiration {#Expiration3}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object expiration. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately. <br>Exactly one of `date`, `days`, and `expired_object_delete_marker` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object expires. <br>Exactly one of `days`, `date`, and `expired_object_delete_marker` fields can be specified. 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration. <br>Exactly one of `expired_object_delete_marker`, `date`, and `days` fields can be specified. 


### RuleFilter {#RuleFilter3}

Field | Description
--- | ---
prefix | **string**<br>Key prefix that the object must have in order for the rule to apply. 


### ACL {#ACL4}

Field | Description
--- | ---
grants[] | **[Grant](#Grant4)**<br>List of permissions granted and the grantees. 


### Grant {#Grant4}

Field | Description
--- | ---
permission | enum **Permission**<br>Required. Permission granted by the grant. <ul><li>`PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP` on the bucket. <br>Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects. <br>Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket. <br>Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ`: Allows grantee to list the objects in the bucket. <br>Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL <br>Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li></ul>
grant_type | enum **GrantType**<br>Required. The grantee type for the grant. <ul><li>`GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts). <br>For this grantee type, you need to specify the user ID in [Bucket.acl.grants.grantee_id](#Bucket3) field. To get user ID, see [instruction](/docs/iam/operations/users/get). <br>Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li></ul>
grantee_id | **string**<br>ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateBucketMetadata](#UpdateBucketMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Bucket](#Bucket3)>**<br>if operation finished successfully. 


### UpdateBucketMetadata {#UpdateBucketMetadata}

Field | Description
--- | ---
name | **string**<br>Name of the bucket that is being updated. 


### Bucket {#Bucket3}

Field | Description
--- | ---
id | **string**<br>ID of the bucket. Always equal to `name`, which has priority. 
name | **string**<br>Name of the bucket. <br>The name is unique within the platform. For naming limitations and rules, see [documentation](/docs/storage/concepts/bucket#naming). 
folder_id | **string**<br>ID of the folder that the bucket belongs to. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags5)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
default_storage_class | **string**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
versioning | enum **Versioning**<br>Bucket versioning status. For details, see [documentation](/docs/storage/concepts/versioning). <ul><li>`VERSIONING_DISABLED`: The bucket is unversioned, i.e. versioning has never been enabled for the bucket, including at its creation. Objects that are stored in the bucket have a version ID of `null`. <br>To enable versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request. Note that this action is irreversible, and a bucket with versioning enabled can never return to `VERSIONING_DISABLED` state.</li><li>`VERSIONING_ENABLED`: Bucket versioning is enabled, i.e. all new objects are versioned and given a unique version ID, and objects that already existed at the time versioning was enabled will be versioned and given a unique version ID when modified by future requests. <br>To suspend versioning, change status to `VERSIONING_SUSPENDED` via a [BucketService.Update](#Update) request. You cannot disable versioning altogether for a bucket that already had it enabled; objects that had version IDs will keep them.</li><li>`VERSIONING_SUSPENDED`: Bucket versioning is suspended, i.e. new objects are not versioned, but objects that already existed at the time versioning was suspended are still versioned and keep their version IDs. <br>To resume versioning, change status to `VERSIONING_ENABLED` via a [BucketService.Update](#Update) request.</li></ul>
max_size | **int64**<br>Maximum size of the bucket, in bytes. For details, see [documentation](/docs/storage/operations/buckets/limit-max-volume). 
policy | **google.protobuf.Struct**<br>Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see [documentation](/docs/storage/concepts/policy). 
acl | **[ACL](#ACL5)**<br>Access control list (ACL) of the bucket. For details, see [documentation](/docs/storage/concepts/acl). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
cors[] | **[CorsRule](#CorsRule4)**<br>List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see [documentation](/docs/storage/concepts/cors). 
website_settings | **[WebsiteSettings](#WebsiteSettings4)**<br>Configuration for hosting a static website in the bucket. For details, see [documentation](/docs/storage/concepts/hosting). 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule4)**<br>List of object lifecycle rules for the bucket. For details, see [documentation](/docs/storage/concepts/lifecycles). 


### AnonymousAccessFlags {#AnonymousAccessFlags5}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


### ACL {#ACL5}

Field | Description
--- | ---
grants[] | **[Grant](#Grant5)**<br>List of permissions granted and the grantees. 


### Grant {#Grant5}

Field | Description
--- | ---
permission | enum **Permission**<br>Required. Permission granted by the grant. <ul><li>`PERMISSION_FULL_CONTROL`: Allows grantee the `PERMISSION_WRITE`, `PERMISSION_WRITE_ACP`, `PERMISSION_READ`, and `PERMISSION_READ_ACP` on the bucket. <br>Maps to `x-amz-grant-full-control` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE`: Allows grantee to create new objects in the bucket. For the bucket and object owners of existing objects, also allows deletions and overwrites of those objects. <br>Maps to `x-amz-grant-write` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_WRITE_ACP`: Allows grantee to write the ACL for the bucket. <br>Maps to `x-amz-grant-write-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ`: Allows grantee to list the objects in the bucket. <br>Maps to `x-amz-grant-read` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li><li>`PERMISSION_READ_ACP`: Allows grantee to read the bucket ACL <br>Maps to `x-amz-grant-read-acp` header for [bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API.</li></ul>
grant_type | enum **GrantType**<br>Required. The grantee type for the grant. <ul><li>`GRANT_TYPE_ACCOUNT`: A grantee is an [account on the platform](/docs/iam/concepts/#accounts). <br>For this grantee type, you need to specify the user ID in [Bucket.acl.grants.grantee_id](#Bucket4) field. To get user ID, see [instruction](/docs/iam/operations/users/get). <br>Maps to using `id="*"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: Grantees are all authenticated users, both from your clouds and other users' clouds. Access permission to this group allows any account on the platform to access the resource via a signed (authenticated) request. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AuthenticatedUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li><li>`GRANT_TYPE_ALL_USERS`: Grantees are all internet users. Access permission to this group allows anyone in the world access to the resource via signed (authenticated) or unsigned (anonymous) requests. <br>Maps to using `uri="http://acs.amazonaws.com/groups/global/AllUsers"` value for `x-amz-grant-*` header ([bucketPutAcl](/docs/storage/s3/api-ref/acl/bucketput) method of Amazon S3-compatible HTTP API).</li></ul>
grantee_id | **string**<br>ID of the account who is a grantee. Required when the `grant_type` is `GRANT_TYPE_ACCOUNT`. 


### CorsRule {#CorsRule4}

Field | Description
--- | ---
id | **string**<br>ID of the CORS rule. 
allowed_methods[] | enum **Method**<br>List of HTTP methods allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Method` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the `Access-Control-Allow-Methods` header of the response. The number of elements must be greater than 0.<ul><li>`METHOD_GET`: HTTP `GET` method.</li><li>`METHOD_HEAD`: HTTP `HEAD` method.</li><li>`METHOD_POST`: HTTP `POST` method.</li><li>`METHOD_PUT`: HTTP `PUT` method.</li><li>`METHOD_DELETE`: HTTP `DELETE` method.</li></ul>
allowed_headers[] | **string**<br>List of HTTP headers allowed by the CORS rule. <br>When a client sends a CORS-preflight `options` request with the `Access-Control-Request-Headers` header (see [S3-compatible API reference](/docs/storage/s3/api-ref/object/options)), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the `Access-Control-Allow-Headers` header of the response. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `x-amz-*` value will allow all Amazon S3-compatible headers. 
allowed_origins[] | **string**<br>List of request origins allowed by the CORS rule. <br>Each string in the list can contain at most one `*` wildcard character that matches 0 or more characters. For example, `http://*.example.com` value will allow requests originating from all subdomains of `example.com`. The number of elements must be greater than 0.
expose_headers[] | **string**<br>List of headers contained in responses to CORS requests that can be accessed by applications. 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin. 


### WebsiteSettings {#WebsiteSettings4}

Field | Description
--- | ---
index | **string**<br>Key of the index page object that is returned when a response is made to the root of the website. <br>Either `index` or `redirect_all_requests` must be specified in order for the bucket to host a static website. <br>If specified, the index page object must be located in the root of the bucket. 
error | **string**<br>Key of the error page object that is returned when an error occurs. 
redirect_all_requests | **[Scheme](#Scheme4)**<br>Configuration for redirecting all requests sent to the website. <br>Either `redirect_all_requests` or `index` must be specified in order for the bucket to host a static website. If `redirect_all_requests` is specified, it must be the only field in [Bucket.website_settings](#Bucket4). 
routing_rules[] | **[RoutingRule](#RoutingRule4)**<br>List of redirect rules. 


### Scheme {#Scheme4}

Field | Description
--- | ---
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
hostname | **string**<br>Hostname of the redirect URI. 


### Condition {#Condition4}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br>HTTP status code (number only) that must match for the redirect to apply. 
key_prefix_equals | **string**<br>Prefix of the object key from which requests are redirected. 


### Redirect {#Redirect4}

Field | Description
--- | ---
hostname | **string**<br>Hostname of the redirect URI. 
http_redirect_code | **string**<br>HTTP status code of the redirect response. <br>Default value: `"301"`. Value must match the regular expression ` 3(0[1-9]\|[1-9][0-9]) `.
protocol | enum **Protocol**<br>Scheme of the redirect URI. <ul><li>`PROTOCOL_HTTP`: `http` scheme.</li><li>`PROTOCOL_HTTPS`: `https` scheme.</li></ul>
replace_key_prefix_with | **string**<br>Substitution for the prefix of the object key specified in [Condition.key_prefix_equals](#Condition4). <br>At most one of `replace_key_prefix_with` and `replace_key_with` can be specified. 
replace_key_with | **string**<br>New object key. <br>At most one of `replace_key_with` and `replace_key_prefix_with` can be specified. 


### RoutingRule {#RoutingRule4}

Field | Description
--- | ---
condition | **[Condition](#Condition4)**<br>Redirect condition. 
redirect | **[Redirect](#Redirect4)**<br>Redirect instructions. 


### LifecycleRule {#LifecycleRule4}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br>ID of the rule. Provided by the client or generated at creation time. 
enabled | **bool**<br>Indicates whether the rule is in effect. 
filter | **[RuleFilter](#RuleFilter4)**<br>Filter that identifies the objects to which the rule applies. <br>If not specified, the rule applies to all objects in the bucket. 
expiration | **[Expiration](#Expiration4)**<br>Expiration rule. <br>The expiration of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket4) is `VERSIONING_DISABLED`), the object is deleted and cannot be recovered. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket4) is `VERSIONING_ENABLED`), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object. <br>For the bucket with versioning suspended ([Bucket.versioning](#Bucket4) is `VERSIONING_SUSPENDED`), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object. 
transitions[] | **[Transition](#Transition4)**<br>List of transition rules. <br>The transition of an object is described as follows. <br>For the unversioned bucket ([Bucket.versioning](#Bucket4) is `VERSIONING_DISABLED`), the object is transitioned to the specified storage class. <br>For the bucket with versioning enabled ([Bucket.versioning](#Bucket4) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`), the current version of the object is transitioned to the specified storage class. 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays4)**<br>Configuration for aborting incomplete [multipart uploads](/docs/storage/concepts/multipart). 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration4)**<br>Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket4) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At expiration, the non-current version of the object is deleted and cannot be recovered. 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition4)**<br>List of transition rules for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning](#Bucket4) is `VERSIONING_ENABLED`) or suspended (`VERSIONING_SUSPENDED`). <br>At transition, the non-current version of the object is transitioned to the specified storage class. 


### AfterDays {#AfterDays4}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted. 


### NoncurrentExpiration {#NoncurrentExpiration4}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version expires. 


### NoncurrentTransition {#NoncurrentTransition4}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned. 
storage_class | **string**<br>Required. Storage class to which a non-current version of an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Transition {#Transition4}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object transition. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately. <br>At most one of `date` and `days` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object is transitioned. <br>At most one of `days` and `date` fields can be specified. 
storage_class | **string**<br>Required. Storage class to which an object is transitioned from standard storage. <br>The only supported class is cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed. 


### Expiration {#Expiration4}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Specific date of object expiration. <br>The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately. <br>Exactly one of `date`, `days`, and `expired_object_delete_marker` fields can be specified. 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Time period, in number of days from the creation or modification of the object, after which an object expires. <br>Exactly one of `days`, `date`, and `expired_object_delete_marker` fields can be specified. 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration. <br>Exactly one of `expired_object_delete_marker`, `date`, and `days` fields can be specified. 


### RuleFilter {#RuleFilter4}

Field | Description
--- | ---
prefix | **string**<br>Key prefix that the object must have in order for the rule to apply. 


## Delete {#Delete}

Deletes the specified bucket.

**rpc Delete ([DeleteBucketRequest](#DeleteBucketRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBucketMetadata](#DeleteBucketMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBucketRequest {#DeleteBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to update. <br>To get the bucket name, make a [BucketService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBucketMetadata](#DeleteBucketMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBucketMetadata {#DeleteBucketMetadata}

Field | Description
--- | ---
name | **string**<br>Name of the bucket that is being deleted. 


## GetStats {#GetStats}

Returns the statistics for the specified bucket.

**rpc GetStats ([GetBucketStatsRequest](#GetBucketStatsRequest)) returns ([BucketStats](#BucketStats))**

### GetBucketStatsRequest {#GetBucketStatsRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to return the statistics for. 


### BucketStats {#BucketStats}

Field | Description
--- | ---
name | **string**<br>Name of the bucket. 
max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Maximum size of the bucket, in bytes. 
used_size | **int64**<br>Size of used space in the bucket, in bytes. 
storage_class_max_sizes[] | **[OptionalSizeByClass](#OptionalSizeByClass)**<br>Size of available space in the bucket by storage class, in bytes. 
storage_class_used_sizes[] | **[SizeByClass](#SizeByClass)**<br>Size of used space in the bucket by storage class, in bytes. 
storage_class_counters[] | **[CountersByClass](#CountersByClass)**<br>Object-related statistics by storage class and type of upload (simple vs. multipart), in bytes. 
default_storage_class | **google.protobuf.StringValue**<br>Default storage class for objects in the bucket. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags6)**<br>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see [documentation](/docs/storage/concepts/bucket#bucket-access). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Bucket creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Bucket latest update timestamp. 


### OptionalSizeByClass {#OptionalSizeByClass}

Field | Description
--- | ---
storage_class | **string**<br>Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
class_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Size of available space in the bucket for the storage class. 


### SizeByClass {#SizeByClass}

Field | Description
--- | ---
storage_class | **string**<br>Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ICE` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
class_size | **int64**<br>Size of used space in the bucket for the storage class. 


### CountersByClass {#CountersByClass}

Field | Description
--- | ---
storage_class | **string**<br>Storage class. Supported classes are standard storage (`STANDARD`), cold storage (`COLD`, `STANDARD_IA`, `NEARLINE` all synonyms), and ice storage (`ice` and `GLACIER` are synonyms). For details, see [documentation](/docs/storage/concepts/storage-class). 
counters | **[Counters](#Counters)**<br>Object-related statistics for the storage class by type of upload. 


### Counters {#Counters}

Field | Description
--- | ---
simple_object_size | **int64**<br>Total size of objects uploaded in single operation, in bytes. 
simple_object_count | **int64**<br>Number of objects uploaded in single operation. 
objects_parts_size | **int64**<br>Total size of uploaded parts in incomplete multipart uploads, in bytes. 
objects_parts_count | **int64**<br>Number of uploaded parts in incomplete multipart uploads. 
multipart_objects_size | **int64**<br>Total size of objects uploaded in multiple parts, in bytes. 
multipart_objects_count | **int64**<br>Number of objects uploaded in multiple parts. 
active_multipart_count | **int64**<br>Number of incomplete multipart uploads. 


### AnonymousAccessFlags {#AnonymousAccessFlags6}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read objects in the bucket is enabled. 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled. 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Specifies whether public (anonymous) access to read [CORS](/docs/storage/concepts/cors), [static website hosting](/docs/storage/concepts/hosting), and [object lifecycles](/docs/storage/concepts/lifecycles) settings of the bucket is enabled. 


## GetHTTPSConfig {#GetHTTPSConfig}

Returns the HTTPS configuration for the specified bucket.

**rpc GetHTTPSConfig ([GetBucketHTTPSConfigRequest](#GetBucketHTTPSConfigRequest)) returns ([HTTPSConfig](#HTTPSConfig))**

### GetBucketHTTPSConfigRequest {#GetBucketHTTPSConfigRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to return the HTTPS configuration for. 


### HTTPSConfig {#HTTPSConfig}

Field | Description
--- | ---
name | **string**<br>Name of the bucket. 
source_type | enum **SourceType**<br>Type of TLS certificate source. <ul><li>`SOURCE_TYPE_SELF_MANAGED`: Your certificate, uploaded directly.</li><li>`SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER`: Certificate managed by Certificate Manager.</li></ul>
issuer | **google.protobuf.StringValue**<br>Issuer of the TLS certificate. 
subject | **google.protobuf.StringValue**<br>Subject of the TLS certificate. 
dns_names[] | **string**<br>List of DNS names of the TLS certificate (Subject Alternative Name field). 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start of the TLS certificate validity period (Not Before field). 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End of the TLS certificate validity period (Not After field) 
certificate_id | **string**<br>ID of the TLS certificate in Certificate Manager. <br>To get information about the certificate from Certificate Manager, make a [yandex.cloud.certificatemanager.v1.CertificateService.Get](/docs/certificate-manager/api-ref/grpc/certificate_service#Get) request. 


## SetHTTPSConfig {#SetHTTPSConfig}

Updates the HTTPS configuration for the specified bucket. <br>The updated configuration could take up to 30 minutes to apply to the bucket.

**rpc SetHTTPSConfig ([SetBucketHTTPSConfigRequest](#SetBucketHTTPSConfigRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetBucketHTTPSConfigMetadata](#SetBucketHTTPSConfigMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HTTPSConfig](#HTTPSConfig1)<br>

### SetBucketHTTPSConfigRequest {#SetBucketHTTPSConfigRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to update the HTTPS configuration for. 
params | **oneof:** `self_managed` or `certificate_manager`<br>HTTPS configuration parameters.
&nbsp;&nbsp;self_managed | **[SelfManagedHTTPSConfigParams](#SelfManagedHTTPSConfigParams)**<br>Your TLS certificate, uploaded directly. <br>Object Storage only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates. 
&nbsp;&nbsp;certificate_manager | **[CertificateManagerHTTPSConfigParams](#CertificateManagerHTTPSConfigParams)**<br>TLS certificate from Certificate Manager. <br>To create a certificate in Certificate Manager, make a [yandex.cloud.certificatemanager.v1.CertificateService.Create](/docs/certificate-manager/api-ref/grpc/certificate_service#Create) request. 


### SelfManagedHTTPSConfigParams {#SelfManagedHTTPSConfigParams}

Field | Description
--- | ---
certificate_pem | **string**<br>[PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificate. The maximum string length in characters is 3145728.
private_key_pem | **string**<br>[PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded private key for the certificate. The maximum string length in characters is 3145728.


### CertificateManagerHTTPSConfigParams {#CertificateManagerHTTPSConfigParams}

Field | Description
--- | ---
certificate_id | **string**<br>ID of the certificate. <br>To get the list of all available certificates, make a [yandex.cloud.certificatemanager.v1.CertificateService.List](/docs/certificate-manager/api-ref/grpc/certificate_service#List) request. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetBucketHTTPSConfigMetadata](#SetBucketHTTPSConfigMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HTTPSConfig](#HTTPSConfig1)>**<br>if operation finished successfully. 


### SetBucketHTTPSConfigMetadata {#SetBucketHTTPSConfigMetadata}

Field | Description
--- | ---
name | **string**<br>Name of the bucket the HTTPS configuration is being updated for. 


### HTTPSConfig {#HTTPSConfig1}

Field | Description
--- | ---
name | **string**<br>Name of the bucket. 
source_type | enum **SourceType**<br>Type of TLS certificate source. <ul><li>`SOURCE_TYPE_SELF_MANAGED`: Your certificate, uploaded directly.</li><li>`SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER`: Certificate managed by Certificate Manager.</li></ul>
issuer | **google.protobuf.StringValue**<br>Issuer of the TLS certificate. 
subject | **google.protobuf.StringValue**<br>Subject of the TLS certificate. 
dns_names[] | **string**<br>List of DNS names of the TLS certificate (Subject Alternative Name field). 
not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Start of the TLS certificate validity period (Not Before field). 
not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>End of the TLS certificate validity period (Not After field) 
certificate_id | **string**<br>ID of the TLS certificate in Certificate Manager. <br>To get information about the certificate from Certificate Manager, make a [yandex.cloud.certificatemanager.v1.CertificateService.Get](/docs/certificate-manager/api-ref/grpc/certificate_service#Get) request. 


## DeleteHTTPSConfig {#DeleteHTTPSConfig}

Deletes the HTTPS configuration for the specified bucket.

**rpc DeleteHTTPSConfig ([DeleteBucketHTTPSConfigRequest](#DeleteBucketHTTPSConfigRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBucketHTTPSConfigMetadata](#DeleteBucketHTTPSConfigMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBucketHTTPSConfigRequest {#DeleteBucketHTTPSConfigRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the bucket to delete the HTTPS configuration for. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBucketHTTPSConfigMetadata](#DeleteBucketHTTPSConfigMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBucketHTTPSConfigMetadata {#DeleteBucketHTTPSConfigMetadata}

Field | Description
--- | ---
name | **string**<br>Name of the bucket the HTTPS configuration is being deleted for. 


