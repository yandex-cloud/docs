---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/image/index.md
---

# yc compute image

Manage images

#### Command Usage

Syntax:

`yc compute image <command>`

Aliases:

- `images`

#### Command Tree

- [yc compute image add-access-binding](add-access-binding.md) — Add access binding for the specified image

- [yc compute image add-labels](add-labels.md) — Add labels to specified image

- [yc compute image create](create.md) — Create an image

- [yc compute image delete](delete.md) — Delete the specified image

- [yc compute image get](get.md) — Show information about the specified image

- [yc compute image get-latest-from-family](get-latest-from-family.md) — Show information about the latest image that is part of an image family

- [yc compute image list](list.md) — List images

- [yc compute image list-access-bindings](list-access-bindings.md) — List access bindings for the specified image

- [yc compute image list-operations](list-operations.md) — List operations for the specified image

- [yc compute image remove-access-binding](remove-access-binding.md) — Remove access binding for the specified image

- [yc compute image remove-labels](remove-labels.md) — Remove labels from specified image

- [yc compute image set-access-bindings](set-access-bindings.md) — Set access bindings for the specified image and delete all existing access bindings if there were any

- [yc compute image update](update.md) — Update the specified image

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