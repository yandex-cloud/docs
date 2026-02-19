---
editable: false
noIndex: true
---

# yc beta serverless api-gateway

A set of methods for managing API gateways.

#### Command Usage

Syntax:

`yc beta serverless api-gateway <command>`

#### Command Tree

- [yc beta serverless api-gateway add-domain](add-domain.md) — Attaches domain to the specified API gateway.

- [yc beta serverless api-gateway create](create.md) — Creates an API gateway in the specified folder.

- [yc beta serverless api-gateway delete](delete.md) — Deletes the specified API gateway.

- [yc beta serverless api-gateway get](get.md) — Returns the specified API gateway. Note that only API gateway basic attributes are returned.

- [yc beta serverless api-gateway get-openapi-spec](get-openapi-spec.md) — Returns the OpenAPI specification of specified API gateway.

- [yc beta serverless api-gateway list](list.md) — Retrieves the list of API gateways in the specified folder.

- [yc beta serverless api-gateway list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified API gateway.

- [yc beta serverless api-gateway list-operations](list-operations.md) — Lists operations for the specified API gateway.

- [yc beta serverless api-gateway remove-domain](remove-domain.md) — Detaches domain from the specified API gateway.

- [yc beta serverless api-gateway resume](resume.md) — Resumes the specified API gateway.

- [yc beta serverless api-gateway set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified API gateway.

- [yc beta serverless api-gateway stop](stop.md) — Stops the specified API gateway.

- [yc beta serverless api-gateway update](update.md) — Updates the specified API gateway.

- [yc beta serverless api-gateway update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified API gateway.

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
|| `-h`, `--help` | Display help for the command. ||
|#