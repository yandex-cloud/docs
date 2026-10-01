[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [billing](../index.md) > consumption-core > Overview

# yc billing consumption-core

Service for detailed consumption and usage reporting.
The ConsumptionCoreService provides a comprehensive set of methods for retrieving detailed
usage and billing information for different entities within a billing account hierarchy.
Each method offers aggregated data for specific entity types (a billing account, clouds,
folders, services, SKUs, resources, or labels) with support for various filtering options
and aggregation periods. Note that each request targets a single billing account.
All methods in this service follow the same three-level response structure:
1. Overall totals for the entire request period (cost, credits, expense)
2. Entity-level totals - summary data for each entity of the requested type
3. Time series data - periodic breakdown for each entity according to the specified aggregation period
(controlled by the aggregation_period request parameter: day/week/month/quarter/year)
These methods help customers and internal teams analyze usage patterns, track expenses,
monitor resource consumption, and generate detailed billing reports. The service
supports filtering by entity IDs, date ranges, labels, and other parameters to provide
targeted insights into cloud resource usage.
Required permissions:
All methods in this service require one of the following permissions on the specified billing account:
- `billing.accounts.getReport`

Rate limits:
This API is limited to 1 request per minute per IP address.

#### Command Usage

Syntax:

`yc billing consumption-core <command>`

#### Command Tree

- [yc billing consumption-core get-billing-account-usage-report](get-billing-account-usage-report.md) — Returns aggregated usage report for a single specified billing account,

- [yc billing consumption-core get-cloud-usage-report](get-cloud-usage-report.md) — Returns aggregated usage report for the specified clouds

- [yc billing consumption-core get-folder-usage-report](get-folder-usage-report.md) — Returns aggregated usage report for the specified folders

- [yc billing consumption-core get-label-key-usage-report](get-label-key-usage-report.md) — Returns aggregated usage report by label keys and values

- [yc billing consumption-core get-resource-usage-report](get-resource-usage-report.md) — Returns aggregated usage report by individual resource

- [yc billing consumption-core get-service-instance-usage-report](get-service-instance-usage-report.md) — Returns aggregated usage report for the specified service instances

- [yc billing consumption-core get-service-usage-report](get-service-usage-report.md) — Returns aggregated usage report for the specified services

- [yc billing consumption-core get-sku-usage-report](get-sku-usage-report.md) — Returns aggregated usage report by SKU (Stock Keeping Unit)

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