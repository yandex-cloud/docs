---
editable: false
noIndex: true
---

# yc beta dns zone update

Updates the specified DNS zone.

#### Command Usage

Syntax:

`yc beta dns zone update <DNS-ZONE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--deletion-protection` | Prevents accidental zone removal. ||
|| `--description` | `string`

New description of the DNS zone. ||
|| `--dns-zone-id` | `string`

ID of the DNS zone to update. To get the DNS zone ID, make a [DnsZoneService.List] request. ||
|| `--labels` | `map<string><string>`

DNS zone labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [DnsZoneService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--name` | `string`

New name for the DNS zone. The name must be unique within the folder. ||
|| `--private-visibility` | `shorthand/json`

Change network IDs for private visibility.

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

Public visibility configuration.

Shorthand Syntax:

```hcl
{}
```

JSON Syntax:

```json
{}
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