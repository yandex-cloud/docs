# yc serverless workflow list

List Workflows

#### Command Usage

Syntax:

`yc serverless workflow list [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--limit` | `int`

The maximum number of items to list. Default is 1000 items ||
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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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
#### Examples

 * [Получить детальную информацию о выполнении каждого шага рабочего процесса](../../../../../serverless-integrations/operations/workflows/execution/get-history.md#cli_1)
 * [Получить информацию о запуске рабочего процесса](../../../../../serverless-integrations/operations/workflows/execution/get-info.md#cli_1)
 * [Получить список запусков рабочего процесса](../../../../../serverless-integrations/operations/workflows/execution/get-list.md#cli_1)
 * [Задать расписание](../../../../../serverless-integrations/operations/workflows/execution/start-by-timer.md#cli_1)
 * [Запустить рабочий процесс](../../../../../serverless-integrations/operations/workflows/execution/start.md#cli_1)
 * [Удалить рабочий процесс](../../../../../serverless-integrations/operations/workflows/workflow/delete.md#cli_1)
 * [Получить информацию о рабочем процессе](../../../../../serverless-integrations/operations/workflows/workflow/get-info.md#cli_1)
 * [Получить список рабочих процессов](../../../../../serverless-integrations/operations/workflows/workflow/get-list.md#cli_1)
 * [Сделать рабочий процесс приватным](../../../../../serverless-integrations/operations/workflows/workflow/make-private.md#cli_1)
 * [Сделать рабочий процесс публичным](../../../../../serverless-integrations/operations/workflows/workflow/make-public.md#cli_1)
 * [Изменить рабочий процесс](../../../../../serverless-integrations/operations/workflows/workflow/update.md#cli_1)