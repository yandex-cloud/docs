# yc kms symmetric-crypto re-encrypt

Re-encrypt a ciphertext with the specified symmetric key

#### Command Usage

Syntax: 

`yc kms symmetric-crypto re-encrypt <SYMMETRIC-KEY> [Flags][Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Symmetric key id.|
|`--name`|<b>`string`</b><br/> Symmetric key name.|
|`--version-id`|<b>`string`</b><br/> New key version id to encrypt. Otherwise primary version of symmetric key will be used.|
|`--aad-context-file`|<b>`string`</b><br/> Additional authenticated data file to encrypt. Otherwise encrypt without aad context.|
|`--source-key-id`|<b>`string`</b><br/> Required. ID of the key that the source ciphertext is currently encrypted with. May be the same as for the new key.|
|`--source-aad-context-file`|<b>`string`</b><br/> Additional authenticated data file provided with the initial encryption request.|
|`--source-ciphertext-file`|<b>`string`</b><br/> Required. Initial ciphertext file to re-encrypt.|
|`--ciphertext-file`|<b>`string`</b><br/> Required. File to write re-encrypted ciphertext.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
