---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/private-certificate-authority/update.md
---

# yc beta certificate-manager private-certificate-authority update

Updates the specified Certificate Authority (CA).  This allows updating attributes of an already existing CA, such as name, description, etc.

#### Command Usage

Syntax: 

`yc beta certificate-manager private-certificate-authority update <CERTIFICATE-AUTHORITY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--certificate-authority-id`|<b>`string`</b><br/>The ID of the Certificate Authority to update.|
|`--deletion-protection`|Update the deletion protection flag.<br/>Protects the Certificate Authority from accidental deletion.|
|`--description`|<b>`string`</b><br/>New description of the Certificate Authority (if applicable).<br/>Allows adding or updating the description to clarify the CA's purpose.|
|`--end-entities-ttl-limit-days`|<b>`int`</b><br/>Update the end-entity TTL limit for certificates issued by this Certificate Authority.|
|`--name`|<b>`string`</b><br/>New name of the Certificate Authority (if applicable).<br/>This field is optional and will only be applied if included in the update mask.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
