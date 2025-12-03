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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--certificate-authority-id`|<b>`string`</b><br/>The ID of the Certificate Authority (CA) that will issue this certificate.|
|`--deletion-protection`|Flag to protect the certificate from being accidentally deleted.|
|`--description`|<b>`string`</b><br/>A description of the certificate.|
|`--desired-ttl-days`|<b>`int`</b><br/>Desired time-to-live (TTL) of the certificate in days.|
|`--extended-key-usage`|<b>`int32Slice`</b><br/>List of extended purposes of the certificate, such as serverAuth or clientAuth.|
|`--key-usage`|<b>`int32Slice`</b><br/>List of purposes of the certificate, such as digitalSignature or keyEncipherment.|
|`--name`|<b>`string`</b><br/>The name of the certificate.|
|`--signing-algorithm`|<b>`enum`</b><br/>The algorithm the CA will use to sign and issue the certificate. Possible Values: 'rsa-2048-pss-sha-256', 'rsa-2048-pss-sha-384', 'rsa-2048-pss-sha-512', 'rsa-3072-pss-sha-256', 'rsa-3072-pss-sha-384', 'rsa-3072-pss-sha-512', 'rsa-4096-pss-sha-256', 'rsa-4096-pss-sha-384', 'rsa-4096-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256', 'rsa-2048-pkcs1-5-sha-256', 'rsa-2048-pkcs1-5-sha-384', 'rsa-2048-pkcs1-5-sha-512', 'rsa-3072-pkcs1-5-sha-256', 'rsa-3072-pkcs1-5-sha-384', 'rsa-3072-pkcs1-5-sha-512', 'rsa-4096-pkcs1-5-sha-256', 'rsa-4096-pkcs1-5-sha-384', 'rsa-4096-pkcs1-5-sha-512'|
|`--subject`|<b>`shorthand/json`</b><br/>Details about the certificate subject (e.g., CN, O, etc.).<br/><br/>Example:|
|`--subject`|<b>`additional-rdn={generation-qualifier=value,`</b><br/>given-name=value, initials=value, locality=value, serial-number=value, surname=value, title=value}, base-rdn={common-name=value, country=value, distinguished-name-qualifier=value, email-address=value, organization=value, organizational-unit=value, state-or-province=value}<br/><br/>Shorthand Syntax:<br/>{additional-rdn={generation-qualifier=str, given-name=str, initials=str, locality=str, serial-number=str, surname=str, title=str}, base-rdn={common-name=str, country=str, distinguished-name-qualifier=str, email-address=str, organization=str, organizational-unit=str, state-or-province=str}}<br/>Fields:<br/>additional-rdn  struct            — Additional fields of subject<br/>generation-qualifier  string  — Generation qualifier of certificate subject in arbitrary form.<br/>given-name            string  — Given name of certificate subject in arbitrary form.<br/>initials              string  — Initials of certificate subject in arbitrary form.<br/>locality              string  — Locality of certificate subject in arbitrary form.<br/>serial-number         string  — Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.<br/>surname               string  — Surname of certificate subject in arbitrary form.<br/>title                 string  — Title of certificate subject in arbitrary form.<br/>base-rdn        struct  required  — Most used field of subject<br/>common-name                   string  — Common name. For tls certificates it is domain usually.<br/>country                       string  — Two letter county code<br/>distinguished-name-qualifier  string  — Distinguished name qualifier<br/>email-address                 string  — Email address of certificate owner<br/>organization                  string  — Organization name in arbitrary form<br/>organizational-unit           string  — Organizational unit name in arbitrary form<br/>state-or-province             string  — State or province name in arbitrary form<br/>|
|`--subject-alternative-names`|<b>`shorthand/json`</b><br/>Subject Alternative Names (SANs) for the certificate, such as DNS entries or IP addresses.<br/><br/>Example:<br/>--subject-alternative-names [{san={directory-name=value}}]<br/><br/>Shorthand Syntax:<br/>[{san={directory-name=str \| dns-name=str \| edi-party-name={name-assigner=str, party-name=str} \| ip-address=str \| other-name={name=str, type-oid=str} \| registered-id=str \| rfc-822-name=str \| uniform-resource-identifier=str \| x-400-name=str}},...]<br/>Fields:<br/>san  oneof<directory-name\|dns-name\|edi-party-name\|ip-address\|other-name\|registered-id\|rfc-822-name\|uniform-resource-identifier\|x-400-name>  — Oneof san field<br/>other-name                   struct  — Local defined identifier in arbitrary form<br/>name      string  — DER encoded value of type with type_oid<br/>type-oid  string  — Object identifier for name type<br/>rfc-822-name                 string  — Encoded email address<br/>dns-name                     string  — Widely used in tls certificates for domains<br/>x-400-name                   string  — x400 name https://en.wikipedia.org/wiki/X.400<br/>directory-name               string  — Represents sequence of rdn for uniquely identifying entities<br/>edi-party-name               struct  — Electronic Data Interchange entity<br/>name-assigner  string  — Specifies the entity or authority that assigned the partyName<br/>party-name     string  — The actual identifier of the EDI party<br/>uniform-resource-identifier  string  — URI<br/>ip-address                   string  — ip address of certificate subject. May be used in tls certificates<br/>registered-id                string  — Object Identifier (OID)<br/>|
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
