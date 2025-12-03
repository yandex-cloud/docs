---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/kms/cli-ref-beta/symmetric-crypto/index.md
---

# yc beta kms symmetric-crypto

Set of methods that perform symmetric encryption and decryption.

#### Command Usage

Syntax: 

`yc beta kms symmetric-crypto <command>`

#### Command Tree

- [yc beta kms symmetric-crypto decrypt](decrypt.md) — Decrypts the given ciphertext with the specified key.
- [yc beta kms symmetric-crypto encrypt](encrypt.md) — Encrypts given plaintext with the specified key.
- [yc beta kms symmetric-crypto generate-data-key](generate-data-key.md) — Generates a new symmetric data encryption key (not a KMS key) and returns
- [yc beta kms symmetric-crypto re-encrypt](re-encrypt.md) — Re-encrypts a ciphertext with the specified KMS key.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
