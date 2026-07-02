[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Registry](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v1](../index.md) > [registry](index.md) > remove-access-binding

# yc cloud-registry v1 registry remove-access-binding

Remove access binding for the specified registry.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry remove-access-binding <REGISTRY-NAME>|<REGISTRY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--role` | `string`

Binding role ID. ||
|| `--service-account-id` | `string`

Service account ID whose access will be updated. ||
|| `--service-account-name` | `string`

Service account name whose access will be updated. ||
|| `--user-account-id` | `string`

User account ID whose access will be updated. ||
|| `--user-yandex-login` | `string`

Yandex Passport login whose access will be updated. ||
|| `--agent` | `string`

Agent service account in SERVICE_ID:MICROSERVICE_ID format whose access will be updated. ||
|| `--all-authenticated-users` | Update access for all authenticated users. ||
|| `--group-members` | `string`

Update access for members of the group with the specified ID. ||
|| `--organization-users` | `string`

Update access for users of the organization with the specified ID. ||
|| `--federation-users` | `string`

Update access for users of the federation with the specified ID. ||
|| `--subject` | `string`

Subject whose access will be updated; in TYPE:ID format, e.g. userAccount:&lt;ID&gt;, serviceAccount:&lt;ID&gt;, system:&lt;ID&gt;. ||
|| `--id` | `string`

ID of the registry. ||
|| `--name` | `string`

Name of the registry (resolved within the current folder). ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc cloud-registry v1 registry remove-access-binding --example-json > request.json
or
yc cloud-registry v1 registry remove-access-binding --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cloud-registry v1 registry remove-access-binding -r request.json
or
yc cloud-registry v1 registry remove-access-binding -r request.yaml ||
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