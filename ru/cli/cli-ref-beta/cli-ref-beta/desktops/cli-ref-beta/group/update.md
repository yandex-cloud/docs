---
editable: false
noIndex: true
---

# yc beta desktops group update

Updates desktop group properties

#### Command Usage

Syntax:

`yc beta desktops group update <DESKTOP-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--boot-disk-spec` | `shorthand/json`

Boot disk specification of the desktop group.

Shorthand Syntax:

```hcl
{
  size = integer,
  type = HDD|SSD
}
```

JSON Syntax:

```json
{
  "size": "integer",
  "type": "HDD|SSD"
}
```

Fields:

```
size -> (integer)
  Size of disk.
type -> (struct)
  Type of disk.
``` ||
|| `--data-disk-spec` | `shorthand/json`

Data disk specification of the desktop group.

Shorthand Syntax:

```hcl
{
  size = integer,
  type = HDD|SSD
}
```

JSON Syntax:

```json
{
  "size": "integer",
  "type": "HDD|SSD"
}
```

Fields:

```
size -> (integer)
  Size of disk.
type -> (struct)
  Type of disk.
``` ||
|| `--description` | `string`

 ||
|| `--desktop-group-id` | `string`

 ||
|| `--desktop-image-id` | `string`

 ||
|| `--group-config` | `shorthand/json`

Configuration of the desktop group.

Shorthand Syntax:

```hcl
{
  desktop-type = PERSISTENT|NON_PERSISTENT,
  max-desktops-amount = integer,
  members = [
    {
      id = string,
      type = string
    }, ...
  ],
  min-ready-desktops = integer
}
```

JSON Syntax:

```json
{
  "desktop-type": "PERSISTENT|NON_PERSISTENT",
  "max-desktops-amount": "integer",
  "members": [
    {
      "id": "string",
      "type": "string"
    }, ...
  ],
  "min-ready-desktops": "integer"
}
```

Fields:

```
desktop-type -> (struct)
  Type of the desktop.
max-desktops-amount -> (integer)
  Maximum number of desktops.
members -> ([]struct)
  List of members of the desktop group.
  id -> (string)
    ID of the subject. It can contain one of the following values: * 'allAuthenticatedUsers': A special public group that represents anyone who is authenticated. It can be used only if the [type] is 'system'. * 'allUsers': A special public group that represents anyone. No authentication is required. For example, you don't need to specify the IAM token in an API query. It can be used only if the [type] is 'system'. * 'group:organization:<id>:users': A special system group that represents all members of organization with given <id>. It can be used only if the [type] is 'system'. * 'group:federation:<id>:users': A special system group that represents all users of federation with given <id>. It can be used only if the [type] is 'system'. * '<cloud generated id>': An identifier that represents a user account. It can be used only if the [type] is 'userAccount', 'federatedUser' or 'serviceAccount'.
  type -> (string)
    Type of the subject. It can contain one of the following values: * 'userAccount': An account on Yandex or Yandex Connect, added to Yandex Cloud. * 'serviceAccount': A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount] resource. * 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory. * 'system': System group. This type represents several accounts with a common system identifier. For more information, see documentation.
min-ready-desktops -> (integer)
  Minimum number of ready desktops.
``` ||
|| `--labels` | `map<string><string>`

 ||
|| `--name` | `string`

 ||
|| `--resources-spec` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  core-fraction = integer,
  cores = integer,
  memory = integer
}
```

JSON Syntax:

```json
{
  "core-fraction": "integer",
  "cores": "integer",
  "memory": "integer"
}
```

Fields:

```
core-fraction -> (integer)
  Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.
cores -> (integer)
  Number of CPU cores.
memory -> (integer)
  RAM volume, in bytes.
``` ||
|| `--auto-update-policy` | `shorthand/json`

Shorthand Syntax:

```hcl
{}
```

JSON Syntax:

```json
{}
``` ||
|| `--manual-update-policy` | `shorthand/json`

Shorthand Syntax:

```hcl
{}
```

JSON Syntax:

```json
{}
``` ||
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