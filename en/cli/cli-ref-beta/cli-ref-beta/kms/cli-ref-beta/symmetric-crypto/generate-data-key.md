---
editable: false
noIndex: true
---

# yc beta kms symmetric-crypto generate-data-key

Generates a new symmetric data encryption key (not a KMS key) and returns
the generated key as plaintext and as ciphertext encrypted with the specified symmetric KMS key.

#### Command Usage

Syntax:

`yc beta kms symmetric-crypto generate-data-key <KEY-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--aad-context` | `[]uint`

Additional authenticated data (AAD context), optional. If specified, this data will be required for decryption with the [SymmetricDecryptRequest]. Should be encoded with base64. ||
|| `--data-key-spec` | `enum`

Encryption algorithm and key length for the generated data key. Possible Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm', 'gost-r-3412-2015-k' ||
|| `--key-id` | `string`

ID of the symmetric KMS key that the generated data key should be encrypted with. ||
|| `--skip-plaintext` | If 'true', the method won't return the data key as plaintext. Default value is 'false'. ||
|| `--version-id` | `string`

ID of the key version to encrypt the generated data key with. Defaults to the primary version if not specified. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#