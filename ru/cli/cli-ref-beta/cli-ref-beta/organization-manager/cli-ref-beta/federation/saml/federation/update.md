---
editable: false
noIndex: true
---

# yc beta organization-manager federation saml federation update

Updates the specified federation.

#### Command Usage

Syntax:

`yc beta organization-manager federation saml federation update <FEDERATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--auto-create-account-on-login` | Add new users automatically on successful authentication. The user becomes member of the organization automatically, but you need to grant other roles to them. If the value is 'false', users who aren't added to the organization can't log in, even if they have authenticated on your server. ||
|| `--case-insensitive-name-ids` | Use case insensitive name ids. ||
|| `--cookie-max-age` | `duration`

Browser cookie lifetime in seconds. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page. The default value is '8h'. (duration, e.g. 30s, 5m10s) ||
|| `--description` | `string`

Description of the federation. ||
|| `--federation-id` | `string`

ID of the federation to update. To get the federation ID, make a [FederationService.List] request. ||
|| `--issuer` | `string`

ID of the IdP server to be used for authentication. The IdP server also responds to IAM with this ID after the user authenticates. ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs. ||
|| `--name` | `string`

Name of the federation. The name must be unique within the organization. ||
|| `--security-settings` | `shorthand/json`

Federation security settings.

Shorthand Syntax:

```hcl
{
  encrypted-assertions = boolean,
  force-authn = boolean
}
```

JSON Syntax:

```json
{
  "encrypted-assertions": "boolean",
  "force-authn": "boolean"
}
```

Fields:

```
encrypted-assertions -> (boolean)
  Enable encrypted assertions.
force-authn -> (boolean)
  Value parameter ForceAuthn in SAMLRequest.
``` ||
|| `--sso-binding` | `enum`

Single sign-on endpoint binding type. Most Identity Providers support the 'POST' binding type. SAML Binding is a mapping of a SAML protocol message onto standard messaging formats and/or communications protocols. Possible Values: 'post', 'redirect', 'artifact' ||
|| `--sso-url` | `string`

Single sign-on endpoint URL. Specify the link to the IdP login page here. ||
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