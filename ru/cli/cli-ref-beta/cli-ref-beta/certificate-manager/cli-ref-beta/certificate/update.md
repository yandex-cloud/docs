---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/certificate/update.md
---

# yc beta certificate-manager certificate update

Updates the specified certificate.

#### Command Usage

Syntax: 

`yc beta certificate-manager certificate update <CERTIFICATE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--certificate`|<b>`string`</b><br/>New PEM-encoded certificate content for the certificate. Used only for imported certificates.|
|`--certificate-id`|<b>`string`</b><br/>ID of the certificate to update.<br/>To get the ID of a certificate use a [CertificateService.List] request.|
|`--chain`|<b>`string`</b><br/>New PEM-encoded certificate chain content for the certificate. Used only for imported certificates.|
|`--deletion-protection`|Flag that protects deletion of the certificate|
|`--description`|<b>`string`</b><br/>New description for the certificate.|
|`--labels`|<b>`stringToString`</b><br/>New labels for the certificate as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>New name for the certificate.|
|`--private-key`|<b>`string`</b><br/>New PEM-encoded private key content for the certificate. Used only for imported certificates.|
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
