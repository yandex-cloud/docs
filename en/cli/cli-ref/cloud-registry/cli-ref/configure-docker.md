---
editable: false
sourcePath: en/_cli-ref/cli-ref/cloud-registry/cli-ref/configure-docker.md
---

# yc cloud-registry configure-docker



#### Command Usage

Syntax:

`yc cloud-registry configure-docker`

#### Flags

#|
||Flag | Description ||
|| `--hostname` | `value[,value]`

Non-default registry hostname that should use Docker credential helper ||
|| `--disable` | Disable credential helper ||
|| `--skip-version-check` | Skip check that installed docker supports credential helpers ||
|| `--profile` | `string`

Profile for chosen hostnames ||
|| `--docker-config-dir` | `string`

Path relative to the user's home directory where Docker config.json is located (default: .docker) ||
|#

#### Global Flags

#|
||Flag | Description ||
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