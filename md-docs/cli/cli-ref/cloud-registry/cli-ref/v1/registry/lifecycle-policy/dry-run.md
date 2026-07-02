[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник CLI (англ.)](../../../../../index.md) > [cloud-registry](../../../index.md) > [v1](../../index.md) > [registry](../index.md) > [lifecycle-policy](index.md) > dry-run

# yc cloud-registry v1 registry lifecycle-policy dry-run

Creates a request of a dry run of the lifecycle policy.

#### Command Usage

Syntax:

`yc cloud-registry v1 registry lifecycle-policy dry-run <POLICY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the lifecycle policy. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc cloud-registry v1 registry lifecycle-policy dry-run --example-json > request.json
or
yc cloud-registry v1 registry lifecycle-policy dry-run --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cloud-registry v1 registry lifecycle-policy dry-run -r request.json
or
yc cloud-registry v1 registry lifecycle-policy dry-run -r request.yaml ||
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