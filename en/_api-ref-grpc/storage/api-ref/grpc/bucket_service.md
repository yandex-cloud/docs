---
editable: false
---

# BucketService

BucketService is a control plane for managing buckets inside object 
storage.

| Call | Description |
| --- | --- |
| [List](#List) | Returns the list of buckets for specified folder id. |
| [Get](#Get) | Get specific bucket. |
| [Create](#Create) | Create a new bucket in specified folder. |
| [Update](#Update) | Update the specified bucket. |
| [Delete](#Delete) | Delete the specified bucket. |

## Calls BucketService {#calls}

## List {#List}

<ul><li>"cors" </li><li>"website_settings" </li><li>"lifecycle_rules" </li><li>"acl" </li><li>"policy" </li></ul>

**rpc List ([ListBucketsRequest](#ListBucketsRequest)) returns ([ListBucketsResponse](#ListBucketsResponse))**

### ListBucketsRequest {#ListBucketsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder id for requested buckets. The maximum string length in characters is 50.


### ListBucketsResponse {#ListBucketsResponse}

Field | Description
--- | ---
buckets[] | **[Bucket](#Bucket)**<br>list of buckets that satisfies request. 


### Bucket {#Bucket}

Field | Description
--- | ---
id | **string**<br>Bucket's ID, treated as name. Properties id and name are equal to each other, but name has priority over id. 
name | **string**<br>Bucket's uniqe name. 
folder_id | **string**<br>Folder id to which this bucket belongs. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags)**<br>Access flags for anonymous access. For more information, see [Bucket Access](/docs/storage/concepts/bucket#bucket-access) 
default_storage_class | **string**<br>Storage class of bucket. For more information, see [Storage Class](/docs/storage/concepts/storage-class) 
versioning | enum **Versioning**<br>Bucket's versioning mode. For more information, see [Versioning](/docs/storage/concepts/versioning) <ul><ul/>
max_size | **int64**<br>Maximum size of bucket. For more information, see [Size limits](/docs/storage/operations/buckets/limit-max-volume) 
policy | **google.protobuf.Struct**<br>Bucket's policy. For more information, see [Bucket Policy](/docs/storage/concepts/policy) 
acl | **[ACL](#ACL)**<br>Bucket's ACL. For more information, see [ACL](#ACL)(/docs/storage/concepts/acl) 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creating date. 
cors[] | **[CorsRule](#CorsRule)**<br>CORS settings for bucket, hosted as website. For more information, see [CORS](/docs/storage/concepts/cors) 
website_settings | **[WebsiteSettings](#WebsiteSettings)**<br>Website settings of bucket. For more information, see [Static site hosting](/docs/storage/concepts/hosting) 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule)**<br>Objects's lifecycle rules. For more information, see [Lifecycles](/docs/storage/concepts/lifecycles) 


### AnonymousAccessFlags {#AnonymousAccessFlags}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 


### ACL {#ACL}

Field | Description
--- | ---
grants[] | **[Grant](#Grant)**<br> 


### Grant {#Grant}

Field | Description
--- | ---
permission | enum **Permission**<br>Required.  <ul><li>`PERMISSION_FULL_CONTROL`: header X-Amz-Grant-Full-Control</li><li>`PERMISSION_WRITE`: header X-Amz-Grant-Write</li><li>`PERMISSION_WRITE_ACP`: header X-Amz-Grant-Write-Acp</li><li>`PERMISSION_READ`: header X-Amz-Grant-Read</li><li>`PERMISSION_READ_ACP`: header X-Amz-Grant-Read-Acp</li><ul/>
grant_type | enum **GrantType**<br>Required.  <ul><li>`GRANT_TYPE_ACCOUNT`: equal to 'id' grantee value</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: equal to 'uri' authenticated users</li><li>`GRANT_TYPE_ALL_USERS`: equal to 'uri' all users</li><ul/>
grantee_id | **string**<br>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT 


### CorsRule {#CorsRule}

Field | Description
--- | ---
id | **string**<br> 
allowed_methods[] | enum **Method**<br> The number of elements must be greater than 0.<ul><ul/>
allowed_headers[] | **string**<br>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed. 
allowed_origins[] | **string**<br>allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed. The number of elements must be greater than 0.
expose_headers[] | **string**<br> 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### WebsiteSettings {#WebsiteSettings}

Field | Description
--- | ---
index | **string**<br>index points to entrypoint of the website. Either property "index" or "redirect_all_requests" should be set in order to operate. 
error | **string**<br> 
redirect_all_requests | **[Scheme](#Scheme)**<br>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined. 
routing_rules[] | **[RoutingRule](#RoutingRule)**<br> 


### Scheme {#Scheme}

Field | Description
--- | ---
protocol | **Protocol**<br>by default, http will be used. 
hostname | **string**<br> 


### Condition {#Condition}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br> 
key_prefix_equals | **string**<br> 


### Redirect {#Redirect}

Field | Description
--- | ---
hostname | **string**<br> 
http_redirect_code | **string**<br><ol><li></li></ol> Value must match the regular expression ` 3(0[1-9]|[1-9][0-9]) `.
protocol | **Protocol**<br> 
replace_key_prefix_with | **string**<br> 
replace_key_with | **string**<br> 


### RoutingRule {#RoutingRule}

Field | Description
--- | ---
condition | **[Condition](#Condition)**<br> 
redirect | **[Redirect](#Redirect)**<br> 


### LifecycleRule {#LifecycleRule}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br> 
enabled | **bool**<br> 
filter | **[RuleFilter](#RuleFilter)**<br> 
expiration | **[Expiration](#Expiration)**<br> 
transitions[] | **[Transition](#Transition)**<br> 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays)**<br> 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration)**<br> 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition)**<br> 


### AfterDays {#AfterDays}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentExpiration {#NoncurrentExpiration}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentTransition {#NoncurrentTransition}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Transition {#Transition}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Expiration {#Expiration}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>If date is set, days parameter not allowed 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If days are set, date parameter not allowed 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>if expired_object_delete_marker is set, other parameters are not allowed. 


### RuleFilter {#RuleFilter}

Field | Description
--- | ---
prefix | **string**<br> 


## Get {#Get}

Get specific bucket. <br>To get the lis of available buckets, make a [List](#List) request.

**rpc Get ([GetBucketRequest](#GetBucketRequest)) returns ([Bucket](#Bucket1))**

### GetBucketRequest {#GetBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Bucket's name. To get the bucket name, use [BucketService.List](#List) request. 
view | enum **View**<br>Defines properties that should be returned by a request. <ul><li>`VIEW_UNSPECIFIED`: No specified view. Treated as basic value.</li><li>`VIEW_BASIC`: Fetches basic information about bucket.</li><li>`VIEW_ACL`: Fetches basic information with acl.</li><li>`VIEW_FULL`: Includes all available fields in a bucket.</li><ul/>


### Bucket {#Bucket1}

Field | Description
--- | ---
id | **string**<br>Bucket's ID, treated as name. Properties id and name are equal to each other, but name has priority over id. 
name | **string**<br>Bucket's uniqe name. 
folder_id | **string**<br>Folder id to which this bucket belongs. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags1)**<br>Access flags for anonymous access. For more information, see [Bucket Access](/docs/storage/concepts/bucket#bucket-access) 
default_storage_class | **string**<br>Storage class of bucket. For more information, see [Storage Class](/docs/storage/concepts/storage-class) 
versioning | enum **Versioning**<br>Bucket's versioning mode. For more information, see [Versioning](/docs/storage/concepts/versioning) <ul><ul/>
max_size | **int64**<br>Maximum size of bucket. For more information, see [Size limits](/docs/storage/operations/buckets/limit-max-volume) 
policy | **google.protobuf.Struct**<br>Bucket's policy. For more information, see [Bucket Policy](/docs/storage/concepts/policy) 
acl | **[ACL](#ACL1)**<br>Bucket's ACL. For more information, see [ACL](#ACL1)(/docs/storage/concepts/acl) 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creating date. 
cors[] | **[CorsRule](#CorsRule1)**<br>CORS settings for bucket, hosted as website. For more information, see [CORS](/docs/storage/concepts/cors) 
website_settings | **[WebsiteSettings](#WebsiteSettings1)**<br>Website settings of bucket. For more information, see [Static site hosting](/docs/storage/concepts/hosting) 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule1)**<br>Objects's lifecycle rules. For more information, see [Lifecycles](/docs/storage/concepts/lifecycles) 


### AnonymousAccessFlags {#AnonymousAccessFlags1}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 


### ACL {#ACL1}

Field | Description
--- | ---
grants[] | **[Grant](#Grant1)**<br> 


### Grant {#Grant1}

Field | Description
--- | ---
permission | enum **Permission**<br>Required.  <ul><li>`PERMISSION_FULL_CONTROL`: header X-Amz-Grant-Full-Control</li><li>`PERMISSION_WRITE`: header X-Amz-Grant-Write</li><li>`PERMISSION_WRITE_ACP`: header X-Amz-Grant-Write-Acp</li><li>`PERMISSION_READ`: header X-Amz-Grant-Read</li><li>`PERMISSION_READ_ACP`: header X-Amz-Grant-Read-Acp</li><ul/>
grant_type | enum **GrantType**<br>Required.  <ul><li>`GRANT_TYPE_ACCOUNT`: equal to 'id' grantee value</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: equal to 'uri' authenticated users</li><li>`GRANT_TYPE_ALL_USERS`: equal to 'uri' all users</li><ul/>
grantee_id | **string**<br>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT 


### CorsRule {#CorsRule1}

Field | Description
--- | ---
id | **string**<br> 
allowed_methods[] | enum **Method**<br> The number of elements must be greater than 0.<ul><ul/>
allowed_headers[] | **string**<br>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed. 
allowed_origins[] | **string**<br>allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed. The number of elements must be greater than 0.
expose_headers[] | **string**<br> 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### WebsiteSettings {#WebsiteSettings1}

Field | Description
--- | ---
index | **string**<br>index points to entrypoint of the website. Either property "index" or "redirect_all_requests" should be set in order to operate. 
error | **string**<br> 
redirect_all_requests | **[Scheme](#Scheme1)**<br>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined. 
routing_rules[] | **[RoutingRule](#RoutingRule1)**<br> 


### Scheme {#Scheme1}

Field | Description
--- | ---
protocol | **Protocol**<br>by default, http will be used. 
hostname | **string**<br> 


### Condition {#Condition1}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br> 
key_prefix_equals | **string**<br> 


### Redirect {#Redirect1}

Field | Description
--- | ---
hostname | **string**<br> 
http_redirect_code | **string**<br><ol><li></li></ol> Value must match the regular expression ` 3(0[1-9]|[1-9][0-9]) `.
protocol | **Protocol**<br> 
replace_key_prefix_with | **string**<br> 
replace_key_with | **string**<br> 


### RoutingRule {#RoutingRule1}

Field | Description
--- | ---
condition | **[Condition](#Condition1)**<br> 
redirect | **[Redirect](#Redirect1)**<br> 


### LifecycleRule {#LifecycleRule1}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br> 
enabled | **bool**<br> 
filter | **[RuleFilter](#RuleFilter1)**<br> 
expiration | **[Expiration](#Expiration1)**<br> 
transitions[] | **[Transition](#Transition1)**<br> 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays1)**<br> 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration1)**<br> 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition1)**<br> 


### AfterDays {#AfterDays1}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentExpiration {#NoncurrentExpiration1}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentTransition {#NoncurrentTransition1}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Transition {#Transition1}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Expiration {#Expiration1}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>If date is set, days parameter not allowed 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If days are set, date parameter not allowed 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>if expired_object_delete_marker is set, other parameters are not allowed. 


### RuleFilter {#RuleFilter1}

Field | Description
--- | ---
prefix | **string**<br> 


## Create {#Create}

Create a new bucket in specified folder.

**rpc Create ([CreateBucketRequest](#CreateBucketRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBucketMetadata](#CreateBucketMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Bucket](#Bucket2)<br>

### CreateBucketRequest {#CreateBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Unique name of the bucket. This name is treated as unique identifier and used among the whole Cloud. For naming limitations and rules, see [Bucket naming](/docs/storage/concepts/bucket#naming) 
folder_id | **string**<br>Required. ID of the folder to create a bucket in. To get the folder ID, use [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
default_storage_class | **string**<br>Class of the storage. For more information, see [Storage Class](/docs/storage/concepts/storage-class) 
max_size | **int64**<br>Maximum size of bucket. For more information, see [Size limits](/docs/storage/operations/buckets/limit-max-volume) 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags2)**<br>Access flags for anonymous access. For more information, see [Bucket Access](/docs/storage/concepts/bucket#bucket-access) 
acl | **[ACL](#ACL2)**<br>ACL of bucket. For more information, see [Bucket Policy](/docs/storage/concepts/acl) 


### AnonymousAccessFlags {#AnonymousAccessFlags2}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 


### ACL {#ACL2}

Field | Description
--- | ---
grants[] | **[Grant](#Grant2)**<br> 


### Grant {#Grant2}

Field | Description
--- | ---
permission | enum **Permission**<br>Required.  <ul><li>`PERMISSION_FULL_CONTROL`: header X-Amz-Grant-Full-Control</li><li>`PERMISSION_WRITE`: header X-Amz-Grant-Write</li><li>`PERMISSION_WRITE_ACP`: header X-Amz-Grant-Write-Acp</li><li>`PERMISSION_READ`: header X-Amz-Grant-Read</li><li>`PERMISSION_READ_ACP`: header X-Amz-Grant-Read-Acp</li><ul/>
grant_type | enum **GrantType**<br>Required.  <ul><li>`GRANT_TYPE_ACCOUNT`: equal to 'id' grantee value</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: equal to 'uri' authenticated users</li><li>`GRANT_TYPE_ALL_USERS`: equal to 'uri' all users</li><ul/>
grantee_id | **string**<br>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT 


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
name | **string**<br> 


### Bucket {#Bucket2}

Field | Description
--- | ---
id | **string**<br>Bucket's ID, treated as name. Properties id and name are equal to each other, but name has priority over id. 
name | **string**<br>Bucket's uniqe name. 
folder_id | **string**<br>Folder id to which this bucket belongs. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags3)**<br>Access flags for anonymous access. For more information, see [Bucket Access](/docs/storage/concepts/bucket#bucket-access) 
default_storage_class | **string**<br>Storage class of bucket. For more information, see [Storage Class](/docs/storage/concepts/storage-class) 
versioning | enum **Versioning**<br>Bucket's versioning mode. For more information, see [Versioning](/docs/storage/concepts/versioning) <ul><ul/>
max_size | **int64**<br>Maximum size of bucket. For more information, see [Size limits](/docs/storage/operations/buckets/limit-max-volume) 
policy | **google.protobuf.Struct**<br>Bucket's policy. For more information, see [Bucket Policy](/docs/storage/concepts/policy) 
acl | **[ACL](#ACL3)**<br>Bucket's ACL. For more information, see [ACL](#ACL3)(/docs/storage/concepts/acl) 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creating date. 
cors[] | **[CorsRule](#CorsRule2)**<br>CORS settings for bucket, hosted as website. For more information, see [CORS](/docs/storage/concepts/cors) 
website_settings | **[WebsiteSettings](#WebsiteSettings2)**<br>Website settings of bucket. For more information, see [Static site hosting](/docs/storage/concepts/hosting) 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule2)**<br>Objects's lifecycle rules. For more information, see [Lifecycles](/docs/storage/concepts/lifecycles) 


### AnonymousAccessFlags {#AnonymousAccessFlags3}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 


### ACL {#ACL3}

Field | Description
--- | ---
grants[] | **[Grant](#Grant3)**<br> 


### Grant {#Grant3}

Field | Description
--- | ---
permission | enum **Permission**<br>Required.  <ul><li>`PERMISSION_FULL_CONTROL`: header X-Amz-Grant-Full-Control</li><li>`PERMISSION_WRITE`: header X-Amz-Grant-Write</li><li>`PERMISSION_WRITE_ACP`: header X-Amz-Grant-Write-Acp</li><li>`PERMISSION_READ`: header X-Amz-Grant-Read</li><li>`PERMISSION_READ_ACP`: header X-Amz-Grant-Read-Acp</li><ul/>
grant_type | enum **GrantType**<br>Required.  <ul><li>`GRANT_TYPE_ACCOUNT`: equal to 'id' grantee value</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: equal to 'uri' authenticated users</li><li>`GRANT_TYPE_ALL_USERS`: equal to 'uri' all users</li><ul/>
grantee_id | **string**<br>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT 


### CorsRule {#CorsRule2}

Field | Description
--- | ---
id | **string**<br> 
allowed_methods[] | enum **Method**<br> The number of elements must be greater than 0.<ul><ul/>
allowed_headers[] | **string**<br>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed. 
allowed_origins[] | **string**<br>allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed. The number of elements must be greater than 0.
expose_headers[] | **string**<br> 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### WebsiteSettings {#WebsiteSettings2}

Field | Description
--- | ---
index | **string**<br>index points to entrypoint of the website. Either property "index" or "redirect_all_requests" should be set in order to operate. 
error | **string**<br> 
redirect_all_requests | **[Scheme](#Scheme2)**<br>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined. 
routing_rules[] | **[RoutingRule](#RoutingRule2)**<br> 


### Scheme {#Scheme2}

Field | Description
--- | ---
protocol | **Protocol**<br>by default, http will be used. 
hostname | **string**<br> 


### Condition {#Condition2}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br> 
key_prefix_equals | **string**<br> 


### Redirect {#Redirect2}

Field | Description
--- | ---
hostname | **string**<br> 
http_redirect_code | **string**<br><ol><li></li></ol> Value must match the regular expression ` 3(0[1-9]|[1-9][0-9]) `.
protocol | **Protocol**<br> 
replace_key_prefix_with | **string**<br> 
replace_key_with | **string**<br> 


### RoutingRule {#RoutingRule2}

Field | Description
--- | ---
condition | **[Condition](#Condition2)**<br> 
redirect | **[Redirect](#Redirect2)**<br> 


### LifecycleRule {#LifecycleRule2}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br> 
enabled | **bool**<br> 
filter | **[RuleFilter](#RuleFilter2)**<br> 
expiration | **[Expiration](#Expiration2)**<br> 
transitions[] | **[Transition](#Transition2)**<br> 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays2)**<br> 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration2)**<br> 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition2)**<br> 


### AfterDays {#AfterDays2}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentExpiration {#NoncurrentExpiration2}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentTransition {#NoncurrentTransition2}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Transition {#Transition2}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Expiration {#Expiration2}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>If date is set, days parameter not allowed 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If days are set, date parameter not allowed 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>if expired_object_delete_marker is set, other parameters are not allowed. 


### RuleFilter {#RuleFilter2}

Field | Description
--- | ---
prefix | **string**<br> 


## Update {#Update}

Update the specified bucket.

**rpc Update ([UpdateBucketRequest](#UpdateBucketRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBucketMetadata](#UpdateBucketMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Bucket](#Bucket3)<br>

### UpdateBucketRequest {#UpdateBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Unique name of the bucket. To get the bucket name, use [BucketService.List](#List) request. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. field_maks defines fields that should be updated. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags4)**<br>Access flags for anonymous access. For more information, see [Bucket Access](/docs/storage/concepts/bucket#bucket-access) 
default_storage_class | **string**<br>Storage class of bucket. For more information, see [Storage Class](/docs/storage/concepts/storage-class) 
max_size | **int64**<br>Maximum size of bucket. For more information, see [Size limits](/docs/storage/operations/buckets/limit-max-volume) 
cors[] | **[CorsRule](#CorsRule3)**<br>CORS settings for bucket, hosted as website. For more information, see [CORS](/docs/storage/concepts/cors) 
website_settings | **[WebsiteSettings](#WebsiteSettings3)**<br>Website settings of bucket. For more information, see [Static site hosting](/docs/storage/concepts/hosting) 
versioning | enum **Versioning**<br>Bucket's versioning mode. For more information, see [Versioning](/docs/storage/concepts/versioning) <ul><ul/>
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule3)**<br>Objects's lifecycle rules. For more information, see [Lifecycles](/docs/storage/concepts/lifecycles) 
policy | **google.protobuf.Struct**<br>Bucket's policy. For more information, see [Bucket Policy](/docs/storage/concepts/policy) 
acl | **[ACL](#ACL4)**<br>Bucket's ACL. For more information, see [ACL](#ACL4)(/docs/storage/concepts/acl) 


### AnonymousAccessFlags {#AnonymousAccessFlags4}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 


### CorsRule {#CorsRule3}

Field | Description
--- | ---
id | **string**<br> 
allowed_methods[] | enum **Method**<br> The number of elements must be greater than 0.<ul><ul/>
allowed_headers[] | **string**<br>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed. 
allowed_origins[] | **string**<br>allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed. The number of elements must be greater than 0.
expose_headers[] | **string**<br> 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### WebsiteSettings {#WebsiteSettings3}

Field | Description
--- | ---
index | **string**<br>index points to entrypoint of the website. Either property "index" or "redirect_all_requests" should be set in order to operate. 
error | **string**<br> 
redirect_all_requests | **[Scheme](#Scheme3)**<br>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined. 
routing_rules[] | **[RoutingRule](#RoutingRule3)**<br> 


### Scheme {#Scheme3}

Field | Description
--- | ---
protocol | **Protocol**<br>by default, http will be used. 
hostname | **string**<br> 


### Condition {#Condition3}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br> 
key_prefix_equals | **string**<br> 


### Redirect {#Redirect3}

Field | Description
--- | ---
hostname | **string**<br> 
http_redirect_code | **string**<br><ol><li></li></ol> Value must match the regular expression ` 3(0[1-9]|[1-9][0-9]) `.
protocol | **Protocol**<br> 
replace_key_prefix_with | **string**<br> 
replace_key_with | **string**<br> 


### RoutingRule {#RoutingRule3}

Field | Description
--- | ---
condition | **[Condition](#Condition3)**<br> 
redirect | **[Redirect](#Redirect3)**<br> 


### LifecycleRule {#LifecycleRule3}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br> 
enabled | **bool**<br> 
filter | **[RuleFilter](#RuleFilter3)**<br> 
expiration | **[Expiration](#Expiration3)**<br> 
transitions[] | **[Transition](#Transition3)**<br> 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays3)**<br> 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration3)**<br> 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition3)**<br> 


### AfterDays {#AfterDays3}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentExpiration {#NoncurrentExpiration3}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentTransition {#NoncurrentTransition3}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Transition {#Transition3}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Expiration {#Expiration3}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>If date is set, days parameter not allowed 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If days are set, date parameter not allowed 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>if expired_object_delete_marker is set, other parameters are not allowed. 


### RuleFilter {#RuleFilter3}

Field | Description
--- | ---
prefix | **string**<br> 


### ACL {#ACL4}

Field | Description
--- | ---
grants[] | **[Grant](#Grant4)**<br> 


### Grant {#Grant4}

Field | Description
--- | ---
permission | enum **Permission**<br>Required.  <ul><li>`PERMISSION_FULL_CONTROL`: header X-Amz-Grant-Full-Control</li><li>`PERMISSION_WRITE`: header X-Amz-Grant-Write</li><li>`PERMISSION_WRITE_ACP`: header X-Amz-Grant-Write-Acp</li><li>`PERMISSION_READ`: header X-Amz-Grant-Read</li><li>`PERMISSION_READ_ACP`: header X-Amz-Grant-Read-Acp</li><ul/>
grant_type | enum **GrantType**<br>Required.  <ul><li>`GRANT_TYPE_ACCOUNT`: equal to 'id' grantee value</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: equal to 'uri' authenticated users</li><li>`GRANT_TYPE_ALL_USERS`: equal to 'uri' all users</li><ul/>
grantee_id | **string**<br>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT 


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
name | **string**<br> 


### Bucket {#Bucket3}

Field | Description
--- | ---
id | **string**<br>Bucket's ID, treated as name. Properties id and name are equal to each other, but name has priority over id. 
name | **string**<br>Bucket's uniqe name. 
folder_id | **string**<br>Folder id to which this bucket belongs. 
anonymous_access_flags | **[AnonymousAccessFlags](#AnonymousAccessFlags5)**<br>Access flags for anonymous access. For more information, see [Bucket Access](/docs/storage/concepts/bucket#bucket-access) 
default_storage_class | **string**<br>Storage class of bucket. For more information, see [Storage Class](/docs/storage/concepts/storage-class) 
versioning | enum **Versioning**<br>Bucket's versioning mode. For more information, see [Versioning](/docs/storage/concepts/versioning) <ul><ul/>
max_size | **int64**<br>Maximum size of bucket. For more information, see [Size limits](/docs/storage/operations/buckets/limit-max-volume) 
policy | **google.protobuf.Struct**<br>Bucket's policy. For more information, see [Bucket Policy](/docs/storage/concepts/policy) 
acl | **[ACL](#ACL5)**<br>Bucket's ACL. For more information, see [ACL](#ACL5)(/docs/storage/concepts/acl) 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creating date. 
cors[] | **[CorsRule](#CorsRule4)**<br>CORS settings for bucket, hosted as website. For more information, see [CORS](/docs/storage/concepts/cors) 
website_settings | **[WebsiteSettings](#WebsiteSettings4)**<br>Website settings of bucket. For more information, see [Static site hosting](/docs/storage/concepts/hosting) 
lifecycle_rules[] | **[LifecycleRule](#LifecycleRule4)**<br>Objects's lifecycle rules. For more information, see [Lifecycles](/docs/storage/concepts/lifecycles) 


### AnonymousAccessFlags {#AnonymousAccessFlags5}

Field | Description
--- | ---
read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
list | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
config_read | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 


### ACL {#ACL5}

Field | Description
--- | ---
grants[] | **[Grant](#Grant5)**<br> 


### Grant {#Grant5}

Field | Description
--- | ---
permission | enum **Permission**<br>Required.  <ul><li>`PERMISSION_FULL_CONTROL`: header X-Amz-Grant-Full-Control</li><li>`PERMISSION_WRITE`: header X-Amz-Grant-Write</li><li>`PERMISSION_WRITE_ACP`: header X-Amz-Grant-Write-Acp</li><li>`PERMISSION_READ`: header X-Amz-Grant-Read</li><li>`PERMISSION_READ_ACP`: header X-Amz-Grant-Read-Acp</li><ul/>
grant_type | enum **GrantType**<br>Required.  <ul><li>`GRANT_TYPE_ACCOUNT`: equal to 'id' grantee value</li><li>`GRANT_TYPE_ALL_AUTHENTICATED_USERS`: equal to 'uri' authenticated users</li><li>`GRANT_TYPE_ALL_USERS`: equal to 'uri' all users</li><ul/>
grantee_id | **string**<br>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT 


### CorsRule {#CorsRule4}

Field | Description
--- | ---
id | **string**<br> 
allowed_methods[] | enum **Method**<br> The number of elements must be greater than 0.<ul><ul/>
allowed_headers[] | **string**<br>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed. 
allowed_origins[] | **string**<br>allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed. The number of elements must be greater than 0.
expose_headers[] | **string**<br> 
max_age_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### WebsiteSettings {#WebsiteSettings4}

Field | Description
--- | ---
index | **string**<br>index points to entrypoint of the website. Either property "index" or "redirect_all_requests" should be set in order to operate. 
error | **string**<br> 
redirect_all_requests | **[Scheme](#Scheme4)**<br>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined. 
routing_rules[] | **[RoutingRule](#RoutingRule4)**<br> 


### Scheme {#Scheme4}

Field | Description
--- | ---
protocol | **Protocol**<br>by default, http will be used. 
hostname | **string**<br> 


### Condition {#Condition4}

Field | Description
--- | ---
http_error_code_returned_equals | **string**<br> 
key_prefix_equals | **string**<br> 


### Redirect {#Redirect4}

Field | Description
--- | ---
hostname | **string**<br> 
http_redirect_code | **string**<br><ol><li></li></ol> Value must match the regular expression ` 3(0[1-9]|[1-9][0-9]) `.
protocol | **Protocol**<br> 
replace_key_prefix_with | **string**<br> 
replace_key_with | **string**<br> 


### RoutingRule {#RoutingRule4}

Field | Description
--- | ---
condition | **[Condition](#Condition4)**<br> 
redirect | **[Redirect](#Redirect4)**<br> 


### LifecycleRule {#LifecycleRule4}

Field | Description
--- | ---
id | **google.protobuf.StringValue**<br> 
enabled | **bool**<br> 
filter | **[RuleFilter](#RuleFilter4)**<br> 
expiration | **[Expiration](#Expiration4)**<br> 
transitions[] | **[Transition](#Transition4)**<br> 
abort_incomplete_multipart_upload | **[AfterDays](#AfterDays4)**<br> 
noncurrent_expiration | **[NoncurrentExpiration](#NoncurrentExpiration4)**<br> 
noncurrent_transitions[] | **[NoncurrentTransition](#NoncurrentTransition4)**<br> 


### AfterDays {#AfterDays4}

Field | Description
--- | ---
days_after_expiration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentExpiration {#NoncurrentExpiration4}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 


### NoncurrentTransition {#NoncurrentTransition4}

Field | Description
--- | ---
noncurrent_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Transition {#Transition4}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
storage_class | **string**<br>Required.  


### Expiration {#Expiration4}

Field | Description
--- | ---
date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>If date is set, days parameter not allowed 
days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If days are set, date parameter not allowed 
expired_object_delete_marker | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>if expired_object_delete_marker is set, other parameters are not allowed. 


### RuleFilter {#RuleFilter4}

Field | Description
--- | ---
prefix | **string**<br> 


## Delete {#Delete}

Delete the specified bucket.

**rpc Delete ([DeleteBucketRequest](#DeleteBucketRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBucketMetadata](#DeleteBucketMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBucketRequest {#DeleteBucketRequest}

Field | Description
--- | ---
name | **string**<br>Required. Unique name of the bucket. To get the bucket name, use [BucketService.List](#List) request. 


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
name | **string**<br> 


