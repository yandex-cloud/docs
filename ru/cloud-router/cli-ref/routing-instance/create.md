---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloudrouter/cli-ref/routing-instance/create/
---

# yc cloudrouter routing-instance create

Creates a RoutingInstance resource in the specified folder using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc cloudrouter routing-instance create <ROUTING-INSTANCE-NAME>`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the RoutingInstance.
The name must be unique within the folder.
Value must match the regular expression ''\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?''. ||
|| `--description` | `string`

Optional description of the RoutingInstance. 0-256 characters long. ||
|| `--labels` | `map<string><string>`

Resource labels, 'key:value' pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression '[-_0-9a-z]*'.
The string length in characters for each key must be 1-63.
Each key must match the regular expression '[a-z][-_0-9a-z]*'. ||
|| `--cic-prc` | `[]string`

CIC private connection ids of the routing-instance. ||
|| `--vpc-net` | `[]string`

VPC network information.
Format: id=&lt;VPC-NETWORK-ID&gt;,zone=&lt;ZONE&gt;,ipv4-prefixes=[&lt;CIDR&gt;,...] ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc cloudrouter routing-instance create --example-json > request.json
or
yc cloudrouter routing-instance create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cloudrouter routing-instance create -r request.json
or
yc cloudrouter routing-instance create -r request.yaml ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#