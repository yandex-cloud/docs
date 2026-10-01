---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/kms/cli-ref/v0/symmetric-crypto/generate-data-key/
---

# yc kms v0 symmetric-crypto generate-data-key

Generate data key and encrypt it with specified symmetric key

#### Command Usage

Syntax:

`yc kms v0 symmetric-crypto generate-data-key <SYMMETRIC-KEY> [Flags][Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

symmetric-key id. ||
|| `--name` | `string`

symmetric-key name. ||
|| `--version-id` | `string`

Symmetric key version id to encrypt data key. Otherwise primary version of symmetric key will be used. ||
|| `--aad-context-file` | `string`

Additional authenticated data file. Otherwise encrypt data key without aad context. ||
|| `--data-key-spec` | `string`

Required. Encryption algorithm and key length for the generated data key. ||
|| `--skip-plaintext` | Won't write generated data key as plaintext. ||
|| `--data-key-plaintext-file` | `string`

File to write generated data key as plaintext. ||
|| `--data-key-ciphertext-file` | `string`

Required. File to write encrypted data key. ||
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