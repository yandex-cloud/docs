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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--acl`|<b>`shorthand/json`</b><br/>Access control list (ACL) of the bucket.<br/>For details, see [documentation](https://yandex.cloud/ru/docs/storage/concepts/acl).<br/><br/>Example:|
|`--acl`|<b>`grants=[{grant-type=GRANT_TYPE_ACCOUNT,`</b><br/>grantee-id=value, permission=PERMISSION_FULL_CONTROL}]<br/><br/>Shorthand Syntax:<br/>{grants=[{grant-type=GRANT_TYPE_ACCOUNT\|GRANT_TYPE_ALL_AUTHENTICATED_USERS\|GRANT_TYPE_ALL_USERS, grantee-id=str, permission=PERMISSION_FULL_CONTROL\|PERMISSION_WRITE\|PERMISSION_WRITE_ACP\|PERMISSION_READ\|PERMISSION_READ_ACP},...]}<br/>Fields:<br/>grants  []struct  — List of permissions granted and the grantees.<br/>grant-type  enum<GRANT_TYPE_ACCOUNT\|GRANT_TYPE_ALL_AUTHENTICATED_USERS\|GRANT_TYPE_ALL_USERS>                         required  — The grantee type for the grant.<br/>grantee-id  string                                                                                                             — ID of the account who is a grantee. Required when the [grant_type] is 'GRANT_TYPE_ACCOUNT'.<br/>permission  enum<PERMISSION_FULL_CONTROL\|PERMISSION_READ\|PERMISSION_READ_ACP\|PERMISSION_WRITE\|PERMISSION_WRITE_ACP>  required  — Permission granted by the grant.<br/>|
|`--allowed-private-endpoints`|<b>`shorthand/json`</b><br/>Configuration for bucket's allowed private endpoints.<br/>requires permission s3:PutBucketAllowedPrivateEndpoints<br/><br/>Example:|
|`--allowed-private-endpoints`|<b>`enabled=true,`</b><br/>private-endpoints=value<br/><br/>Shorthand Syntax:<br/>{enabled=bool, private-endpoints=str,...}<br/>Fields:<br/>enabled            bool      — if true, private endpoints white list check is enabled<br/>even if private_endpoints list is empty<br/>private-endpoints  []string  — white list of private endpoints bucket accessible from<br/>|
|`--anonymous-access-flags`|<b>`shorthand/json`</b><br/>Flags for configuring public (anonymous) access to the bucket's content and settings.<br/>For details, see [documentation](https://yandex.cloud/ru/docs/storage/concepts/bucket#bucket-access).<br/><br/>Example:|
|`--anonymous-access-flags`|<b>`config-read=true,`</b><br/>list=true, read=true<br/><br/>Shorthand Syntax:<br/>{config-read=bool, list=bool, read=bool}<br/>Fields:<br/>config-read  bool  — Specifies whether public (anonymous) access to read [CORS](https://yandex.cloud/ru/docs/storage/concepts/cors),<br/>[static website hosting](https://yandex.cloud/ru/docs/storage/concepts/hosting), and<br/>[object lifecycles](https://yandex.cloud/ru/docs/storage/concepts/lifecycles) settings of the bucket is enabled.<br/>list         bool  — Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.<br/>read         bool  — Specifies whether public (anonymous) access to read objects in the bucket is enabled.<br/>|
|`--default-storage-class`|<b>`string`</b><br/>Default storage class for objects in the bucket. Supported classes are standard storage ('STANDARD'), cold storage<br/>('COLD', 'STANDARD_IA', 'NEARLINE' all synonyms), and ice storage ('ICE' and 'GLACIER' are synonyms).<br/>For details, see [documentation](https://yandex.cloud/ru/docs/storage/concepts/storage-class).|
|`--disabled-statickey-auth`|An option to disable static key auth for a bucket.<br/>requires permission s3:UpdateBucketStaticKeyAuthSettings|
|`--encryption`|<b>`shorthand/json`</b><br/>Configuration for bucket's encryption.<br/>For details, see [documentation](https://yandex.cloud/ru/docs/storage/concepts/encryption).<br/><br/>Example:|
|`--encryption`|<b>`rules=[{kms-master-key-id=value,`</b><br/>sse-algorithm=value}]<br/><br/>Shorthand Syntax:<br/>{rules=[{kms-master-key-id=str, sse-algorithm=str},...]}<br/>Fields:<br/>rules  []struct  — Rules<br/>kms-master-key-id  string  — KMS master key ID<br/>sse-algorithm      string  — SSE algorithm<br/>|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a bucket in.<br/><br/>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--max-size`|<b>`int`</b><br/>Maximum size of the bucket.<br/>For details, see [documentation](https://yandex.cloud/ru/docs/storage/operations/buckets/limit-max-volume).|
|`--name`|<b>`string`</b><br/>Name of the bucket.<br/><br/>The name must be unique within the platform. For naming limitations and rules, see<br/>[documentation](https://yandex.cloud/ru/docs/storage/concepts/bucket#naming).|
|`--tags`|<b>`shorthand/json`</b><br/>List of tags for the bucket.<br/>For details, see [documentation](https://yandex.cloud/ru/docs/resource-manager/concepts/labels).<br/><br/>Example:|
|`--tags`|<b>`[{key=value,`</b><br/>value=value}]<br/><br/>Shorthand Syntax:<br/>[{key=str, value=str},...]<br/>Fields:<br/>key    string  — Key of the bucket tag.<br/>value  string  — Value of the bucket tag.<br/>|
|`--versioning`|<b>`enum`</b><br/>Bucket versioning status.<br/>For details, see [documentation](https://yandex.cloud/ru/docs/storage/concepts/versioning). Possible Values: 'versioning-disabled', 'versioning-enabled', 'versioning-suspended'|
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
