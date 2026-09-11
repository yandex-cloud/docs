[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [billing](../index.md) > v1 > Overview

# yc billing v1

Manage Billing resources

#### Command Usage

Syntax:

`yc billing v1 <group>`

#### Command Tree

- [yc billing v1 consumption-core](consumption-core/index.md) — Service for detailed consumption and usage reporting.

  - [yc billing v1 consumption-core get-billing-account-usage-report](consumption-core/get-billing-account-usage-report.md) — Returns aggregated usage report for a single specified billing account,

  - [yc billing v1 consumption-core get-cloud-usage-report](consumption-core/get-cloud-usage-report.md) — Returns aggregated usage report for the specified clouds

  - [yc billing v1 consumption-core get-folder-usage-report](consumption-core/get-folder-usage-report.md) — Returns aggregated usage report for the specified folders

  - [yc billing v1 consumption-core get-label-key-usage-report](consumption-core/get-label-key-usage-report.md) — Returns aggregated usage report by label keys and values

  - [yc billing v1 consumption-core get-resource-usage-report](consumption-core/get-resource-usage-report.md) — Returns aggregated usage report by individual resource

  - [yc billing v1 consumption-core get-service-instance-usage-report](consumption-core/get-service-instance-usage-report.md) — Returns aggregated usage report for the specified service instances

  - [yc billing v1 consumption-core get-service-usage-report](consumption-core/get-service-usage-report.md) — Returns aggregated usage report for the specified services

  - [yc billing v1 consumption-core get-sku-usage-report](consumption-core/get-sku-usage-report.md) — Returns aggregated usage report by SKU (Stock Keeping Unit)

- [yc billing v1 metadata](metadata/index.md) — MetadataService service for retrieving metadata related to usage records

  - [yc billing v1 metadata get-cloud](metadata/get-cloud.md) — GetCloud returns available folders for specified clouds within a billing account

  - [yc billing v1 metadata get-label](metadata/get-label.md) — GetLabel returns available label keys and values for a specific billing account

  - [yc billing v1 metadata get-resources](metadata/get-resources.md) — GetResources returns available resources for specified service instances within a billing account

  - [yc billing v1 metadata get-service-instance](metadata/get-service-instance.md) — GetServiceInstance returns service instance usage metadata for a specific billing account and date range.

  - [yc billing v1 metadata get-usage](metadata/get-usage.md) — GetUsage returns usage metadata including available clouds, services, SKUs, label keys, and date ranges

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