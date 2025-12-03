---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/policy/create.md
---

# yc beta certificate-manager policy create

Creates a policy for the specified certificate authority.

#### Command Usage

Syntax: 

`yc beta certificate-manager policy create <CERTIFICATE-AUTHORITY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--certificate-authority-id`|<b>`string`</b><br/>ID of the certificate authority to create a policy for.|
|`--name`|<b>`string`</b><br/>Name of the policy.|
|`--san-policy`|<b>`shorthand/json`</b><br/>Policy for the subject alternative name (SAN) field of the certificate.<br/><br/>Example:|
|`--san-policy`|<b>`directory-name=value,`</b><br/>dns-name=value, edi-party-name={name-assigner=value, party-name=value}, ip-address=value, other-name-oid=value, registered-id=value, rfc-822-name=value, uniform-resource-identifier=value<br/><br/>Shorthand Syntax:<br/>{directory-name=str, dns-name=str, edi-party-name={name-assigner=str, party-name=str}, ip-address=str, other-name-oid=str, registered-id=str, rfc-822-name=str, uniform-resource-identifier=str}<br/>Fields:<br/>directory-name               string  — Allowed directory names in the SAN field.<br/>dns-name                     string  — Allowed DNS names in the SAN field.<br/>edi-party-name               struct  — Allowed EDI party names in the SAN field.<br/>name-assigner  string  — Specifies the entity or authority that assigned the partyName<br/>party-name     string  — The actual identifier of the EDI party<br/>ip-address                   string  — Allowed IP addresses in the SAN field.<br/>other-name-oid               string  — Allowed OIDs of the other name in the SAN field.<br/>registered-id                string  — Allowed registered IDs in the SAN field.<br/>rfc-822-name                 string  — Allowed RFC 822 names (email addresses) in the SAN field.<br/>uniform-resource-identifier  string  — Allowed URIs in the SAN field.<br/>|
|`--subject-policy`|<b>`shorthand/json`</b><br/>Policy for the subject field of the certificate.<br/><br/>Example:|
|`--subject-policy`|<b>`common-name=value,`</b><br/>country=value, distinguished-name-qualifier=value, email-address=value, generation-qualifier=value, given-name=value, initials=value, locality=value, organization=value, organizational-unit=value, serial-number=value, state-or-province=value, surname=value, title=value<br/><br/>Shorthand Syntax:<br/>{common-name=str, country=str, distinguished-name-qualifier=str, email-address=str, generation-qualifier=str, given-name=str, initials=str, locality=str, organization=str, organizational-unit=str, serial-number=str, state-or-province=str, surname=str, title=str}<br/>Fields:<br/>common-name                   string  — Allowed common name in the subject field.<br/>country                       string  — Allowed country name in the subject field.<br/>distinguished-name-qualifier  string  — Allowed distinguished name qualifier in the subject field.<br/>email-address                 string  — Allowed email address in the subject field.<br/>generation-qualifier          string  — Allowed generation qualifier in the subject field.<br/>given-name                    string  — Allowed given name in the subject field.<br/>initials                      string  — Allowed initials in the subject field.<br/>locality                      string  — Allowed locality name in the subject field.<br/>organization                  string  — Allowed organization name in the subject field.<br/>organizational-unit           string  — Allowed organizational unit name in the subject field.<br/>serial-number                 string  — Allowed serial number in the subject field.<br/>state-or-province             string  — Allowed state or province name in the subject field.<br/>surname                       string  — Allowed surname in the subject field.<br/>title                         string  — Allowed title in the subject field.<br/>|
|`--extended-key-usages-white-list`|<b>`shorthand/json`</b><br/>Whitelist of allowed extended key usages.<br/><br/>Example:<br/>--extended-key-usages-white-list extended-key-usage=SERVER_AUTH<br/><br/>Shorthand Syntax:<br/>{extended-key-usage=SERVER_AUTH\|CLIENT_AUTH\|CODE_SIGNING\|EMAIL_PROTECTION\|TIME_STAMPING\|OCSP_SIGNING\|IPSEC_IKE\|MS_CODE_IND\|MS_CODE_COM\|MS_CTL_SIGN\|MS_EFS,...}<br/>Fields:<br/>extended-key-usage  []int  — List of extended key usages that are allowed or disallowed.<br/>|
|`--extended-key-usages-black-list`|<b>`shorthand/json`</b><br/>Blacklist of disallowed extended key usages.<br/><br/>Example:<br/>--extended-key-usages-black-list extended-key-usage=SERVER_AUTH<br/><br/>Shorthand Syntax:<br/>{extended-key-usage=SERVER_AUTH\|CLIENT_AUTH\|CODE_SIGNING\|EMAIL_PROTECTION\|TIME_STAMPING\|OCSP_SIGNING\|IPSEC_IKE\|MS_CODE_IND\|MS_CODE_COM\|MS_CTL_SIGN\|MS_EFS,...}<br/>Fields:<br/>extended-key-usage  []int  — List of extended key usages that are allowed or disallowed.<br/>|
|`--extension-white-list`|<b>`shorthand/json`</b><br/>Whitelist of allowed extensions.<br/><br/>Example:<br/>--extension-white-list extension-oid=value<br/><br/>Shorthand Syntax:<br/>{extension-oid=str,...}<br/>Fields:<br/>extension-oid  []string  — List of extension OIDs that are allowed or disallowed.<br/>|
|`--extension-black-list`|<b>`shorthand/json`</b><br/>Blacklist of disallowed extensions.<br/><br/>Example:<br/>--extension-black-list extension-oid=value<br/><br/>Shorthand Syntax:<br/>{extension-oid=str,...}<br/>Fields:<br/>extension-oid  []string  — List of extension OIDs that are allowed or disallowed.<br/>|
|`--key-usages-white-list`|<b>`shorthand/json`</b><br/>Whitelist of allowed key usages.<br/><br/>Example:<br/>--key-usages-white-list key-usage=DIGITAL_SIGNATURE<br/><br/>Shorthand Syntax:<br/>{key-usage=DIGITAL_SIGNATURE\|CONTENT_COMMITMENT\|KEY_ENCIPHERMENT\|DATA_ENCIPHERMENT\|KEY_AGREEMENT\|KEY_CERT_SIGN\|CRL_SIGN\|ENCIPHER_ONLY\|DECIPHER_ONLY,...}<br/>Fields:<br/>key-usage  []int  — List of key usages that are allowed or disallowed.<br/>|
|`--key-usages-black-list`|<b>`shorthand/json`</b><br/>Blacklist of disallowed key usages.<br/><br/>Example:<br/>--key-usages-black-list key-usage=DIGITAL_SIGNATURE<br/><br/>Shorthand Syntax:<br/>{key-usage=DIGITAL_SIGNATURE\|CONTENT_COMMITMENT\|KEY_ENCIPHERMENT\|DATA_ENCIPHERMENT\|KEY_AGREEMENT\|KEY_CERT_SIGN\|CRL_SIGN\|ENCIPHER_ONLY\|DECIPHER_ONLY,...}<br/>Fields:<br/>key-usage  []int  — List of key usages that are allowed or disallowed.<br/>|
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
