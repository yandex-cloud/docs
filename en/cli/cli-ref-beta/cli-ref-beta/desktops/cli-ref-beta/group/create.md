---
editable: false
noIndex: true
---

# yc beta desktops group create

Creates desktop group in the specified folder.

#### Command Usage

Syntax:

`yc beta desktops group create <DESKTOP-IMAGE-ID>`

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

Description of the DesktopGroup. ||
|| `--desktop-image-id` | `string`

An image used to create a desktop boot disk ||
|| `--folder-id` | `string`

ID of the folder to create a DesktopGroup in. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
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
|| `--name` | `string`

Name of the DesktopGroup. The name must be unique within the folder. ||
|| `--network-interface-spec` | `shorthand/json`

Network interface specification of the desktop group.

Shorthand Syntax:

```hcl
{
  network-id = string,
  subnet-ids = string,...
}
```

JSON Syntax:

```json
{
  "network-id": "string",
  "subnet-ids": [
    "string", ...
  ]
}
```

Fields:

```
network-id -> (string)
  ID of the network interface specification.
subnet-ids -> ([]string)
  List of subnet IDs.
``` ||
|| `--resources-spec` | `shorthand/json`

Resource specification of the desktop group.

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