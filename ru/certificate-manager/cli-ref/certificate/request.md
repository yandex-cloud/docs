---
editable: false
sourcePath: en/_cli-ref/cli-ref/certificate-manager/cli-ref/certificate/request.md
---

# yc certificate-manager certificate request

Request a managed certificate

#### Command Usage

Syntax:

`yc certificate-manager certificate request [Flags...] [Global Flags...]`

Aliases:

- `request-new`

- `new`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Specifies the name of the certificate. ||
|| `--description` | `string`

Specifies the textual description of the certificate. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--domains` | `value[,value]`

Specifies the list of domains of the certificate. ||
|| `--challenge` | `string`

Specifies the challenge type to validate ownership of the domains. Values: 'dns', 'http' ||
|| `--deletion-protection` | Protects deletion of certificate. ||
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