---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/bucket/set-https-config.md
---

# yc beta storage bucket set-https-config

Updates the HTTPS configuration for the specified bucket.

#### Command Usage

Syntax: 

`yc beta storage bucket set-https-config`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--name`|<b>`string`</b><br/>Name of the bucket to update the HTTPS configuration for.|
|`--self-managed`|<b>`shorthand/json`</b><br/>Your TLS certificate, uploaded directly.<br/><br/>Object Storage only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates.<br/><br/>Example:|
|`--self-managed`|<b>`certificate-pem=value,`</b><br/>private-key-pem=value<br/><br/>Shorthand Syntax:<br/>{certificate-pem=str, private-key-pem=str}<br/>Fields:<br/>certificate-pem  string  — [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificate.<br/>private-key-pem  string  — [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded private key for the certificate.<br/>|
|`--certificate-manager`|<b>`shorthand/json`</b><br/>TLS certificate from Certificate Manager.<br/><br/>To create a certificate in Certificate Manager, make a<br/>[yandex.cloud.certificatemanager.v1.CertificateService.Create] request.<br/><br/>Example:<br/>--certificate-manager certificate-id=value<br/><br/>Shorthand Syntax:<br/>{certificate-id=str}<br/>Fields:<br/>certificate-id  string  — ID of the certificate.<br/><br/>To get the list of all available certificates, make a [yandex.cloud.certificatemanager.v1.CertificateService.List]<br/>request.<br/>|
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
