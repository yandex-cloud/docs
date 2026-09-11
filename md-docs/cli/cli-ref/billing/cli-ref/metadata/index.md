[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [billing](../index.md) > metadata > Overview

# yc billing metadata

MetadataService service for retrieving metadata related to usage records
The MetadataService provides a set of methods for retrieving metadata and reference information
about billing usage records within a specific billing account and date range. This metadata
includes information about clouds, services, SKUs, labels, and resources
to understand the available entity structure before building detailed usage reports.
Required permissions:
All methods in this service require one of the following permissions on the specified billing account:
- `billing.accounts.getReport`
Rate limits:
This API is limited to 1 request per minute per IP address.

#### Command Usage

Syntax:

`yc billing metadata <command>`

#### Command Tree

- [yc billing metadata get-cloud](get-cloud.md) — GetCloud returns available folders for specified clouds within a billing account

- [yc billing metadata get-label](get-label.md) — GetLabel returns available label keys and values for a specific billing account

- [yc billing metadata get-resources](get-resources.md) — GetResources returns available resources for specified service instances within a billing account

- [yc billing metadata get-service-instance](get-service-instance.md) — GetServiceInstance returns service instance usage metadata for a specific billing account and date range.

- [yc billing metadata get-usage](get-usage.md) — GetUsage returns usage metadata including available clouds, services, SKUs, label keys, and date ranges

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