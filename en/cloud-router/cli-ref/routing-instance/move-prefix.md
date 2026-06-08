---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloudrouter/cli-ref/routing-instance/move-prefix
editable: false
---

# yc cloudrouter routing-instance move-prefix

Moves the specified prefix between availability zones of the RoutingInstance.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc cloudrouter routing-instance move-prefix <ROUTING-INSTANCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the RoutingInstance resource. ||
|| `--src-vpc-net-id` | `string`

ID of the source VpcNetwork. ||
|| `--src-zone` | `string`

ID of the AZ in the source VpcNetwork. ||
|| `--dst-vpc-net-id` | `string`

ID of the destination VpcNetwork. ||
|| `--dst-zone` | `string`

ID of the AZ in the destination VpcNetwork. ||
|| `--prefix` | `string`

Prefix to move. ||
|| `--name` | `string`

Resolve id by resource name within the current scope. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc cloudrouter routing-instance move-prefix --example-json > request.json
or
yc cloudrouter routing-instance move-prefix --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cloudrouter routing-instance move-prefix -r request.json
or
yc cloudrouter routing-instance move-prefix -r request.yaml ||
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

CLI syntax: this standalone binary only supports 2 (current). Use main yc for syntax 1. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
