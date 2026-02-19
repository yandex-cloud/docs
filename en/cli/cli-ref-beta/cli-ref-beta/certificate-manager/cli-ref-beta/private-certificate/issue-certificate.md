---
editable: false
noIndex: true
---

# yc beta certificate-manager private-certificate issue-certificate

Issues a new certificate for a given Certificate Authority (CA).

#### Command Usage

Syntax:

`yc beta certificate-manager private-certificate issue-certificate <CERTIFICATE-AUTHORITY-ID>`

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

The ID of the Certificate Authority (CA) that will issue this certificate. ||
|| `--deletion-protection` | Flag to protect the certificate from being accidentally deleted. ||
|| `--description` | `string`

A description of the certificate. ||
|| `--desired-ttl-days` | `int`

Desired time-to-live (TTL) of the certificate in days. ||
|| `--extended-key-usage` | `shorthand/json`

List of extended purposes of the certificate, such as serverAuth or clientAuth.

Shorthand Syntax:

```hcl
[
  SERVER_AUTH|CLIENT_AUTH|CODE_SIGNING|EMAIL_PROTECTION|TIME_STAMPING|OCSP_SIGNING|IPSEC_IKE|MS_CODE_IND|MS_CODE_COM|MS_CTL_SIGN|MS_EFS, ...
]
```

JSON Syntax:

```json
[
  "SERVER_AUTH|CLIENT_AUTH|CODE_SIGNING|EMAIL_PROTECTION|TIME_STAMPING|OCSP_SIGNING|IPSEC_IKE|MS_CODE_IND|MS_CODE_COM|MS_CTL_SIGN|MS_EFS", ...
]
``` ||
|| `--key-usage` | `shorthand/json`

List of purposes of the certificate, such as digitalSignature or keyEncipherment.

Shorthand Syntax:

```hcl
[
  DIGITAL_SIGNATURE|CONTENT_COMMITMENT|KEY_ENCIPHERMENT|DATA_ENCIPHERMENT|KEY_AGREEMENT|KEY_CERT_SIGN|CRL_SIGN|ENCIPHER_ONLY|DECIPHER_ONLY, ...
]
```

JSON Syntax:

```json
[
  "DIGITAL_SIGNATURE|CONTENT_COMMITMENT|KEY_ENCIPHERMENT|DATA_ENCIPHERMENT|KEY_AGREEMENT|KEY_CERT_SIGN|CRL_SIGN|ENCIPHER_ONLY|DECIPHER_ONLY", ...
]
``` ||
|| `--name` | `string`

The name of the certificate. ||
|| `--signing-algorithm` | `enum`

The algorithm the CA will use to sign and issue the certificate. Possible Values: 'rsa-2048-pss-sha-256', 'rsa-2048-pss-sha-384', 'rsa-2048-pss-sha-512', 'rsa-3072-pss-sha-256', 'rsa-3072-pss-sha-384', 'rsa-3072-pss-sha-512', 'rsa-4096-pss-sha-256', 'rsa-4096-pss-sha-384', 'rsa-4096-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256', 'rsa-2048-pkcs1-5-sha-256', 'rsa-2048-pkcs1-5-sha-384', 'rsa-2048-pkcs1-5-sha-512', 'rsa-3072-pkcs1-5-sha-256', 'rsa-3072-pkcs1-5-sha-384', 'rsa-3072-pkcs1-5-sha-512', 'rsa-4096-pkcs1-5-sha-256', 'rsa-4096-pkcs1-5-sha-384', 'rsa-4096-pkcs1-5-sha-512' ||
|| `--subject` | `shorthand/json`

Details about the certificate subject (e.g., CN, O, etc.).

Shorthand Syntax:

```hcl
{
  additional-rdn = {
    generation-qualifier = string,
    given-name = string,
    initials = string,
    locality = string,
    serial-number = string,
    surname = string,
    title = string
  },
  base-rdn = {
    common-name = string,
    country = string,
    distinguished-name-qualifier = string,
    email-address = string,
    organization = string,
    organizational-unit = string,
    state-or-province = string
  }
}
```

JSON Syntax:

```json
{
  "additional-rdn": {
    "generation-qualifier": "string",
    "given-name": "string",
    "initials": "string",
    "locality": "string",
    "serial-number": "string",
    "surname": "string",
    "title": "string"
  },
  "base-rdn": {
    "common-name": "string",
    "country": "string",
    "distinguished-name-qualifier": "string",
    "email-address": "string",
    "organization": "string",
    "organizational-unit": "string",
    "state-or-province": "string"
  }
}
```

Fields:

```
additional-rdn -> (struct)
  Additional fields of subject
  generation-qualifier -> (string)
    Generation qualifier of certificate subject in arbitrary form.
  given-name -> (string)
    Given name of certificate subject in arbitrary form.
  initials -> (string)
    Initials of certificate subject in arbitrary form.
  locality -> (string)
    Locality of certificate subject in arbitrary form.
  serial-number -> (string)
    Serial number of certificate subject in arbitrary form. Don't confuse with certificate serial number.
  surname -> (string)
    Surname of certificate subject in arbitrary form.
  title -> (string)
    Title of certificate subject in arbitrary form.
base-rdn -> (struct)
  Most used field of subject
  common-name -> (string)
    Common name. For tls certificates it is domain usually.
  country -> (string)
    Two letter county code
  distinguished-name-qualifier -> (string)
    Distinguished name qualifier
  email-address -> (string)
    Email address of certificate owner
  organization -> (string)
    Organization name in arbitrary form
  organizational-unit -> (string)
    Organizational unit name in arbitrary form
  state-or-province -> (string)
    State or province name in arbitrary form
``` ||
|| `--subject-alternative-names` | `shorthand/json`

Subject Alternative Names (SANs) for the certificate, such as DNS entries or IP addresses.

Shorthand Syntax:

```hcl
[
  {
    san = directory-name=string | dns-name=string | edi-party-name={
      name-assigner = string,
      party-name = string
    } | ip-address=string | other-name={
      name = string,
      type-oid = string
    } | registered-id=string | rfc-822-name=string | uniform-resource-identifier=string | x-400-name=string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "san": {
      "directory-name": "string",
      "dns-name": "string",
      "edi-party-name": {
        "name-assigner": "string",
        "party-name": "string"
      },
      "ip-address": "string",
      "other-name": {
        "name": "string",
        "type-oid": "string"
      },
      "registered-id": "string",
      "rfc-822-name": "string",
      "uniform-resource-identifier": "string",
      "x-400-name": "string"
    }
  }, ...
]
```

Fields:

```
san -> (oneof<directory-name|dns-name|edi-party-name|ip-address|other-name|registered-id|rfc-822-name|uniform-resource-identifier|x-400-name>)
  Oneof san field
  other-name -> (struct)
    Local defined identifier in arbitrary form
    name -> (string)
      DER encoded value of type with type_oid
    type-oid -> (string)
      Object identifier for name type
  rfc-822-name -> (string)
    Encoded email address
  dns-name -> (string)
    Widely used in tls certificates for domains
  x-400-name -> (string)
    x400 name https://en.wikipedia.org/wiki/X.400
  directory-name -> (string)
    Represents sequence of rdn for uniquely identifying entities
  edi-party-name -> (struct)
    Electronic Data Interchange entity
    name-assigner -> (string)
      Specifies the entity or authority that assigned the partyName
    party-name -> (string)
      The actual identifier of the EDI party
  uniform-resource-identifier -> (string)
    URI
  ip-address -> (string)
    ip address of certificate subject. May be used in tls certificates
  registered-id -> (string)
    Object Identifier (OID)
``` ||
|| `--template-id` | `string`

Optional certificate template ID. Issue certificate with template's fields if non-empty. ||
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