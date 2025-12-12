---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/application/saml/application/create.md
---

# yc beta organization-manager idp application saml application create

Creates a SAML application in the specified organization.

#### Command Usage

Syntax: 

`yc beta organization-manager idp application saml application create <ORGANIZATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--attribute-mapping`|<b>`shorthand/json`</b><br/>Attribute mapping configuration for the SAML application.<br/>Shorthand Syntax:<br/>{<br/>attributes = [<br/>{<br/>name = str,<br/>value = str<br/>}, ...<br/>],<br/>name-id = {<br/>format = PERSISTENT\|EMAIL<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"attributes": [<br/>{<br/>"name": "str",<br/>"value": "str"<br/>}, ...<br/>],<br/>"name-id": {<br/>"format": "PERSISTENT\|EMAIL"<br/>}<br/>}"<br/>Fields:<br/>attributes -> ([]struct)<br/>List of attribute mappings.<br/>name -> (string)<br/>Name of the SAML attribute.<br/>value -> (string)<br/>Value of the SAML attribute.<br/>name-id -> (struct)<br/>NameID configuration.<br/>format -> (enum<EMAIL\|PERSISTENT>)<br/>Format of the NameID.|
|`--description`|<b>`string`</b><br/>Description of the SAML application.|
|`--group-claims-settings`|<b>`shorthand/json`</b><br/>Group claims settings for the SAML application.<br/>Shorthand Syntax:<br/>{<br/>group-attribute-name = str,<br/>group-distribution-type = NONE\|ASSIGNED_GROUPS\|ALL_GROUPS<br/>}<br/>JSON Syntax:<br/>"{<br/>"group-attribute-name": "str",<br/>"group-distribution-type": "NONE\|ASSIGNED_GROUPS\|ALL_GROUPS"<br/>}"<br/>Fields:<br/>group-attribute-name -> (string)<br/>Name of the SAML attribute that contains group information.<br/>group-distribution-type -> (enum<ALL_GROUPS\|ASSIGNED_GROUPS\|NONE>)<br/>Distribution type for group claims.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>Name of the SAML application.|
|`--organization-id`|<b>`string`</b><br/>ID of the organization to create the application in.|
|`--security-settings`|<b>`shorthand/json`</b><br/>Security settings for the SAML application.<br/>Shorthand Syntax:<br/>{<br/>signature-mode = ASSERTIONS\|RESPONSE\|RESPONSE_AND_ASSERTIONS<br/>}<br/>JSON Syntax:<br/>"{<br/>"signature-mode": "ASSERTIONS\|RESPONSE\|RESPONSE_AND_ASSERTIONS"<br/>}"<br/>Fields:<br/>signature-mode -> (enum<ASSERTIONS\|RESPONSE\|RESPONSE_AND_ASSERTIONS>)<br/>Signature mode for SAML assertions and responses.|
|`--service-provider`|<b>`shorthand/json`</b><br/>Service provider configuration for the SAML application.<br/>Shorthand Syntax:<br/>{<br/>acs-urls = [<br/>{<br/>index = int,<br/>url = str<br/>}, ...<br/>],<br/>entity-id = str,<br/>slo-urls = [<br/>{<br/>protocol-binding = HTTP_POST\|HTTP_REDIRECT,<br/>response-url = str,<br/>url = str<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"acs-urls": [<br/>{<br/>"index": "int",<br/>"url": "str"<br/>}, ...<br/>],<br/>"entity-id": "str",<br/>"slo-urls": [<br/>{<br/>"protocol-binding": "HTTP_POST\|HTTP_REDIRECT",<br/>"response-url": "str",<br/>"url": "str"<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>acs-urls -> ([]struct)<br/>Assertion Consumer Service URLs.<br/>index -> (int)<br/>Optional index for the assertion consumer service.<br/>url -> (string)<br/>The URL where SAML responses are sent.<br/>entity-id -> (string)<br/>Service provider entity ID.<br/>slo-urls -> ([]struct)<br/>Single Logout Service URLs.<br/>protocol-binding -> (enum<HTTP_POST\|HTTP_REDIRECT>)<br/>Protocol binding supported by the logout endpoint.<br/>response-url -> (string)<br/>Optional separate URL for logout responses.<br/>url -> (string)<br/>The URL where logout requests are sent.|
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
