---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/private-certificate/issue-certificate.md
---

# yc beta certificate-manager private-certificate issue-certificate

Issues a new certificate for a given Certificate Authority (CA).

#### Command Usage

Syntax: 

`yc beta certificate-manager private-certificate issue-certificate <CERTIFICATE-AUTHORITY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--certificate-authority-id`|<b>`string`</b><br/>The ID of the Certificate Authority (CA) that will issue this certificate.|
|`--deletion-protection`|Flag to protect the certificate from being accidentally deleted.|
|`--description`|<b>`string`</b><br/>A description of the certificate.|
|`--desired-ttl-days`|<b>`int`</b><br/>Desired time-to-live (TTL) of the certificate in days.|
|`--extended-key-usage`|<b>`int32Slice`</b><br/>List of extended purposes of the certificate, such as serverAuth or clientAuth.|
|`--key-usage`|<b>`int32Slice`</b><br/>List of purposes of the certificate, such as digitalSignature or keyEncipherment.|
|`--name`|<b>`string`</b><br/>The name of the certificate.|
|`--signing-algorithm`|<b>`enum`</b><br/>The algorithm the CA will use to sign and issue the certificate. Possible Values: 'rsa-2048-pss-sha-256', 'rsa-2048-pss-sha-384', 'rsa-2048-pss-sha-512', 'rsa-3072-pss-sha-256', 'rsa-3072-pss-sha-384', 'rsa-3072-pss-sha-512', 'rsa-4096-pss-sha-256', 'rsa-4096-pss-sha-384', 'rsa-4096-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256', 'rsa-2048-pkcs1-5-sha-256', 'rsa-2048-pkcs1-5-sha-384', 'rsa-2048-pkcs1-5-sha-512', 'rsa-3072-pkcs1-5-sha-256', 'rsa-3072-pkcs1-5-sha-384', 'rsa-3072-pkcs1-5-sha-512', 'rsa-4096-pkcs1-5-sha-256', 'rsa-4096-pkcs1-5-sha-384', 'rsa-4096-pkcs1-5-sha-512'|
|`--subject`|<b>`shorthand/json`</b><br/>Details about the certificate subject (e.g., CN, O, etc.).<br/>Shorthand Syntax:<br/>{<br/>additional-rdn = {<br/>generation-qualifier = str,<br/>given-name = str,<br/>initials = str,<br/>locality = str,<br/>serial-number = str,<br/>surname = str,<br/>title = str<br/>},<br/>base-rdn = {<br/>common-name = str,<br/>country = str,<br/>distinguished-name-qualifier = str,<br/>email-address = str,<br/>organization = str,<br/>organizational-unit = str,<br/>state-or-province = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"additional-rdn": {<br/>"generation-qualifier": "str",<br/>"given-name": "str",<br/>"initials": "str",<br/>"locality": "str",<br/>"serial-number": "str",<br/>"surname": "str",<br/>"title": "str"<br/>},<br/>"base-rdn": {<br/>"common-name": "str",<br/>"country": "str",<br/>"distinguished-name-qualifier": "str",<br/>"email-address": "str",<br/>"organization": "str",<br/>"organizational-unit": "str",<br/>"state-or-province": "str"<br/>}<br/>}"<br/>Fields:<br/>additional-rdn -> (struct)<br/>Additional fields of subject<br/>generation-qualifier -> (string)<br/>Generation qualifier of certificate subject in arbitrary form.<br/>given-name -> (string)<br/>Given name of certificate subject in arbitrary form.<br/>initials -> (string)<br/>Initials of certificate subject in arbitrary form.<br/>locality -> (string)<br/>Locality of certificate subject in arbitrary form.<br/>serial-number -> (string)<br/>Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.<br/>surname -> (string)<br/>Surname of certificate subject in arbitrary form.<br/>title -> (string)<br/>Title of certificate subject in arbitrary form.<br/>base-rdn -> (struct)<br/>Most used field of subject<br/>common-name -> (string)<br/>Common name. For tls certificates it is domain usually.<br/>country -> (string)<br/>Two letter county code<br/>distinguished-name-qualifier -> (string)<br/>Distinguished name qualifier<br/>email-address -> (string)<br/>Email address of certificate owner<br/>organization -> (string)<br/>Organization name in arbitrary form<br/>organizational-unit -> (string)<br/>Organizational unit name in arbitrary form<br/>state-or-province -> (string)<br/>State or province name in arbitrary form|
|`--subject-alternative-names`|<b>`shorthand/json`</b><br/>Subject Alternative Names (SANs) for the certificate, such as DNS entries or IP addresses.<br/>Shorthand Syntax:<br/>[<br/>{<br/>san = directory-name=str \| dns-name=str \| edi-party-name={<br/>name-assigner = str,<br/>party-name = str<br/>} \| ip-address=str \| other-name={<br/>name = str,<br/>type-oid = str<br/>} \| registered-id=str \| rfc-822-name=str \| uniform-resource-identifier=str \| x-400-name=str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"san": {<br/>"directory-name": "str",<br/>"dns-name": "str",<br/>"edi-party-name": {<br/>"name-assigner": "str",<br/>"party-name": "str"<br/>},<br/>"ip-address": "str",<br/>"other-name": {<br/>"name": "str",<br/>"type-oid": "str"<br/>},<br/>"registered-id": "str",<br/>"rfc-822-name": "str",<br/>"uniform-resource-identifier": "str",<br/>"x-400-name": "str"<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>san -> (oneof<directory-name\|dns-name\|edi-party-name\|ip-address\|other-name\|registered-id\|rfc-822-name\|uniform-resource-identifier\|x-400-name>)<br/>Oneof san field<br/>other-name -> (struct)<br/>Local defined identifier in arbitrary form<br/>name -> (string)<br/>DER encoded value of type with type_oid<br/>type-oid -> (string)<br/>Object identifier for name type<br/>rfc-822-name -> (string)<br/>Encoded email address<br/>dns-name -> (string)<br/>Widely used in tls certificates for domains<br/>x-400-name -> (string)<br/>x400 name https://en.wikipedia.org/wiki/X.400<br/>directory-name -> (string)<br/>Represents sequence of rdn for uniquely identifying entities<br/>edi-party-name -> (struct)<br/>Electronic Data Interchange entity<br/>name-assigner -> (string)<br/>Specifies the entity or authority that assigned the partyName<br/>party-name -> (string)<br/>The actual identifier of the EDI party<br/>uniform-resource-identifier -> (string)<br/>URI<br/>ip-address -> (string)<br/>ip address of certificate subject. May be used in tls certificates<br/>registered-id -> (string)<br/>Object Identifier (OID)|
|`--template-id`|<b>`string`</b><br/>Optional certificate template ID. Issue certificate with template's fields if non-empty.|
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
