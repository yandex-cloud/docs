---
editable: false
noIndex: true
---

# yc beta certificate-manager private-certificate-authority generate-certificate-authority

Generates a new Certificate Authority (CA).
This endpoint creates a new CA with given properties and cryptographic settings.

#### Command Usage

Syntax:

`yc beta certificate-manager private-certificate-authority generate-certificate-authority <FOLDER-ID>`

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
|| `--algorithm` | `enum`

The algorithm for the asymmetric key generation (e.g., RSA, ECC). Possible Values: 'rsa-2048-pss-sha-256', 'rsa-2048-pss-sha-384', 'rsa-2048-pss-sha-512', 'rsa-3072-pss-sha-256', 'rsa-3072-pss-sha-384', 'rsa-3072-pss-sha-512', 'rsa-4096-pss-sha-256', 'rsa-4096-pss-sha-384', 'rsa-4096-pss-sha-512', 'ecdsa-nist-p256-sha-256', 'ecdsa-nist-p384-sha-384', 'ecdsa-nist-p521-sha-512', 'ecdsa-secp256-k1-sha-256', 'rsa-2048-pkcs1-5-sha-256', 'rsa-2048-pkcs1-5-sha-384', 'rsa-2048-pkcs1-5-sha-512', 'rsa-3072-pkcs1-5-sha-256', 'rsa-3072-pkcs1-5-sha-384', 'rsa-3072-pkcs1-5-sha-512', 'rsa-4096-pkcs1-5-sha-256', 'rsa-4096-pkcs1-5-sha-384', 'rsa-4096-pkcs1-5-sha-512' ||
|| `--deletion-protection` | Protect the CA from accidental deletion. Deny deletion of ca if set ||
|| `--description` | `string`

An optional description of the Certificate Authority. ||
|| `--enable-crl` | Enable Certificate Revocation List (CRL) support. ||
|| `--enable-ocsp` | Enable Online Certificate Status Protocol (OCSP) support. ||
|| `--end-entities-ttl-limit-days` | `int`

TTL limit in days for end-entities signed by the CA. ||
|| `--extended-key-usage` | `shorthand/json`

Extended key usage (e.g., serverAuth, clientAuth).

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
|| `--folder-id` | `string`

Folder ID where the CA is being created. ||
|| `--key-usage` | `shorthand/json`

Key usage (e.g., keyEncipherment, digitalSignature).

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

The name of the Certificate Authority. ||
|| `--parent-certificate-authority-id` | `string`

Optional. If set intermediate CA would be generated and signed on parent CA ||
|| `--path-len` | `int`

The maximum length of the certificate chain. ||
|| `--subject-spec` | `shorthand/json`

The subject (e.g., common name, organization, etc.) for the CA.

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