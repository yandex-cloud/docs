---
editable: false
noIndex: true
---

# yc beta compute host-group create

Creates a host group in the specified folder.

#### Command Usage

Syntax:

`yc beta compute host-group create <FOLDER-ID>`

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
|| `--description` | `string`

Description of the group. ||
|| `--folder-id` | `string`

ID of the folder to create a host group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--maintenance-policy` | `enum`

Behaviour on maintenance events. Possible Values: 'restart', 'migrate' ||
|| `--name` | `string`

Name of the group. ||
|| `--scale-policy` | `shorthand/json`

Scale policy. Only fixed number of hosts are supported at this moment.

Shorthand Syntax:

```hcl
{
  scale-type = fixed-scale={
    size = integer
  }
}
```

JSON Syntax:

```json
{
  "scale-type": {
    "fixed-scale": {
      "size": "integer"
    }
  }
}
```

Fields:

```
scale-type -> (oneof<fixed-scale>)
  Oneof scale-type field
  fixed-scale -> (struct)
    size -> (integer)
``` ||
|| `--type-id` | `string`

ID of host type. Resources provided by each host of the group. ||
|| `--zone-id` | `string`

Availability zone where all dedicated hosts will be allocated. ||
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