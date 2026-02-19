---
editable: false
noIndex: true
---

# yc beta certificate-manager policy create

Creates a policy for the specified certificate authority.
A policy defines the rules and constraints for issuing certificates within a certificate authority.
For example, you can specify allowed or disallowed key usages, extensions, and subject fields.

#### Command Usage

Syntax:

`yc beta certificate-manager policy create <CERTIFICATE-AUTHORITY-ID>`

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
|| `--certificate-authority-id` | `string`

ID of the certificate authority to create a policy for. ||
|| `--name` | `string`

Name of the policy. ||
|| `--san-policy` | `shorthand/json`

Policy for the subject alternative name (SAN) field of the certificate.

Shorthand Syntax:

```hcl
{
  directory-name = string,
  dns-name = string,
  edi-party-name = {
    name-assigner = string,
    party-name = string
  },
  ip-address = string,
  other-name-oid = string,
  registered-id = string,
  rfc-822-name = string,
  uniform-resource-identifier = string
}
```

JSON Syntax:

```json
{
  "directory-name": "string",
  "dns-name": "string",
  "edi-party-name": {
    "name-assigner": "string",
    "party-name": "string"
  },
  "ip-address": "string",
  "other-name-oid": "string",
  "registered-id": "string",
  "rfc-822-name": "string",
  "uniform-resource-identifier": "string"
}
```

Fields:

```
directory-name -> (string)
  Allowed directory names in the SAN field.
dns-name -> (string)
  Allowed DNS names in the SAN field.
edi-party-name -> (struct)
  Allowed EDI party names in the SAN field.
  name-assigner -> (string)
    Specifies the entity or authority that assigned the partyName
  party-name -> (string)
    The actual identifier of the EDI party
ip-address -> (string)
  Allowed IP addresses in the SAN field.
other-name-oid -> (string)
  Allowed OIDs of the other name in the SAN field.
registered-id -> (string)
  Allowed registered IDs in the SAN field.
rfc-822-name -> (string)
  Allowed RFC 822 names (email addresses) in the SAN field.
uniform-resource-identifier -> (string)
  Allowed URIs in the SAN field.
``` ||
|| `--subject-policy` | `shorthand/json`

Policy for the subject field of the certificate.

Shorthand Syntax:

```hcl
{
  common-name = string,
  country = string,
  distinguished-name-qualifier = string,
  email-address = string,
  generation-qualifier = string,
  given-name = string,
  initials = string,
  locality = string,
  organization = string,
  organizational-unit = string,
  serial-number = string,
  state-or-province = string,
  surname = string,
  title = string
}
```

JSON Syntax:

```json
{
  "common-name": "string",
  "country": "string",
  "distinguished-name-qualifier": "string",
  "email-address": "string",
  "generation-qualifier": "string",
  "given-name": "string",
  "initials": "string",
  "locality": "string",
  "organization": "string",
  "organizational-unit": "string",
  "serial-number": "string",
  "state-or-province": "string",
  "surname": "string",
  "title": "string"
}
```

Fields:

```
common-name -> (string)
  Allowed common name in the subject field.
country -> (string)
  Allowed country name in the subject field.
distinguished-name-qualifier -> (string)
  Allowed distinguished name qualifier in the subject field.
email-address -> (string)
  Allowed email address in the subject field.
generation-qualifier -> (string)
  Allowed generation qualifier in the subject field.
given-name -> (string)
  Allowed given name in the subject field.
initials -> (string)
  Allowed initials in the subject field.
locality -> (string)
  Allowed locality name in the subject field.
organization -> (string)
  Allowed organization name in the subject field.
organizational-unit -> (string)
  Allowed organizational unit name in the subject field.
serial-number -> (string)
  Allowed serial number in the subject field.
state-or-province -> (string)
  Allowed state or province name in the subject field.
surname -> (string)
  Allowed surname in the subject field.
title -> (string)
  Allowed title in the subject field.
``` ||
|| `--extended-key-usages-white-list` | `shorthand/json`

Whitelist of allowed extended key usages.

Shorthand Syntax:

```hcl
{
  extended-key-usage = [
    SERVER_AUTH|CLIENT_AUTH|CODE_SIGNING|EMAIL_PROTECTION|TIME_STAMPING|OCSP_SIGNING|IPSEC_IKE|MS_CODE_IND|MS_CODE_COM|MS_CTL_SIGN|MS_EFS, ...
  ]
}
```

JSON Syntax:

```json
{
  "extended-key-usage": [
    "SERVER_AUTH|CLIENT_AUTH|CODE_SIGNING|EMAIL_PROTECTION|TIME_STAMPING|OCSP_SIGNING|IPSEC_IKE|MS_CODE_IND|MS_CODE_COM|MS_CTL_SIGN|MS_EFS", ...
  ]
}
```

Fields:

```
extended-key-usage -> ([]struct)
  List of extended key usages that are allowed or disallowed.
``` ||
|| `--extended-key-usages-black-list` | `shorthand/json`

Blacklist of disallowed extended key usages.

Shorthand Syntax:

```hcl
{
  extended-key-usage = [
    SERVER_AUTH|CLIENT_AUTH|CODE_SIGNING|EMAIL_PROTECTION|TIME_STAMPING|OCSP_SIGNING|IPSEC_IKE|MS_CODE_IND|MS_CODE_COM|MS_CTL_SIGN|MS_EFS, ...
  ]
}
```

JSON Syntax:

```json
{
  "extended-key-usage": [
    "SERVER_AUTH|CLIENT_AUTH|CODE_SIGNING|EMAIL_PROTECTION|TIME_STAMPING|OCSP_SIGNING|IPSEC_IKE|MS_CODE_IND|MS_CODE_COM|MS_CTL_SIGN|MS_EFS", ...
  ]
}
```

Fields:

```
extended-key-usage -> ([]struct)
  List of extended key usages that are allowed or disallowed.
``` ||
|| `--extension-white-list` | `shorthand/json`

Whitelist of allowed extensions.

Shorthand Syntax:

```hcl
{
  extension-oid = string,...
}
```

JSON Syntax:

```json
{
  "extension-oid": [
    "string", ...
  ]
}
```

Fields:

```
extension-oid -> ([]string)
  List of extension OIDs that are allowed or disallowed.
``` ||
|| `--extension-black-list` | `shorthand/json`

Blacklist of disallowed extensions.

Shorthand Syntax:

```hcl
{
  extension-oid = string,...
}
```

JSON Syntax:

```json
{
  "extension-oid": [
    "string", ...
  ]
}
```

Fields:

```
extension-oid -> ([]string)
  List of extension OIDs that are allowed or disallowed.
``` ||
|| `--key-usages-white-list` | `shorthand/json`

Whitelist of allowed key usages.

Shorthand Syntax:

```hcl
{
  key-usage = [
    DIGITAL_SIGNATURE|CONTENT_COMMITMENT|KEY_ENCIPHERMENT|DATA_ENCIPHERMENT|KEY_AGREEMENT|KEY_CERT_SIGN|CRL_SIGN|ENCIPHER_ONLY|DECIPHER_ONLY, ...
  ]
}
```

JSON Syntax:

```json
{
  "key-usage": [
    "DIGITAL_SIGNATURE|CONTENT_COMMITMENT|KEY_ENCIPHERMENT|DATA_ENCIPHERMENT|KEY_AGREEMENT|KEY_CERT_SIGN|CRL_SIGN|ENCIPHER_ONLY|DECIPHER_ONLY", ...
  ]
}
```

Fields:

```
key-usage -> ([]struct)
  List of key usages that are allowed or disallowed.
``` ||
|| `--key-usages-black-list` | `shorthand/json`

Blacklist of disallowed key usages.

Shorthand Syntax:

```hcl
{
  key-usage = [
    DIGITAL_SIGNATURE|CONTENT_COMMITMENT|KEY_ENCIPHERMENT|DATA_ENCIPHERMENT|KEY_AGREEMENT|KEY_CERT_SIGN|CRL_SIGN|ENCIPHER_ONLY|DECIPHER_ONLY, ...
  ]
}
```

JSON Syntax:

```json
{
  "key-usage": [
    "DIGITAL_SIGNATURE|CONTENT_COMMITMENT|KEY_ENCIPHERMENT|DATA_ENCIPHERMENT|KEY_AGREEMENT|KEY_CERT_SIGN|CRL_SIGN|ENCIPHER_ONLY|DECIPHER_ONLY", ...
  ]
}
```

Fields:

```
key-usage -> ([]struct)
  List of key usages that are allowed or disallowed.
``` ||
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