---
editable: false
noIndex: true
---

# yc beta quota-manager quota-limit list

Retrieves the list of quota limits for a given service.

#### Command Usage

Syntax:

`yc beta quota-manager quota-limit list`

#### Flags

#|
||Flag | Description ||
|| `--page-size` | `int`

The maximum number of quota limits to return per response. ||
|| `--page-token` | `string`

Token to retrieve the next page of results. Omitted on the first request. ||
|| `--resource` | `shorthand/json`

The resource for which quota limits are being listed.

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
  The id if the resource.
type -> (string)
  The type of the resource, e.g. resource-manager.cloud, billing.account.
``` ||
|| `--service` | `string`

The service for which quota limits are being requested. ||
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