---
editable: false
---

# yc kms asymmetric-signature-crypto sign

Sign data with specified asymmetric signature key

#### Command Usage

Syntax:

`yc kms asymmetric-signature-crypto sign <ASYMMETRIC-SIGNATURE-KEY> [Flags][Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Asymmetric signature key id. ||
|| `--name` | `string`

Asymmetric signature key name. ||
|| `--signature-output-file` | `string`

File to write signature value to. Otherwise write signature value to stdout. ||
|| `--outform` | `string`

Signature output format. Can be 'raw' (default), 'hex' and 'base64'. ||
|| `--message-file` | `string`

Message file. Otherwise performs sign operation with data from stdin. ||
|| `--inform` | `string`

Message file format. Can be 'raw' (default), 'hex' and 'base64'. ||
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