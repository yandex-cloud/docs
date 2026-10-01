[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [kms](../index.md) > [symmetric-crypto](index.md) > re-encrypt

# yc kms symmetric-crypto re-encrypt

Re-encrypt a ciphertext with the specified symmetric key

#### Command Usage

Syntax:

`yc kms symmetric-crypto re-encrypt <SYMMETRIC-KEY> [Flags][Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

symmetric-key id. ||
|| `--name` | `string`

symmetric-key name. ||
|| `--version-id` | `string`

New key version id to encrypt. Otherwise primary version of symmetric key will be used. ||
|| `--aad-context-file` | `string`

Additional authenticated data file to encrypt. Otherwise encrypt without aad context. ||
|| `--source-key-id` | `string`

Required. ID of the key that the source ciphertext is currently encrypted with. May be the same as for the new key. ||
|| `--source-aad-context-file` | `string`

Additional authenticated data file provided with the initial encryption request. ||
|| `--source-ciphertext-file` | `string`

Initial ciphertext file to re-encrypt. Otherwise performs re-encrypt operation with data from stdin. ||
|| `--ciphertext-file` | `string`

File to write re-encrypted ciphertext. Otherwise write re-encrypted ciphertext to stdout. ||
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