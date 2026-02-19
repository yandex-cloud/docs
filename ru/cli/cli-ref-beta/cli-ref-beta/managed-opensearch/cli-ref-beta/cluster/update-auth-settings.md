---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster update-auth-settings

Updates auth settings for specified cluster.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster update-auth-settings <CLUSTER-ID>`

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
|| `--cluster-id` | `string`

Required. ID of the OpenSearch cluster. ||
|| `--settings` | `shorthand/json`

Required. Auth settings.

Shorthand Syntax:

```hcl
{
  saml = {
    dashboards-url = string,
    enabled = boolean,
    idp-entity-id = string,
    idp-metadata-file = uint,...,
    jwt-default-expiration-timeout = integer,
    roles-key = string,
    sp-entity-id = string,
    subject-key = string
  }
}
```

JSON Syntax:

```json
{
  "saml": {
    "dashboards-url": "string",
    "enabled": "boolean",
    "idp-entity-id": "string",
    "idp-metadata-file": [
      "uint", ...
    ],
    "jwt-default-expiration-timeout": "integer",
    "roles-key": "string",
    "sp-entity-id": "string",
    "subject-key": "string"
  }
}
```

Fields:

```
saml -> (struct)
  SAML settings
  dashboards-url -> (string)
    Required. The OpenSearch Dashboards base URL.
  enabled -> (boolean)
  idp-entity-id -> (string)
    Required. The entity ID of your IdP.
  idp-metadata-file -> (bytes)
    Required. The SAML 2.0 metadata file of your IdP.
  jwt-default-expiration-timeout -> (integer)
    default jwt expiration timeout.
  roles-key -> (string)
    Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used.
  sp-entity-id -> (string)
    Required. The entity ID of the service provider.
  subject-key -> (string)
    Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used.
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