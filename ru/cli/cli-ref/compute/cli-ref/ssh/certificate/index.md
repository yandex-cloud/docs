---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/ssh/certificate/index.md
---

# yc compute ssh certificate

Manage certificates

#### Command Usage

Syntax: 

`yc compute ssh certificate <command>`

#### Command Tree

- [yc compute ssh certificate export](export.md) — Export certificate

#### Global Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Target instance id|
|`--name`|<b>`string`</b><br/>Target instance name|
|`--login`|<b>`string`</b><br/>Specifies the user to log in as on the remote machine. If not specified the certificate is issued to a default OS Login profile.|
|`--internal-address`|Connect to instance via internal address.|
|`--public-address`|Connect to instance via public address.|
|`-i`,`--identity-file`|<b>`string`</b><br/>Selects a file from which the identity (private key) for public key authentication is read. If not specified a new ssh certificate is issued.|
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
