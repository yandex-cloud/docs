---
editable: false
noIndex: true
---

# yc beta dns zone create

Creates a DNS zone in the specified folder.

#### Command Usage

Syntax:

`yc beta dns zone create <FOLDER-ID>`

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
|| `--deletion-protection` | Prevents accidental zone removal. ||
|| `--description` | `string`

Description of the DNS zone. ||
|| `--folder-id` | `string`

ID of the folder to create DNS zones in. To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `map<string><string>`

DNS zone labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the DNS zone. The name must be unique within the folder. ||
|| `--private-visibility` | `shorthand/json`

Privately visible zone settings. At least one of two visibility fields must be set.

Shorthand Syntax:

```hcl
{
  network-ids = string,...
}
```

JSON Syntax:

```json
{
  "network-ids": [
    "string", ...
  ]
}
```

Fields:

```
network-ids -> ([]string)
  Network IDs.
``` ||
|| `--public-visibility` | `shorthand/json`

Publicly visible zone settings. At least one of two visibility fields must be set.

Shorthand Syntax:

```hcl
{}
```

JSON Syntax:

```json
{}
``` ||
|| `--zone` | `string`

DNS zone suffix. ||
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