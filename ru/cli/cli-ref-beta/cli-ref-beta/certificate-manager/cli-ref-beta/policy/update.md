---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/policy/update.md
---

# yc beta certificate-manager policy update

Updates the specified policy.

#### Command Usage

Syntax: 

`yc beta certificate-manager policy update <ID>`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the policy to update.|
|`--name`|<b>`string`</b><br/>New name for the policy.|
|`--san-policy`|<b>`shorthand/json`</b><br/>New policy for the subject alternative name (SAN) field of the certificate.<br/>Shorthand Syntax:<br/>{<br/>directory-name = str,<br/>dns-name = str,<br/>edi-party-name = {<br/>name-assigner = str,<br/>party-name = str<br/>},<br/>ip-address = str,<br/>other-name-oid = str,<br/>registered-id = str,<br/>rfc-822-name = str,<br/>uniform-resource-identifier = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"directory-name": "str",<br/>"dns-name": "str",<br/>"edi-party-name": {<br/>"name-assigner": "str",<br/>"party-name": "str"<br/>},<br/>"ip-address": "str",<br/>"other-name-oid": "str",<br/>"registered-id": "str",<br/>"rfc-822-name": "str",<br/>"uniform-resource-identifier": "str"<br/>}"<br/>Fields:<br/>directory-name -> (string)<br/>Allowed directory names in the SAN field.<br/>dns-name -> (string)<br/>Allowed DNS names in the SAN field.<br/>edi-party-name -> (struct)<br/>Allowed EDI party names in the SAN field.<br/>name-assigner -> (string)<br/>Specifies the entity or authority that assigned the partyName<br/>party-name -> (string)<br/>The actual identifier of the EDI party<br/>ip-address -> (string)<br/>Allowed IP addresses in the SAN field.<br/>other-name-oid -> (string)<br/>Allowed OIDs of the other name in the SAN field.<br/>registered-id -> (string)<br/>Allowed registered IDs in the SAN field.<br/>rfc-822-name -> (string)<br/>Allowed RFC 822 names (email addresses) in the SAN field.<br/>uniform-resource-identifier -> (string)<br/>Allowed URIs in the SAN field.|
|`--subject-policy`|<b>`shorthand/json`</b><br/>New policy for the subject field of the certificate.<br/>Shorthand Syntax:<br/>{<br/>common-name = str,<br/>country = str,<br/>distinguished-name-qualifier = str,<br/>email-address = str,<br/>generation-qualifier = str,<br/>given-name = str,<br/>initials = str,<br/>locality = str,<br/>organization = str,<br/>organizational-unit = str,<br/>serial-number = str,<br/>state-or-province = str,<br/>surname = str,<br/>title = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"common-name": "str",<br/>"country": "str",<br/>"distinguished-name-qualifier": "str",<br/>"email-address": "str",<br/>"generation-qualifier": "str",<br/>"given-name": "str",<br/>"initials": "str",<br/>"locality": "str",<br/>"organization": "str",<br/>"organizational-unit": "str",<br/>"serial-number": "str",<br/>"state-or-province": "str",<br/>"surname": "str",<br/>"title": "str"<br/>}"<br/>Fields:<br/>common-name -> (string)<br/>Allowed common name in the subject field.<br/>country -> (string)<br/>Allowed country name in the subject field.<br/>distinguished-name-qualifier -> (string)<br/>Allowed distinguished name qualifier in the subject field.<br/>email-address -> (string)<br/>Allowed email address in the subject field.<br/>generation-qualifier -> (string)<br/>Allowed generation qualifier in the subject field.<br/>given-name -> (string)<br/>Allowed given name in the subject field.<br/>initials -> (string)<br/>Allowed initials in the subject field.<br/>locality -> (string)<br/>Allowed locality name in the subject field.<br/>organization -> (string)<br/>Allowed organization name in the subject field.<br/>organizational-unit -> (string)<br/>Allowed organizational unit name in the subject field.<br/>serial-number -> (string)<br/>Allowed serial number in the subject field.<br/>state-or-province -> (string)<br/>Allowed state or province name in the subject field.<br/>surname -> (string)<br/>Allowed surname in the subject field.<br/>title -> (string)<br/>Allowed title in the subject field.|
|`--extended-key-usages-white-list`|<b>`shorthand/json`</b><br/>Whitelist of allowed extended key usages.<br/>Shorthand Syntax:<br/>{<br/>extended-key-usage = SERVER_AUTH\|CLIENT_AUTH\|CODE_SIGNING\|EMAIL_PROTECTION\|TIME_STAMPING\|OCSP_SIGNING\|IPSEC_IKE\|MS_CODE_IND\|MS_CODE_COM\|MS_CTL_SIGN\|MS_EFS,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"extended-key-usage": [<br/>"SERVER_AUTH\|CLIENT_AUTH\|CODE_SIGNING\|EMAIL_PROTECTION\|TIME_STAMPING\|OCSP_SIGNING\|IPSEC_IKE\|MS_CODE_IND\|MS_CODE_COM\|MS_CTL_SIGN\|MS_EFS", ...<br/>]<br/>}"<br/>Fields:<br/>extended-key-usage -> ([]int)<br/>List of extended key usages that are allowed or disallowed.|
|`--extended-key-usages-black-list`|<b>`shorthand/json`</b><br/>Blacklist of disallowed extended key usages.<br/>Shorthand Syntax:<br/>{<br/>extended-key-usage = SERVER_AUTH\|CLIENT_AUTH\|CODE_SIGNING\|EMAIL_PROTECTION\|TIME_STAMPING\|OCSP_SIGNING\|IPSEC_IKE\|MS_CODE_IND\|MS_CODE_COM\|MS_CTL_SIGN\|MS_EFS,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"extended-key-usage": [<br/>"SERVER_AUTH\|CLIENT_AUTH\|CODE_SIGNING\|EMAIL_PROTECTION\|TIME_STAMPING\|OCSP_SIGNING\|IPSEC_IKE\|MS_CODE_IND\|MS_CODE_COM\|MS_CTL_SIGN\|MS_EFS", ...<br/>]<br/>}"<br/>Fields:<br/>extended-key-usage -> ([]int)<br/>List of extended key usages that are allowed or disallowed.|
|`--extension-white-list`|<b>`shorthand/json`</b><br/>Whitelist of allowed extensions.<br/>Shorthand Syntax:<br/>{<br/>extension-oid = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"extension-oid": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>extension-oid -> ([]string)<br/>List of extension OIDs that are allowed or disallowed.|
|`--extension-black-list`|<b>`shorthand/json`</b><br/>Blacklist of disallowed extensions.<br/>Shorthand Syntax:<br/>{<br/>extension-oid = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"extension-oid": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>extension-oid -> ([]string)<br/>List of extension OIDs that are allowed or disallowed.|
|`--key-usages-white-list`|<b>`shorthand/json`</b><br/>Whitelist of allowed key usages.<br/>Shorthand Syntax:<br/>{<br/>key-usage = DIGITAL_SIGNATURE\|CONTENT_COMMITMENT\|KEY_ENCIPHERMENT\|DATA_ENCIPHERMENT\|KEY_AGREEMENT\|KEY_CERT_SIGN\|CRL_SIGN\|ENCIPHER_ONLY\|DECIPHER_ONLY,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"key-usage": [<br/>"DIGITAL_SIGNATURE\|CONTENT_COMMITMENT\|KEY_ENCIPHERMENT\|DATA_ENCIPHERMENT\|KEY_AGREEMENT\|KEY_CERT_SIGN\|CRL_SIGN\|ENCIPHER_ONLY\|DECIPHER_ONLY", ...<br/>]<br/>}"<br/>Fields:<br/>key-usage -> ([]int)<br/>List of key usages that are allowed or disallowed.|
|`--key-usages-black-list`|<b>`shorthand/json`</b><br/>Blacklist of disallowed key usages.<br/>Shorthand Syntax:<br/>{<br/>key-usage = DIGITAL_SIGNATURE\|CONTENT_COMMITMENT\|KEY_ENCIPHERMENT\|DATA_ENCIPHERMENT\|KEY_AGREEMENT\|KEY_CERT_SIGN\|CRL_SIGN\|ENCIPHER_ONLY\|DECIPHER_ONLY,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"key-usage": [<br/>"DIGITAL_SIGNATURE\|CONTENT_COMMITMENT\|KEY_ENCIPHERMENT\|DATA_ENCIPHERMENT\|KEY_AGREEMENT\|KEY_CERT_SIGN\|CRL_SIGN\|ENCIPHER_ONLY\|DECIPHER_ONLY", ...<br/>]<br/>}"<br/>Fields:<br/>key-usage -> ([]int)<br/>List of key usages that are allowed or disallowed.|
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
