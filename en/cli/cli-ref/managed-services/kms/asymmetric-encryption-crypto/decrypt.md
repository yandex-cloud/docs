---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/kms/asymmetric-encryption-crypto/decrypt.md
---

# yc kms asymmetric-encryption-crypto decrypt

Decrypt data with specified asymmetric encryption key

#### Command Usage

Syntax: 

`yc kms asymmetric-encryption-crypto decrypt <ASYMMETRIC-ENCRYPTION-KEY> [Flags][Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Asymmetric encryption key id.|
|`--name`|<b>`string`</b><br/>Asymmetric encryption key name.|
|`--ciphertext-file`|<b>`string`</b><br/>Required. Ciphertext file.|
|`--plaintext-file`|<b>`string`</b><br/>Required. File to write plaintext.|

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
