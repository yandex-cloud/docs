---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/private-certificate-authority/generate-certificate-authority-by-csr.md
---

# yc beta certificate-manager private-certificate-authority generate-certificate-authority-by-csr

Generates a Certificate Authority (CA) by using a Certificate Signing Request (CSR).  This allows using an externally provided CSR to finalize CA creation.

#### Command Usage

Syntax: 

`yc beta certificate-manager private-certificate-authority generate-certificate-authority-by-csr <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--csr`|<b>`string`</b><br/>The PEM-encoded Certificate Signing Request (CSR) content.|
|`--deletion-protection`|Protect the CA from accidental deletion.|
|`--description`|<b>`string`</b><br/>An optional description of the Certificate Authority.|
|`--enable-crl`|Enable Certificate Revocation List (CRL) support.|
|`--enable-ocsp`|Enable Online Certificate Status Protocol (OCSP) support.|
|`--end-entities-ttl-limit-days`|<b>`int`</b><br/>TTL limit in days for end-entities signed by the CA.|
|`--folder-id`|<b>`string`</b><br/>Folder ID where the CA is being created.|
|`--name`|<b>`string`</b><br/>The name of the Certificate Authority.|
|`--parent-certificate-authority-id`|<b>`string`</b><br/>Optional. If set intermediate CA would be generated and signed on parent CA|
|`--private-key`|<b>`string`</b><br/>Optional. The PEM-encoded private key linked to the certificate. If absent CA would be issued with server side generated key pair|
|`--template-id`|<b>`string`</b><br/>Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred|
|`--ttl-days`|<b>`int`</b><br/>The Time-To-Live (TTL) in days for the CA.|
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
