---
editable: false
---

# yc iam federation create

Create a federation

#### Command Usage

Syntax: 

`yc iam federation create <FEDERATION-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the federation.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the federation.|
|`--issuer`|<b>`string`</b><br/>Specifies an issuer of the federation.|
|`--cookie-max-age`|<b>`duration`</b><br/>Specifies a cookie lifetime of the federation.|
|`--sso-binding`|<b>`string`</b><br/>Specifies a type of SSO binding of the federation. Values: 'post', 'redirect', 'artifact'|
|`--auto-create-account-on-login`|Controls whether to create federated user accounts on first login to the federation.|
|`--sso-url`|<b>`string`</b><br/>Specifies a SSO URL of the federation.|
|`--encrypted-assertions`|Controls whether to encrypt SAML assertions.|
|`--case-insensitive-name-ids`|Controls whether federated users Name IDs should be case insensitive.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
