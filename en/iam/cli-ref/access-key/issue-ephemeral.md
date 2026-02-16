---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/access-key/issue-ephemeral.md
---

# yc iam access-key issue-ephemeral

Issue ephemeral access key.
Access keys are used for the authentication by Yandex Object Storage API
to provide compatibility with Amazon S3 API.

#### Command Usage

Syntax:

`yc iam access-key issue-ephemeral [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--subject-id` | `string`

The subject identifier for whom the ephemeral access key will be created. If not specified, it defaults to the subject that made the request. ||
|| `--session-name` | `string`

Use the session name to uniquely identify a session when the same SA is impersonated by different principals or for different reasons. ||
|| `--policy` | `string`

AWS-compatible policy in JSON format that you want to use as an inline session policy. ||
|| `--duration` | `duration`

Duration, which specifies the duration of the temporary security credentials. Format 15m-12h. ||
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