---
editable: false
sourcePath: en/_cli-ref/cli-ref/kms/cli-ref/asymmetric-signature-crypto/sign.md
---

# yc kms asymmetric-signature-crypto sign

Sign data with specified asymmetric signature key

#### Command Usage

Syntax: 

`yc kms asymmetric-signature-crypto sign <ASYMMETRIC-SIGNATURE-KEY> [Flags][Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Asymmetric signature key id.|
|`--name`|<b>`string`</b><br/>Asymmetric signature key name.|
|`--signature-output-file`|<b>`string`</b><br/>File to write signature value to. Otherwise write signature value to stdout.|
|`--outform`|<b>`string`</b><br/>Signature output format. Can be 'raw' (default), 'hex' and 'base64'.|
|`--message-file`|<b>`string`</b><br/>Message file. Otherwise performs sign operation with data from stdin.|
|`--inform`|<b>`string`</b><br/>Message file format. Can be 'raw' (default), 'hex' and 'base64'.|

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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
