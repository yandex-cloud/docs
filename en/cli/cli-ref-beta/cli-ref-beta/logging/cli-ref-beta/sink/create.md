---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/logging/cli-ref-beta/sink/create.md
---

# yc beta logging sink create

Creates a sink in the specified folder.

#### Command Usage

Syntax:

`yc beta logging sink create <FOLDER-ID>`

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

Description of the sink. ||
|| `--folder-id` | `string`

ID of the folder to create a sink in. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `stringToString`

Sink labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the sink. The name must be unique within the folder. ||
|| `--service-account-id` | `string`

Logs will be written to the sink on behalf of this service account ||
|| `--yds` | `shorthand/json`

Yandex data stream

Shorthand Syntax:

```hcl
{
  stream-name = str
}
```

JSON Syntax:

```json
{
  "stream-name": "str"
}
```

Fields:

```
stream-name -> (string)
  Fully qualified name of data stream
``` ||
|| `--s3` | `shorthand/json`

Object storage

Shorthand Syntax:

```hcl
{
  bucket = str,
  prefix = str
}
```

JSON Syntax:

```json
{
  "bucket": "str",
  "prefix": "str"
}
```

Fields:

```
bucket -> (string)
  Object storage bucket
prefix -> (string)
  Prefix to use for saved log object names
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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