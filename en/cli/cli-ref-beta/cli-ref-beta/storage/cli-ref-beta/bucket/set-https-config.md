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
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--name`|<b>`string`</b><br/>Name of the bucket to update the HTTPS configuration for.|
|`--self-managed`|<b>`shorthand/json`</b><br/>Your TLS certificate, uploaded directly. Object Storage only supports PEM-encoded certificates.<br/>Shorthand Syntax:<br/>{<br/>certificate-pem = str,<br/>private-key-pem = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"certificate-pem": "str",<br/>"private-key-pem": "str"<br/>}"<br/>Fields:<br/>certificate-pem -> (string)<br/>PEM-encoded certificate.<br/>private-key-pem -> (string)<br/>PEM-encoded private key for the certificate.|
|`--certificate-manager`|<b>`shorthand/json`</b><br/>TLS certificate from Certificate Manager. To create a certificate in Certificate Manager, make a [yandex.cloud.certificatemanager.v1.CertificateService.Create] request.<br/>Shorthand Syntax:<br/>{<br/>certificate-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"certificate-id": "str"<br/>}"<br/>Fields:<br/>certificate-id -> (string)<br/>ID of the certificate. To get the list of all available certificates, make a [yandex.cloud.certificatemanager.v1.CertificateService.List] request.|
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
