---
editable: false
noIndex: true
---

# yc beta vpc subnet update

Updates the specified subnet.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta vpc subnet update <SUBNET-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the subnet. ||
|| `--dhcp-options` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  domain-name = string,
  domain-name-servers = string,...,
  ntp-servers = string,...
}
```

JSON Syntax:

```json
{
  "domain-name": "string",
  "domain-name-servers": [
    "string", ...
  ],
  "ntp-servers": [
    "string", ...
  ]
}
```

Fields:

```
domain-name -> (string)
  A domain name to us as a suffix when resolving host names in this subnet.
domain-name-servers -> ([]string)
  A list of DHCP servers for this subnet.
ntp-servers -> ([]string)
  List of NTP servers for this subnet.
``` ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs. ||
|| `--name` | `string`

Name of the subnet. The name must be unique within the folder. ||
|| `--route-table-id` | `string`

ID of route table the subnet is linked to. ||
|| `--subnet-id` | `string`

ID of the Subnet resource to update. ||
|| `--v4-cidr-blocks` | `[]string`

New CIDR blocks which will overwrite the existing ones. ||
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