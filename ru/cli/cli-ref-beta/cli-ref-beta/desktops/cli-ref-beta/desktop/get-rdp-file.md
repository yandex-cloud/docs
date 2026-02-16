---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/desktops/cli-ref-beta/desktop/get-rdp-file.md
---

# yc beta desktops desktop get-rdp-file

Returns a RDP file for the specified desktop.

#### Command Usage

Syntax:

`yc beta desktops desktop get-rdp-file <DESKTOP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--desktop-id` | `string`

ID of the desktop resource to return. To get the desktop ID use a [DesktopService.List] request. ||
|| `--user` | `shorthand/json`

User of the desktop.

Shorthand Syntax:

```hcl
{
  subject-id = str,
  subject-type = str
}
```

JSON Syntax:

```json
{
  "subject-id": "str",
  "subject-type": "str"
}
```

Fields:

```
subject-id -> (string)
  Identity of the access binding.
subject-type -> (string)
  Type of the access binding, e.g. userAccount, serviceAccount, system.
``` ||
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