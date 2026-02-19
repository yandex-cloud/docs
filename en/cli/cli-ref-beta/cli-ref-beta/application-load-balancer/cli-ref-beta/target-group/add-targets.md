---
editable: false
noIndex: true
---

# yc beta application-load-balancer target-group add-targets

Adds targets to the specified target group.

#### Command Usage

Syntax:

`yc beta application-load-balancer target-group add-targets <TARGET-GROUP-ID>`

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
|| `--target-group-id` | `string`

ID of the target group to add targets to. To get the target group ID, make a [TargetGroupService.List] request. ||
|| `--targets` | `shorthand/json`

List of targets to add to the target group.

Shorthand Syntax:

```hcl
[
  {
    address-type = ip-address=string,
    private-ipv4-address = boolean,
    subnet-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "address-type": {
      "ip-address": "string"
    },
    "private-ipv4-address": "boolean",
    "subnet-id": "string"
  }, ...
]
```

Fields:

```
private-ipv4-address -> (boolean)
  If set, will not require 'subnet_id' to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of 'subnet_id' or 'private_ipv4_address' should be set.
subnet-id -> (string)
  ID of the subnet that the target is connected to.
address-type -> (oneof<ip-address>)
  Oneof address-type field
  ip-address -> (string)
    IP address of the target.
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