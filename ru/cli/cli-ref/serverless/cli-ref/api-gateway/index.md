---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/api-gateway/
---

# yc serverless api-gateway

Manage API Gateways

#### Command Usage

Syntax:

`yc serverless api-gateway <group|command>`

Aliases:

- `gateway`

- `api-gw`

- `gw`

#### Command Tree

- [yc serverless api-gateway add-access-binding](add-access-binding.md) — Add access binding for the specified API Gateway

- [yc serverless api-gateway add-domain](add-domain.md) — Attach domain to the specified API Gateway

- [yc serverless api-gateway create](create.md) — Create API Gateway

- [yc serverless api-gateway delete](delete.md) — Delete API Gateway

- [yc serverless api-gateway get](get.md) — Get API Gateway

- [yc serverless api-gateway get-spec](get-spec.md) — Get API Gateway openapi specification

- [yc serverless api-gateway list](list.md) — List API Gateways

- [yc serverless api-gateway list-access-bindings](list-access-bindings.md) — List API Gateway access bindings

- [yc serverless api-gateway list-operations](list-operations.md) — List API Gateway operations

- [yc serverless api-gateway release-canary](release-canary.md) — Set gateway specification variables to canary values and delete canary settings

- [yc serverless api-gateway remove-access-binding](remove-access-binding.md) — Remove access binding for the specified API Gateway

- [yc serverless api-gateway remove-domain](remove-domain.md) — Detach domain from the specified API Gateway

- [yc serverless api-gateway resume](resume.md) — Resume API Gateway

- [yc serverless api-gateway rollback-canary](rollback-canary.md) — Suspend sending requests to canary release(set canary weight to zero)

- [yc serverless api-gateway set-access-bindings](set-access-bindings.md) — Set access bindings for the specified API Gateway and delete all existing access bindings if there were any

- [yc serverless api-gateway stop](stop.md) — Stop API Gateway

- [yc serverless api-gateway update](update.md) — Update API Gateway

- [yc serverless api-gateway websocket](websocket/index.md) — Manage websocket connections

  - [yc serverless api-gateway websocket disconnect](websocket/disconnect.md) — Close connection

  - [yc serverless api-gateway websocket get](websocket/get.md) — Get connection

  - [yc serverless api-gateway websocket send](websocket/send.md) — Send data to connection

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