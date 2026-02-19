---
editable: false
noIndex: true
---

# yc beta iam service-control get

Returns the Service information in the specified resource container.
To get the list of available Services, make a [List] request.

#### Command Usage

Syntax:

`yc beta iam service-control get <SERVICE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--resource` | `shorthand/json`

Resource container to get a service information in. It is supported only resource-manager.cloud resource container now.

Shorthand Syntax:

```hcl
{
  id = string,
  type = string
}
```

JSON Syntax:

```json
{
  "id": "string",
  "type": "string"
}
```

Fields:

```
id -> (string)
  ID of the resource.
type -> (string)
  The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.
``` ||
|| `--service-id` | `string`

ID of the Service. ||
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