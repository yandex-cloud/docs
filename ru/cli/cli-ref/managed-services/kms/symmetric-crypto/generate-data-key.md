---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/kms/symmetric-crypto/generate-data-key.md
---

# yc kms symmetric-crypto generate-data-key

Generate data key and encrypt it with specified symmetric key

#### Command Usage

Syntax: 

`yc kms symmetric-crypto generate-data-key <SYMMETRIC-KEY> [Flags][Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Symmetric key id.|
|`--name`|<b>`string`</b><br/>Symmetric key name.|
|`--version-id`|<b>`string`</b><br/>Symmetric key version id to encrypt data key. Otherwise primary version of symmetric key will be used.|
|`--aad-context-file`|<b>`string`</b><br/>Additional authenticated data file. Otherwise encrypt data key without aad context.|
|`--data-key-spec`|<b>`string`</b><br/>Required. Encryption algorithm and key length for the generated data key. Values: 'aes-128', 'aes-192', 'aes-256', 'aes-256-hsm'|
|`--skip-plaintext`|Won't write generated data key as plaintext.|
|`--data-key-plaintext-file`|<b>`string`</b><br/>File to write generated data key as plaintext.|
|`--data-key-ciphertext-file`|<b>`string`</b><br/>Required. File to write encrypted data key.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
