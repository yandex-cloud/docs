---
editable: false
noIndex: true
---

# yc beta iot device update

Updates the specified device.

#### Command Usage

Syntax:

`yc beta iot device update <DEVICE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the device. ||
|| `--device-id` | `string`

ID of the device to update. To get a device ID make a [DeviceService.List] request. ||
|| `--labels` | `stringToString`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the device. The name must be unique within the registry. ||
|| `--topic-aliases` | `stringToString`

Alias of a device topic. Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. 'my/custom/alias' match to '$device/{id}/events'. ||
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