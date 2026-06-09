# yc dns v0 inbound-endpoint

Manage dns inbound endpoints

#### Command Usage

Syntax:

`yc dns inbound-endpoint <command>`

Aliases:

- `inbound-endpoints`

#### Command Tree

- [yc dns v0 inbound-endpoint add-access-binding](add-access-binding.md) — Add access binding to the specified dns inbound endpoint

- [yc dns v0 inbound-endpoint add-labels](add-labels.md) — Assign labels to the specified dns inbound endpoint.

- [yc dns v0 inbound-endpoint create](create.md) — Create a dns inbound endpoint in the specified folder.

- [yc dns v0 inbound-endpoint delete](delete.md) — Delete a dns inbound endpoint.

- [yc dns v0 inbound-endpoint get](get.md) — Get information about a dns inbound endpoint.

- [yc dns v0 inbound-endpoint list](list.md) — List dns inbound endpoints in folder.

- [yc dns v0 inbound-endpoint list-access-bindings](list-access-bindings.md) — List access bindings of the specified dns inbound endpoint.

- [yc dns v0 inbound-endpoint list-operations](list-operations.md) — List operations of the specified dns inbound endpoint.

- [yc dns v0 inbound-endpoint remove-access-binding](remove-access-binding.md) — Remove access binding from the specified dns inbound endpoint

- [yc dns v0 inbound-endpoint remove-labels](remove-labels.md) — Remove labels from the specified dns inbound endpoint

- [yc dns v0 inbound-endpoint set-access-bindings](set-access-bindings.md) — Set access bindings to the specified dns inbound endpoint and delete all existing access bindings if there are any.

- [yc dns v0 inbound-endpoint update](update.md) — Modify configuration or attributes of a dns inbound endpoint.

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