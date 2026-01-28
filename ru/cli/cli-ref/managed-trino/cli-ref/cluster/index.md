---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-trino/cli-ref/cluster/index.md
---

# yc managed-trino cluster

Manage Trino clusters

#### Command Usage

Syntax:

`yc managed-trino cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-trino cluster add-access-binding](add-access-binding.md) — Add access binding for the specified Trino cluster

- [yc managed-trino cluster create](create.md) — Create Trino cluster

- [yc managed-trino cluster delete](delete.md) — Delete the specified Trino cluster

- [yc managed-trino cluster get](get.md) — Show information about the specified Trino cluster

- [yc managed-trino cluster get-access-control](get-access-control.md) — Get Trino cluster access control configuration

- [yc managed-trino cluster get-resource-groups](get-resource-groups.md) — Get Trino cluster resource groups configuration

- [yc managed-trino cluster list](list.md) — List Trino clusters

- [yc managed-trino cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified Trino cluster

- [yc managed-trino cluster list-operations](list-operations.md) — List operations for the specified Trino cluster

- [yc managed-trino cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Trino cluster

- [yc managed-trino cluster remove-access-control](remove-access-control.md) — Remove access control from Trino cluster configuration

- [yc managed-trino cluster remove-resource-groups](remove-resource-groups.md) — Remove resource groups from Trino cluster configuration

- [yc managed-trino cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Trino cluster and delete all existing access bindings if there were any

- [yc managed-trino cluster set-access-control](set-access-control.md) — Set Trino cluster access control configuration

- [yc managed-trino cluster set-resource-groups](set-resource-groups.md) — Set Trino cluster resource groups configuration from YAML file

- [yc managed-trino cluster start](start.md) — Start the specified Trino cluster

- [yc managed-trino cluster stop](stop.md) — Stop the specified Trino cluster

- [yc managed-trino cluster update](update.md) — Update the specified Trino cluster

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