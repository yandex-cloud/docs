---
editable: false
sourcePath: en/_cli-ref/cli-ref/kms/cli-ref/symmetric-crypto/encrypt.md
---

# yc kms symmetric-crypto encrypt

Encrypt data with specified symmetric key

#### Command Usage

Syntax:

`yc kms symmetric-crypto encrypt <SYMMETRIC-KEY> [Flags][Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Symmetric key id. ||
|| `--name` | `string`

Symmetric key name. ||
|| `--version-id` | `string`

Symmetric key version id to encrypt. Otherwise primary version of symmetric key will be used. ||
|| `--aad-context-file` | `string`

Additional authenticated data file. Otherwise performs encrypt operation without aad context. ||
|| `--plaintext-file` | `string`

Plaintext file. Otherwise performs encrypt operation with data from stdin. ||
|| `--ciphertext-file` | `string`

File to write ciphertext. Otherwise write ciphertext to stdout. ||
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