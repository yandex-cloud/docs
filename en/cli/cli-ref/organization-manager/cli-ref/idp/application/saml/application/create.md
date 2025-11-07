---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/application/saml/application/create.md
---

# yc organization-manager idp application saml application create

Create a SAML application

#### Command Usage

Syntax: 

`yc organization-manager idp application saml application create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--organization-id`|<b>`string`</b><br/>Set the ID of the organization to use.|
|`--name`|<b>`string`</b><br/>A name of the SAML application.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the SAML application.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--group-distribution-type`|<b>`string`</b><br/>Specifies the group distribution type for the SAML application. Values: 'none', 'assigned-groups', 'all-groups'|
|`--entity-id`|<b>`string`</b><br/>Service provider entity ID.|
|`--signature-mode`|<b>`string`</b><br/>Signature mode for SAML assertions and responses (ASSERTIONS, RESPONSE, or RESPONSE_AND_ASSERTIONS). Values: 'assertions', 'response', 'response-and-assertions'|
|`--name-id-format`|<b>`string`</b><br/>NameID format (PERSISTENT or EMAIL). Values: 'persistent', 'email'|
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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
