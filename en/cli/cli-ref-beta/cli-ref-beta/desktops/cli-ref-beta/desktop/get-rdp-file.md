---
editable: false
noIndex: true
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
  subject-id = string,
  subject-type = string
}
```

JSON Syntax:

```json
{
  "subject-id": "string",
  "subject-type": "string"
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