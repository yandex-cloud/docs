---
editable: false
sourcePath: en/_cli-ref/cli-ref/cloud-registry/cli-ref/registry/create.md
---

# yc cloud-registry registry create

Creates a registry in the specified folder

#### Command Usage

Syntax:

`yc cloud-registry registry create <REGISTRY_NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the registry ||
|| `--description` | `string`

Registry description ||
|| `--registry-kind` | `string`

Registry kind Values: 'maven', 'npm', 'docker', 'nuget', 'debian', 'pypi', 'binary' ||
|| `--registry-type` | `string`

Registry type Values: 'local', 'remote', 'virtual' ||
|| `--labels` | `key=value[,key=value...]`

List of label KEY=VALUE pairs to add. ||
|| `--properties` | `key=value[,key=value...]`

List of property KEY=VALUE pairs to add. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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