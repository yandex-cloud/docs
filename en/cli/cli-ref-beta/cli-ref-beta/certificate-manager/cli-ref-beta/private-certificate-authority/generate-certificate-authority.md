---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/private-certificate-authority/generate-certificate-authority.md
---

# yc beta certificate-manager private-certificate-authority generate-certificate-authority

Generates a new Certificate Authority (CA).  This endpoint creates a new CA with given properties and cryptographic settings.

#### Command Usage

Syntax: 

`yc beta certificate-manager private-certificate-authority generate-certificate-authority <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--algorithm`|<b>`enum`</b><br/>The algorithm for the asymmetric key generation (e.g., RSA, ECC). Possible Values: 'rsa-2048-pss-sha-256', 'rsa-2048-pss-sha-384', 'rsa-2048-pss-sha-512', 'rsa-3072-pss-sha-256', 'rsa-3072-pss-sha-384', 'rsa-3072-pss-sha-512', 'rsa-4096-pss-sha-256', 'rsa-4096-pss-sha-384', 'rsa-4096-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256', 'rsa-2048-pkcs1-5-sha-256', 'rsa-2048-pkcs1-5-sha-384', 'rsa-2048-pkcs1-5-sha-512', 'rsa-3072-pkcs1-5-sha-256', 'rsa-3072-pkcs1-5-sha-384', 'rsa-3072-pkcs1-5-sha-512', 'rsa-4096-pkcs1-5-sha-256', 'rsa-4096-pkcs1-5-sha-384', 'rsa-4096-pkcs1-5-sha-512'|
|`--deletion-protection`|Protect the CA from accidental deletion. Deny deletion of ca if set|
|`--description`|<b>`string`</b><br/>An optional description of the Certificate Authority.|
|`--enable-crl`|Enable Certificate Revocation List (CRL) support.|
|`--enable-ocsp`|Enable Online Certificate Status Protocol (OCSP) support.|
|`--end-entities-ttl-limit-days`|<b>`int`</b><br/>TTL limit in days for end-entities signed by the CA.|
|`--extended-key-usage`|<b>`int32Slice`</b><br/>Extended key usage (e.g., serverAuth, clientAuth).|
|`--folder-id`|<b>`string`</b><br/>Folder ID where the CA is being created.|
|`--key-usage`|<b>`int32Slice`</b><br/>Key usage (e.g., keyEncipherment, digitalSignature).|
|`--name`|<b>`string`</b><br/>The name of the Certificate Authority.|
|`--parent-certificate-authority-id`|<b>`string`</b><br/>Optional. If set intermediate CA would be generated and signed on parent CA|
|`--path-len`|<b>`int`</b><br/>The maximum length of the certificate chain.|
|`--subject-spec`|<b>`shorthand/json`</b><br/>The subject (e.g., common name, organization, etc.) for the CA.<br/>Shorthand Syntax:<br/>{<br/>additional-rdn = {<br/>generation-qualifier = str,<br/>given-name = str,<br/>initials = str,<br/>locality = str,<br/>serial-number = str,<br/>surname = str,<br/>title = str<br/>},<br/>base-rdn = {<br/>common-name = str,<br/>country = str,<br/>distinguished-name-qualifier = str,<br/>email-address = str,<br/>organization = str,<br/>organizational-unit = str,<br/>state-or-province = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"additional-rdn": {<br/>"generation-qualifier": "str",<br/>"given-name": "str",<br/>"initials": "str",<br/>"locality": "str",<br/>"serial-number": "str",<br/>"surname": "str",<br/>"title": "str"<br/>},<br/>"base-rdn": {<br/>"common-name": "str",<br/>"country": "str",<br/>"distinguished-name-qualifier": "str",<br/>"email-address": "str",<br/>"organization": "str",<br/>"organizational-unit": "str",<br/>"state-or-province": "str"<br/>}<br/>}"<br/>Fields:<br/>additional-rdn -> (struct)<br/>Additional fields of subject<br/>generation-qualifier -> (string)<br/>Generation qualifier of certificate subject in arbitrary form.<br/>given-name -> (string)<br/>Given name of certificate subject in arbitrary form.<br/>initials -> (string)<br/>Initials of certificate subject in arbitrary form.<br/>locality -> (string)<br/>Locality of certificate subject in arbitrary form.<br/>serial-number -> (string)<br/>Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.<br/>surname -> (string)<br/>Surname of certificate subject in arbitrary form.<br/>title -> (string)<br/>Title of certificate subject in arbitrary form.<br/>base-rdn -> (struct)<br/>Most used field of subject<br/>common-name -> (string)<br/>Common name. For tls certificates it is domain usually.<br/>country -> (string)<br/>Two letter county code<br/>distinguished-name-qualifier -> (string)<br/>Distinguished name qualifier<br/>email-address -> (string)<br/>Email address of certificate owner<br/>organization -> (string)<br/>Organization name in arbitrary form<br/>organizational-unit -> (string)<br/>Organizational unit name in arbitrary form<br/>state-or-province -> (string)<br/>State or province name in arbitrary form|
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
