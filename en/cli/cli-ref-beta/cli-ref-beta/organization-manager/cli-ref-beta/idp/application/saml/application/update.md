---
editable: false
noIndex: true
---

# yc beta organization-manager idp application saml application update

Updates the specified SAML application.

#### Command Usage

Syntax:

`yc beta organization-manager idp application saml application update <APPLICATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--application-id` | `string`

ID of the SAML application to update. ||
|| `--attribute-mapping` | `shorthand/json`

New attribute mapping configuration for the SAML application.

Shorthand Syntax:

```hcl
{
  attributes = [
    {
      name = string,
      value = string
    }, ...
  ],
  name-id = {
    format = PERSISTENT|EMAIL
  }
}
```

JSON Syntax:

```json
{
  "attributes": [
    {
      "name": "string",
      "value": "string"
    }, ...
  ],
  "name-id": {
    "format": "PERSISTENT|EMAIL"
  }
}
```

Fields:

```
attributes -> ([]struct)
  List of attribute mappings.
  name -> (string)
    Name of the SAML attribute.
  value -> (string)
    Value of the SAML attribute.
name-id -> (struct)
  NameID configuration.
  format -> (struct)
    Format of the NameID.
``` ||
|| `--description` | `string`

New description for the SAML application. ||
|| `--group-claims-settings` | `shorthand/json`

New group claims settings for the SAML application.

Shorthand Syntax:

```hcl
{
  group-attribute-name = string,
  group-distribution-type = NONE|ASSIGNED_GROUPS|ALL_GROUPS
}
```

JSON Syntax:

```json
{
  "group-attribute-name": "string",
  "group-distribution-type": "NONE|ASSIGNED_GROUPS|ALL_GROUPS"
}
```

Fields:

```
group-attribute-name -> (string)
  Name of the SAML attribute that contains group information.
group-distribution-type -> (struct)
  Distribution type for group claims.
``` ||
|| `--labels` | `map<string><string>`

New resource labels as '' key:value '' pairs. ||
|| `--name` | `string`

New name for the SAML application. ||
|| `--security-settings` | `shorthand/json`

New security settings for the SAML application.

Shorthand Syntax:

```hcl
{
  signature-certificate-id = string,
  signature-mode = ASSERTIONS|RESPONSE|RESPONSE_AND_ASSERTIONS
}
```

JSON Syntax:

```json
{
  "signature-certificate-id": "string",
  "signature-mode": "ASSERTIONS|RESPONSE|RESPONSE_AND_ASSERTIONS"
}
```

Fields:

```
signature-certificate-id -> (string)
  ID of the signature certificate to use.
signature-mode -> (struct)
  Signature mode for SAML messages.
``` ||
|| `--service-provider` | `shorthand/json`

New service provider configuration for the SAML application.

Shorthand Syntax:

```hcl
{
  acs-urls = [
    {
      index = integer,
      url = string
    }, ...
  ],
  entity-id = string,
  slo-urls = [
    {
      protocol-binding = HTTP_POST|HTTP_REDIRECT,
      response-url = string,
      url = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "acs-urls": [
    {
      "index": "integer",
      "url": "string"
    }, ...
  ],
  "entity-id": "string",
  "slo-urls": [
    {
      "protocol-binding": "HTTP_POST|HTTP_REDIRECT",
      "response-url": "string",
      "url": "string"
    }, ...
  ]
}
```

Fields:

```
acs-urls -> ([]struct)
  Assertion Consumer Service URLs.
  index -> (integer)
    Optional index for the assertion consumer service.
  url -> (string)
    The URL where SAML responses are sent.
entity-id -> (string)
  Service provider entity ID.
slo-urls -> ([]struct)
  Single Logout Service URLs.
  protocol-binding -> (struct)
    Protocol binding supported by the logout endpoint.
  response-url -> (string)
    Optional separate URL for logout responses.
  url -> (string)
    The URL where logout requests are sent.
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