---
editable: false
noIndex: true
---

# yc beta serverless workflow update

Updates specified Workflow.

#### Command Usage

Syntax:

`yc beta serverless workflow update <WORKFLOW-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the Workflow. ||
|| `--express` | Express execution mode. ||
|| `--is-public` | Ability of the Workflow to be executed without authentication. ||
|| `--labels` | `map<string><string>`

Workflow labels as 'key:value' pairs. ||
|| `--log-options` | `shorthand/json`

Options for logging from the Workflow.

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string,
  disabled = boolean,
  min-level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "disabled": "boolean",
  "min-level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL"
}
```

Fields:

```
disabled -> (boolean)
  Is logging from Workflow disabled.
min-level -> (struct)
  Minimum logs level. See [LogLevel.Level] for details.
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  log-group-id -> (string)
    ID of the logging group which should be used for Workflows logs.
  folder-id -> (string)
    ID of the folder which default logging group should be used for Workflows.
``` ||
|| `--name` | `string`

Name of the Workflow. The name is unique within the folder. ||
|| `--network-id` | `string`

ID of the VPC network Workflow will be executed in, in order to access private resources. ||
|| `--schedule` | `shorthand/json`

Workflow schedule settings.

Shorthand Syntax:

```hcl
{
  cron-expression = string,
  timezone = string
}
```

JSON Syntax:

```json
{
  "cron-expression": "string",
  "timezone": "string"
}
```

Fields:

```
cron-expression -> (string)
  Cron expression for the Workflow schedule.
timezone -> (string)
  Timezone for the Workflow schedule.
``` ||
|| `--service-account-id` | `string`

ID of the Service Account which will be used for resources access in Workflow execution. ||
|| `--specification` | `shorthand/json`

Specification of the Workflow.

Shorthand Syntax:

```hcl
{
  spec = spec-yaml=string
}
```

JSON Syntax:

```json
{
  "spec": {
    "spec-yaml": "string"
  }
}
```

Fields:

```
spec -> (oneof<spec-yaml>)
  Oneof spec field
  spec-yaml -> (string)
    Workflow specification in YAML format.
``` ||
|| `--workflow-id` | `string`

ID of the Workflow. ||
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