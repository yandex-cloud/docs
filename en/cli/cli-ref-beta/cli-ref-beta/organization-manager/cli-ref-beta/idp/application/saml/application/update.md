---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/application/saml/application/update.md
---

# yc beta organization-manager idp application saml application update

Updates the specified SAML application.

#### Command Usage

Syntax: 

`yc beta organization-manager idp application saml application update <APPLICATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--application-id`|<b>`string`</b><br/>ID of the SAML application to update.|
|`--attribute-mapping`|<b>`shorthand/json`</b><br/>New attribute mapping configuration for the SAML application.<br/><br/>Example:|
|`--attribute-mapping`|<b>`attributes=[{name=value,`</b><br/>value=value}], name-id={format=PERSISTENT}<br/><br/>Shorthand Syntax:<br/>{attributes=[{name=str, value=str},...], name-id={format=PERSISTENT\|EMAIL}}<br/>Fields:<br/>attributes  []struct            — List of attribute mappings.<br/>name   string  required  — Name of the SAML attribute.<br/>value  string  required  — Value of the SAML attribute.<br/>name-id     struct    required  — NameID configuration.<br/>format  enum<EMAIL\|PERSISTENT>  required  — Format of the NameID.<br/>|
|`--description`|<b>`string`</b><br/>New description for the SAML application.|
|`--group-claims-settings`|<b>`shorthand/json`</b><br/>New group claims settings for the SAML application.<br/><br/>Example:|
|`--group-claims-settings`|<b>`group-attribute-name=value,`</b><br/>group-distribution-type=NONE<br/><br/>Shorthand Syntax:<br/>{group-attribute-name=str, group-distribution-type=NONE\|ASSIGNED_GROUPS\|ALL_GROUPS}<br/>Fields:<br/>group-attribute-name     string                                 — Name of the SAML attribute that contains group information.<br/>group-distribution-type  enum<ALL_GROUPS\|ASSIGNED_GROUPS\|NONE>  — Distribution type for group claims.<br/>|
|`--labels`|<b>`stringToString`</b><br/>New resource labels as '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>New name for the SAML application.|
|`--security-settings`|<b>`shorthand/json`</b><br/>New security settings for the SAML application.<br/><br/>Example:|
|`--security-settings`|<b>`signature-certificate-id=value,`</b><br/>signature-mode=ASSERTIONS<br/><br/>Shorthand Syntax:<br/>{signature-certificate-id=str, signature-mode=ASSERTIONS\|RESPONSE\|RESPONSE_AND_ASSERTIONS}<br/>Fields:<br/>signature-certificate-id  string                                             — ID of the signature certificate to use.<br/>signature-mode            enum<ASSERTIONS\|RESPONSE\|RESPONSE_AND_ASSERTIONS>  — Signature mode for SAML messages.<br/>|
|`--service-provider`|<b>`shorthand/json`</b><br/>New service provider configuration for the SAML application.<br/><br/>Example:|
|`--service-provider`|<b>`acs-urls=[{index=42,`</b><br/>url=value}], entity-id=value, slo-urls=[{protocol-binding=HTTP_POST, response-url=value, url=value}]<br/><br/>Shorthand Syntax:<br/>{acs-urls=[{index=int, url=str},...], entity-id=str, slo-urls=[{protocol-binding=HTTP_POST\|HTTP_REDIRECT, response-url=str, url=str},...]}<br/>Fields:<br/>acs-urls   []struct            — Assertion Consumer Service URLs.<br/>index  int               — Optional index for the assertion consumer service.<br/>url    string  required  — The URL where SAML responses are sent.<br/>entity-id  string    required  — Service provider entity ID.<br/>slo-urls   []struct            — Single Logout Service URLs.<br/>protocol-binding  enum<HTTP_POST\|HTTP_REDIRECT>  required  — Protocol binding supported by the logout endpoint.<br/>response-url      string                                   — Optional separate URL for logout responses.<br/>url               string                         required  — The URL where logout requests are sent.<br/>|
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
