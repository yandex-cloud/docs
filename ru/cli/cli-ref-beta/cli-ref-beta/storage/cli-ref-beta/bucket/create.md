---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/bucket/create.md
---

# yc beta storage bucket create

Creates a bucket in the specified folder.

#### Command Usage

Syntax: 

`yc beta storage bucket create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--acl`|<b>`shorthand/json`</b><br/>Access control list (ACL) of the bucket. For details, see documentation.<br/>Shorthand Syntax:<br/>{<br/>grants = [<br/>{<br/>grant-type = GRANT_TYPE_ACCOUNT\|GRANT_TYPE_ALL_AUTHENTICATED_USERS\|GRANT_TYPE_ALL_USERS,<br/>grantee-id = str,<br/>permission = PERMISSION_FULL_CONTROL\|PERMISSION_WRITE\|PERMISSION_WRITE_ACP\|PERMISSION_READ\|PERMISSION_READ_ACP<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"grants": [<br/>{<br/>"grant-type": "GRANT_TYPE_ACCOUNT\|GRANT_TYPE_ALL_AUTHENTICATED_USERS\|GRANT_TYPE_ALL_USERS",<br/>"grantee-id": "str",<br/>"permission": "PERMISSION_FULL_CONTROL\|PERMISSION_WRITE\|PERMISSION_WRITE_ACP\|PERMISSION_READ\|PERMISSION_READ_ACP"<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>grants -> ([]struct)<br/>List of permissions granted and the grantees.<br/>grant-type -> (enum<GRANT_TYPE_ACCOUNT\|GRANT_TYPE_ALL_AUTHENTICATED_USERS\|GRANT_TYPE_ALL_USERS>)<br/>The grantee type for the grant.<br/>grantee-id -> (string)<br/>ID of the account who is a grantee. Required when the [grant_type] is 'GRANT_TYPE_ACCOUNT'.<br/>permission -> (enum<PERMISSION_FULL_CONTROL\|PERMISSION_READ\|PERMISSION_READ_ACP\|PERMISSION_WRITE\|PERMISSION_WRITE_ACP>)<br/>Permission granted by the grant.|
|`--allowed-private-endpoints`|<b>`shorthand/json`</b><br/>Configuration for bucket's allowed private endpoints. requires permission s3:PutBucketAllowedPrivateEndpoints<br/>Shorthand Syntax:<br/>{<br/>enabled = bool,<br/>private-endpoints = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"enabled": "bool",<br/>"private-endpoints": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>enabled -> (bool)<br/>if true, private endpoints white list check is enabled even if private_endpoints list is empty<br/>private-endpoints -> ([]string)<br/>white list of private endpoints bucket accessible from|
|`--anonymous-access-flags`|<b>`shorthand/json`</b><br/>Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see documentation.<br/>Shorthand Syntax:<br/>{<br/>config-read = bool,<br/>list = bool,<br/>read = bool<br/>}<br/>JSON Syntax:<br/>"{<br/>"config-read": "bool",<br/>"list": "bool",<br/>"read": "bool"<br/>}"<br/>Fields:<br/>config-read -> (bool)<br/>Specifies whether public (anonymous) access to read documentation, documentation, and documentation settings of the bucket is enabled.<br/>list -> (bool)<br/>Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.<br/>read -> (bool)<br/>Specifies whether public (anonymous) access to read objects in the bucket is enabled.|
|`--default-storage-class`|<b>`string`</b><br/>Default storage class for objects in the bucket. Supported classes are standard storage ('STANDARD'), cold storage ('COLD', 'STANDARD_IA', 'NEARLINE' all synonyms), and ice storage ('ICE' and 'GLACIER' are synonyms). For details, see documentation.|
|`--disabled-statickey-auth`|An option to disable static key auth for a bucket. requires permission s3:UpdateBucketStaticKeyAuthSettings|
|`--encryption`|<b>`shorthand/json`</b><br/>Configuration for bucket's encryption. For details, see documentation.<br/>Shorthand Syntax:<br/>{<br/>rules = [<br/>{<br/>kms-master-key-id = str,<br/>sse-algorithm = str<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"rules": [<br/>{<br/>"kms-master-key-id": "str",<br/>"sse-algorithm": "str"<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>rules -> ([]struct)<br/>Rules<br/>kms-master-key-id -> (string)<br/>KMS master key ID<br/>sse-algorithm -> (string)<br/>SSE algorithm|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a bucket in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--max-size`|<b>`int`</b><br/>Maximum size of the bucket. For details, see documentation.|
|`--name`|<b>`string`</b><br/>Name of the bucket. The name must be unique within the platform. For naming limitations and rules, see documentation.|
|`--tags`|<b>`shorthand/json`</b><br/>List of tags for the bucket. For details, see documentation.<br/>Shorthand Syntax:<br/>[<br/>{<br/>key = str,<br/>value = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"key": "str",<br/>"value": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>key -> (string)<br/>Key of the bucket tag.<br/>value -> (string)<br/>Value of the bucket tag.|
|`--versioning`|<b>`enum`</b><br/>Bucket versioning status. For details, see documentation. Possible Values: 'versioning-disabled', 'versioning-enabled', 'versioning-suspended'|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
