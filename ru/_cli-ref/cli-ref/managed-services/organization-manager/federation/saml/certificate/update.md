# yc organization-manager federation saml certificate update

Update the specified certificate

#### Command Usage

Syntax: 

`yc organization-manager federation saml certificate update <CERTIFICATE-NAME>|<CERTIFICATE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--federation-id`|<b>`string`</b><br/>federation id.|
|`--federation-name`|<b>`string`</b><br/>federation name.|
|`--id`|<b>`string`</b><br/>ID of the certificate.|
|`--name`|<b>`string`</b><br/>Name of the certificate.|
|`--new-name`|<b>`string`</b><br/>A new name of the certificate.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the certificate.|
|`--certificate-file`|<b>`string`</b><br/>Path to X.509 certificate file to associate with selected federation.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
