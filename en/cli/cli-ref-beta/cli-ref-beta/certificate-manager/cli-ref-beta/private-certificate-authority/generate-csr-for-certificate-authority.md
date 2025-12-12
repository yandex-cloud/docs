---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/private-certificate-authority/generate-csr-for-certificate-authority.md
---

# yc beta certificate-manager private-certificate-authority generate-csr-for-certificate-authority

Generates a Certificate Signing Request (CSR) for a new CA.  This allows generating the CSR which can be used to receive the final certificate.

#### Command Usage

Syntax: 

`yc beta certificate-manager private-certificate-authority generate-csr-for-certificate-authority <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--algorithm`|<b>`enum`</b><br/>The cryptographic algorithm to generate the CSR with (e.g., RSA, ECC). Possible Values: 'rsa-2048-pss-sha-256', 'rsa-2048-pss-sha-384', 'rsa-2048-pss-sha-512', 'rsa-3072-pss-sha-256', 'rsa-3072-pss-sha-384', 'rsa-3072-pss-sha-512', 'rsa-4096-pss-sha-256', 'rsa-4096-pss-sha-384', 'rsa-4096-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256', 'rsa-2048-pkcs1-5-sha-256', 'rsa-2048-pkcs1-5-sha-384', 'rsa-2048-pkcs1-5-sha-512', 'rsa-3072-pkcs1-5-sha-256', 'rsa-3072-pkcs1-5-sha-384', 'rsa-3072-pkcs1-5-sha-512', 'rsa-4096-pkcs1-5-sha-256', 'rsa-4096-pkcs1-5-sha-384', 'rsa-4096-pkcs1-5-sha-512'|
|`--deletion-protection`|Protection flag that prevents accidental deletion of the Certificate Authority. If set to true, the CA cannot be deleted unless this flag is removed.|
|`--description`|<b>`string`</b><br/>Optional description of the Certificate Authority for users to add additional context.|
|`--enable-crl`|Enables support for Certificate Revocation Lists (CRL). If enabled, the CA will support revocation and produce CRLs.|
|`--enable-ocsp`|Enables support for the Online Certificate Status Protocol (OCSP). If enabled, OCSP responses will be generated for certificates signed by this CA.|
|`--end-entities-ttl-limit-days`|<b>`int`</b><br/>TTL limit in days for end-entity certificates (e.g., server certs) issued by this CA. This limit ensures the lifetime of signed end-entity certificates doesn't exceed this value.|
|`--extended-key-usage`|<b>`int32Slice`</b><br/>Specifies the extended key usage extensions, such as serverAuth or clientAuth.|
|`--folder-id`|<b>`string`</b><br/>Folder ID where the CA is being created.|
|`--issuer`|<b>`shorthand/json`</b><br/>Specifies the Certificate Authority issuer. Required to define the issuer attributes for the CSR.<br/>Shorthand Syntax:<br/>{<br/>additional-rdn = {<br/>generation-qualifier = str,<br/>given-name = str,<br/>initials = str,<br/>locality = str,<br/>serial-number = str,<br/>surname = str,<br/>title = str<br/>},<br/>base-rdn = {<br/>common-name = str,<br/>country = str,<br/>distinguished-name-qualifier = str,<br/>email-address = str,<br/>organization = str,<br/>organizational-unit = str,<br/>state-or-province = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"additional-rdn": {<br/>"generation-qualifier": "str",<br/>"given-name": "str",<br/>"initials": "str",<br/>"locality": "str",<br/>"serial-number": "str",<br/>"surname": "str",<br/>"title": "str"<br/>},<br/>"base-rdn": {<br/>"common-name": "str",<br/>"country": "str",<br/>"distinguished-name-qualifier": "str",<br/>"email-address": "str",<br/>"organization": "str",<br/>"organizational-unit": "str",<br/>"state-or-province": "str"<br/>}<br/>}"<br/>Fields:<br/>additional-rdn -> (struct)<br/>generation-qualifier -> (string)<br/>Generation qualifier of certificate subject in arbitrary form.<br/>given-name -> (string)<br/>Given name of certificate subject in arbitrary form.<br/>initials -> (string)<br/>Initials of certificate subject in arbitrary form.<br/>locality -> (string)<br/>Locality of certificate subject in arbitrary form.<br/>serial-number -> (string)<br/>Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.<br/>surname -> (string)<br/>Surname of certificate subject in arbitrary form.<br/>title -> (string)<br/>Title of certificate subject in arbitrary form.<br/>base-rdn -> (struct)<br/>common-name -> (string)<br/>Common name. For tls certificates it is domain usually.<br/>country -> (string)<br/>Two letter county code<br/>distinguished-name-qualifier -> (string)<br/>Distinguished name qualifier<br/>email-address -> (string)<br/>Email address of certificate owner<br/>organization -> (string)<br/>Organization name in arbitrary form<br/>organizational-unit -> (string)<br/>Organizational unit name in arbitrary form<br/>state-or-province -> (string)<br/>State or province name in arbitrary form|
|`--key-usage`|<b>`int32Slice`</b><br/>Specifies the key usage extensions, such as digitalSignature, keyEncipherment, etc.|
|`--name`|<b>`string`</b><br/>Unique name for the Certificate Authority.|
|`--path-len`|<b>`int`</b><br/>Path length constraint, defining the depth to which the CA can sign child certificates.|
|`--subject-spec`|<b>`shorthand/json`</b><br/>Subject specifies the distinguished name (DN) fields for the CA (e.g., CN, O, etc.). This is a required field that defines the identity information of the certificate.<br/>Shorthand Syntax:<br/>{<br/>additional-rdn = {<br/>generation-qualifier = str,<br/>given-name = str,<br/>initials = str,<br/>locality = str,<br/>serial-number = str,<br/>surname = str,<br/>title = str<br/>},<br/>base-rdn = {<br/>common-name = str,<br/>country = str,<br/>distinguished-name-qualifier = str,<br/>email-address = str,<br/>organization = str,<br/>organizational-unit = str,<br/>state-or-province = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"additional-rdn": {<br/>"generation-qualifier": "str",<br/>"given-name": "str",<br/>"initials": "str",<br/>"locality": "str",<br/>"serial-number": "str",<br/>"surname": "str",<br/>"title": "str"<br/>},<br/>"base-rdn": {<br/>"common-name": "str",<br/>"country": "str",<br/>"distinguished-name-qualifier": "str",<br/>"email-address": "str",<br/>"organization": "str",<br/>"organizational-unit": "str",<br/>"state-or-province": "str"<br/>}<br/>}"<br/>Fields:<br/>additional-rdn -> (struct)<br/>Additional fields of subject<br/>generation-qualifier -> (string)<br/>Generation qualifier of certificate subject in arbitrary form.<br/>given-name -> (string)<br/>Given name of certificate subject in arbitrary form.<br/>initials -> (string)<br/>Initials of certificate subject in arbitrary form.<br/>locality -> (string)<br/>Locality of certificate subject in arbitrary form.<br/>serial-number -> (string)<br/>Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.<br/>surname -> (string)<br/>Surname of certificate subject in arbitrary form.<br/>title -> (string)<br/>Title of certificate subject in arbitrary form.<br/>base-rdn -> (struct)<br/>Most used field of subject<br/>common-name -> (string)<br/>Common name. For tls certificates it is domain usually.<br/>country -> (string)<br/>Two letter county code<br/>distinguished-name-qualifier -> (string)<br/>Distinguished name qualifier<br/>email-address -> (string)<br/>Email address of certificate owner<br/>organization -> (string)<br/>Organization name in arbitrary form<br/>organizational-unit -> (string)<br/>Organizational unit name in arbitrary form<br/>state-or-province -> (string)<br/>State or province name in arbitrary form|
|`--template-id`|<b>`string`</b><br/>Optional template ID for applying predefined configurations for generating the keys.|
|`--ttl-days`|<b>`int`</b><br/>Time-to-Live (TTL) in days for the Certificate Authority. Defines the validity period of the CA certificate.|
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
