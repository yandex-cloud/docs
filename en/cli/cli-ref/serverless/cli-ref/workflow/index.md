---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/workflow/
---

# yc serverless workflow

Manage workflows

#### Command Usage

Syntax:

`yc serverless workflow <group|command>`

Aliases:

- `wf`

#### Command Tree

- [yc serverless workflow add-access-binding](add-access-binding.md) — Add access binding for the specified Workflow

- [yc serverless workflow allow-unauthenticated-execution](allow-unauthenticated-execution.md) — Allow unauthenticated execution for the specified Workflow

- [yc serverless workflow create](create.md) — Create Workflow

- [yc serverless workflow delete](delete.md) — Delete Workflow

- [yc serverless workflow deny-unauthenticated-execution](deny-unauthenticated-execution.md) — Deny unauthenticated execution for the specified Workflow

- [yc serverless workflow get](get.md) — Get Workflow

- [yc serverless workflow list](list.md) — List Workflows

- [yc serverless workflow list-access-bindings](list-access-bindings.md) — List access bindings for the specified Workflow

- [yc serverless workflow list-operations](list-operations.md) — List Workflow operations

- [yc serverless workflow remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Workflow

- [yc serverless workflow set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Workflow and delete all existing access bindings if there were any

- [yc serverless workflow update](update.md) — Update Workflow

- [yc serverless workflow execution](execution/index.md) — Manage execution

  - [yc serverless workflow execution get](execution/get.md) — Get Execution

  - [yc serverless workflow execution get-history](execution/get-history.md) — Get Execution history

  - [yc serverless workflow execution list](execution/list.md) — List Execution

  - [yc serverless workflow execution start](execution/start.md) — Start Execution

  - [yc serverless workflow execution stop](execution/stop.md) — Stop Execution

  - [yc serverless workflow execution terminate](execution/terminate.md) — Terminate Execution

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