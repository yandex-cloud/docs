[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник (англ.)](../../../../../index.md) > [cloud-registry](../../../index.md) > [v0](../../index.md) > [artifact](../index.md) > [scanner](index.md) > list-scan-results

# yc cloud-registry v0 artifact scanner list-scan-results

List scan results for an artifact.

#### Command Usage

Syntax:

`yc cloud-registry artifact scanner list-scan-results [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--artifact-id` | `string`

ID of the artifact to list scan results for. ||
|| `--filter` | `string`

Path to a JSON file with the filter, e.g. filter.json. ||
|| `--order-by` | `string`

Order expression for the list, e.g. "status asc". ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
|| `--page-token` | `string`

Page token pagination simplifies navigating large datasets by using a token to represent the current page. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#