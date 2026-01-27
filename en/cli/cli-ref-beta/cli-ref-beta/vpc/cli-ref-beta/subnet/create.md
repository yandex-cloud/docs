---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/subnet/create.md
---

# yc beta vpc subnet create

Creates a subnet in the specified folder and network.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta vpc subnet create <FOLDER-ID>`

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

Description of the subnet. ||
|| `--dhcp-options` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  domain-name = str,
  domain-name-servers = str,...,
  ntp-servers = str,...
}
```

JSON Syntax:

```json
{
  "domain-name": "str",
  "domain-name-servers": [
    "str", ...
  ],
  "ntp-servers": [
    "str", ...
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
|| `--folder-id` | `string`

ID of the folder to create a subnet in. To get folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `stringToString`

Resource labels, '' key:value '' pairs. ||
|| `--name` | `string`

Name of the subnet. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create subnet in. ||
|| `--route-table-id` | `string`

ID of route table the subnet is linked to. ||
|| `--v4-cidr-blocks` | `strings`

CIDR block. The range of internal addresses that are defined for this subnet. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16. ||
|| `--zone-id` | `string`

ID of the availability zone where the subnet resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request. ||
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