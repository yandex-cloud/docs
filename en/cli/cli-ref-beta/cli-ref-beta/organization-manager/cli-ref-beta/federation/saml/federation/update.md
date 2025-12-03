---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/federation/saml/federation/update.md
---

# yc beta organization-manager federation saml federation update

Updates the specified federation.

#### Command Usage

Syntax: 

`yc beta organization-manager federation saml federation update <FEDERATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--auto-create-account-on-login`|Add new users automatically on successful authentication.<br/>The user becomes member of the organization automatically,<br/>but you need to grant other roles to them.<br/><br/>If the value is 'false', users who aren't added to the organization<br/>can't log in, even if they have authenticated on your server.|
|`--case-insensitive-name-ids`|Use case insensitive name ids.|
|`--cookie-max-age`|<b>`duration`</b><br/>Browser cookie lifetime in seconds.<br/>If the cookie is still valid, the management console<br/>authenticates the user immediately and redirects them to the home page.<br/>The default value is '8h'. (duration, e.g. 30s, 5m10s)|
|`--description`|<b>`string`</b><br/>Description of the federation.|
|`--federation-id`|<b>`string`</b><br/>ID of the federation to update.<br/>To get the federation ID, make a [FederationService.List] request.|
|`--issuer`|<b>`string`</b><br/>ID of the IdP server to be used for authentication.<br/>The IdP server also responds to IAM with this ID after the user authenticates.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>Name of the federation.<br/>The name must be unique within the organization.|
|`--security-settings`|<b>`shorthand/json`</b><br/>Federation security settings.<br/><br/>Example:|
|`--security-settings`|<b>`encrypted-assertions=true,`</b><br/>force-authn=true<br/><br/>Shorthand Syntax:<br/>{encrypted-assertions=bool, force-authn=bool}<br/>Fields:<br/>encrypted-assertions  bool  — Enable encrypted assertions.<br/>force-authn           bool  — Value parameter ForceAuthn in SAMLRequest.<br/>|
|`--sso-binding`|<b>`enum`</b><br/>Single sign-on endpoint binding type. Most Identity Providers support the 'POST' binding type.<br/><br/>SAML Binding is a mapping of a SAML protocol message onto standard messaging<br/>formats and/or communications protocols. Possible Values: 'post', 'redirect', 'artifact'|
|`--sso-url`|<b>`string`</b><br/>Single sign-on endpoint URL.<br/>Specify the link to the IdP login page here.|
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
