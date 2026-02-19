---
editable: false
noIndex: true
---

# yc beta storage bucket create

Creates a bucket in the specified folder.

#### Command Usage

Syntax:

`yc beta storage bucket create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--acl` | `shorthand/json`

Access control list (ACL) of the bucket. For details, see documentation.

Shorthand Syntax:

```hcl
{
  grants = [
    {
      grant-type = GRANT_TYPE_ACCOUNT|GRANT_TYPE_ALL_AUTHENTICATED_USERS|GRANT_TYPE_ALL_USERS,
      grantee-id = string,
      permission = PERMISSION_FULL_CONTROL|PERMISSION_WRITE|PERMISSION_WRITE_ACP|PERMISSION_READ|PERMISSION_READ_ACP
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "grants": [
    {
      "grant-type": "GRANT_TYPE_ACCOUNT|GRANT_TYPE_ALL_AUTHENTICATED_USERS|GRANT_TYPE_ALL_USERS",
      "grantee-id": "string",
      "permission": "PERMISSION_FULL_CONTROL|PERMISSION_WRITE|PERMISSION_WRITE_ACP|PERMISSION_READ|PERMISSION_READ_ACP"
    }, ...
  ]
}
```

Fields:

```
grants -> ([]struct)
  List of permissions granted and the grantees.
  grant-type -> (struct)
    The grantee type for the grant.
  grantee-id -> (string)
    ID of the account who is a grantee. Required when the [grant_type] is 'GRANT_TYPE_ACCOUNT'.
  permission -> (struct)
    Permission granted by the grant.
``` ||
|| `--allowed-private-endpoints` | `shorthand/json`

Configuration for bucket's allowed private endpoints. requires permission s3:PutBucketAllowedPrivateEndpoints

Shorthand Syntax:

```hcl
{
  enabled = boolean,
  force-cloud-console-access = boolean,
  private-endpoints = string,...
}
```

JSON Syntax:

```json
{
  "enabled": "boolean",
  "force-cloud-console-access": "boolean",
  "private-endpoints": [
    "string", ...
  ]
}
```

Fields:

```
enabled -> (boolean)
  if true, private endpoints white list check is enabled even if private_endpoints list is empty
force-cloud-console-access -> (boolean)
  if true, cloud console will be able to access a bucket regardless of private_endpoints list
private-endpoints -> ([]string)
  white list of private endpoints bucket accessible from
``` ||
|| `--anonymous-access-flags` | `shorthand/json`

Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see documentation.

Shorthand Syntax:

```hcl
{
  config-read = boolean,
  list = boolean,
  read = boolean
}
```

JSON Syntax:

```json
{
  "config-read": "boolean",
  "list": "boolean",
  "read": "boolean"
}
```

Fields:

```
config-read -> (boolean)
  Specifies whether public (anonymous) access to read documentation, documentation, and documentation settings of the bucket is enabled.
list -> (boolean)
  Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.
read -> (boolean)
  Specifies whether public (anonymous) access to read objects in the bucket is enabled.
``` ||
|| `--default-storage-class` | `string`

Default storage class for objects in the bucket. Supported classes are standard storage ('STANDARD'), cold storage ('COLD', 'STANDARD_IA', 'NEARLINE' all synonyms), and ice storage ('ICE' and 'GLACIER' are synonyms). For details, see documentation. ||
|| `--disabled-statickey-auth` | An option to disable static key auth for a bucket. requires permission s3:UpdateBucketStaticKeyAuthSettings ||
|| `--encryption` | `shorthand/json`

Configuration for bucket's encryption. For details, see documentation.

Shorthand Syntax:

```hcl
{
  rules = [
    {
      kms-master-key-id = string,
      sse-algorithm = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "rules": [
    {
      "kms-master-key-id": "string",
      "sse-algorithm": "string"
    }, ...
  ]
}
```

Fields:

```
rules -> ([]struct)
  Rules
  kms-master-key-id -> (string)
    KMS master key ID
  sse-algorithm -> (string)
    SSE algorithm
``` ||
|| `--folder-id` | `string`

ID of the folder to create a bucket in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--max-size` | `int`

Maximum size of the bucket. For details, see documentation. ||
|| `--name` | `string`

Name of the bucket. The name must be unique within the platform. For naming limitations and rules, see documentation. ||
|| `--tags` | `shorthand/json`

List of tags for the bucket. For details, see documentation.

Shorthand Syntax:

```hcl
[
  {
    key = string,
    value = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "key": "string",
    "value": "string"
  }, ...
]
```

Fields:

```
key -> (string)
  Key of the bucket tag.
value -> (string)
  Value of the bucket tag.
``` ||
|| `--versioning` | `enum`

Bucket versioning status. For details, see documentation. Possible Values: 'versioning-disabled', 'versioning-enabled', 'versioning-suspended' ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

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