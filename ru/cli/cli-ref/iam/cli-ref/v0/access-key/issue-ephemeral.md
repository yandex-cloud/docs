---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/iam/cli-ref/v0/access-key/issue-ephemeral/
---

# yc iam v0 access-key issue-ephemeral

Issue ephemeral access key.
Access keys are used for the authentication by Yandex Object Storage API
to provide compatibility with Amazon S3 API.
By default the key is printed to STDOUT. Pass --aws-profile or --aws-credentials-file
to write it directly to the AWS credentials file (~/.aws/credentials by default)
under the given profile.

#### Command Usage

Syntax:

`yc iam v0 access-key issue-ephemeral [Flags...] [Global Flags...]`

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
|| `--aws-profile` | `string`

AWS profile name to store the ephemeral key under. When set, the key is written to the AWS credentials file instead of being printed to STDOUT. Defaults to 'default' when only --aws-credentials-file is set. ||
|| `--aws-credentials-file` | `string`

Path to the AWS credentials file to write the ephemeral key to. Defaults to the AWS_SHARED_CREDENTIALS_FILE environment variable or ~/.aws/credentials ||
|#

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