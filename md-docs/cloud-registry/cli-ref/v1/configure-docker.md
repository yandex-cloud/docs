[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Справочник CLI (англ.)](../index.md) > [v1](index.md) > configure-docker

# yc cloud-registry v1 configure-docker

Configure the Docker credential helper for Cloud Registry.

#### Command Usage

Syntax:

`yc cloud-registry v1 configure-docker`

#### Flags

#|
||Flag | Description ||
|| `--hostname` | `[]string`

Non-default registry hostname that should use the Docker credential helper. ||
|| `--disable` | Disable credential helper. ||
|| `--skip-version-check` | Skip the check that the installed docker supports credential helpers. ||
|| `--profile` | `string`

Profile for the chosen hostnames. ||
|| `--docker-config-dir` | `string`

Path relative to the user's home directory where Docker config.json is located (default: .docker). ||
|#

#### Global Flags

#|
||Flag | Description ||
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