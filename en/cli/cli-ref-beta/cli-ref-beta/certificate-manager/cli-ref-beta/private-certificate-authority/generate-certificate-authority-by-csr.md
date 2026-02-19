---
editable: false
noIndex: true
---

# yc beta certificate-manager private-certificate-authority generate-certificate-authority-by-csr

Generates a Certificate Authority (CA) by using a Certificate Signing Request (CSR).
This allows using an externally provided CSR to finalize CA creation.

#### Command Usage

Syntax:

`yc beta certificate-manager private-certificate-authority generate-certificate-authority-by-csr <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--csr` | `string`

The PEM-encoded Certificate Signing Request (CSR) content. ||
|| `--deletion-protection` | Protect the CA from accidental deletion. ||
|| `--description` | `string`

An optional description of the Certificate Authority. ||
|| `--enable-crl` | Enable Certificate Revocation List (CRL) support. ||
|| `--enable-ocsp` | Enable Online Certificate Status Protocol (OCSP) support. ||
|| `--end-entities-ttl-limit-days` | `int`

TTL limit in days for end-entities signed by the CA. ||
|| `--folder-id` | `string`

Folder ID where the CA is being created. ||
|| `--name` | `string`

The name of the Certificate Authority. ||
|| `--parent-certificate-authority-id` | `string`

Optional. If set intermediate CA would be generated and signed on parent CA ||
|| `--private-key` | `string`

Optional. The PEM-encoded private key linked to the certificate. If absent CA would be issued with server side generated key pair ||
|| `--template-id` | `string`

Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred ||
|| `--ttl-days` | `int`

The Time-To-Live (TTL) in days for the CA. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#