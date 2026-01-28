---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kubernetes/cli-ref/marketplace/helm-release/index.md
---

# yc managed-kubernetes marketplace helm-release

Manage Marketplace-provided releases.

#### Command Usage

Syntax:

`yc managed-kubernetes marketplace helm-release <command>`

Aliases:

- `helm`

- `release`

#### Command Tree

- [yc managed-kubernetes marketplace helm-release get](get.md) — Get information about an installed Helm Release.

- [yc managed-kubernetes marketplace helm-release install](install.md) — Install a Helm Release from marketplace on the cluster.

- [yc managed-kubernetes marketplace helm-release list](list.md) — Get information about all Helm Releases installed on the cluster.

- [yc managed-kubernetes marketplace helm-release uninstall](uninstall.md) — Uninstall a Helm Release from marketplace from the cluster.

- [yc managed-kubernetes marketplace helm-release update](update.md) — Update a Helm Release from marketplace on the cluster.

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