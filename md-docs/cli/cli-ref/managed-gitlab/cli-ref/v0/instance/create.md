[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [managed-gitlab](../../index.md) > [v0](../index.md) > [instance](index.md) > create

# yc managed-gitlab v0 instance create

Create Gitlab instance

#### Command Usage

Syntax:

`yc managed-gitlab v0 instance create <INSTANCE-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the Gitlab instance. ||
|| `--description` | `string`

Description of the instance. ||
|| `--labels` | `key=value[,key=value...]`

A list of Gitlab instance labels as key-value pairs. ||
|| `--resource-preset-id` | `string`

ID of the preset for computational resources available to the instance (CPU, memory etc.). One of: s2.micro, s2.small, s2.medium, s2.large. ||
|| `--disk-size` | `byteSize`

Amount of disk storage available to a instance in GB. ||
|| `--backup-retain-period-days` | `int`

Auto backups retain period in days. ||
|| `--maintenance-delete-untagged` | Delete untagged images during maintenance. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the instance. ||
|| `--approval-rules` | `string`

Approval rules configuration. One of: BASIC, STANDARD, ADVANCED. ||
|| `--admin-login` | `string`

A login of admin user in Gitlab. ||
|| `--admin-email` | `string`

A email of admin user in Gitlab. ||
|| `--domain-prefix` | `string`

Domain prefix for Gitlab instance. ||
|| `--subnet-id` | `string`

ID of the subnet that Gitlab instance should be created in. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
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