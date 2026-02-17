---
editable: false
---

# yc organization-manager idp application saml application create

Create a SAML application

#### Command Usage

Syntax:

`yc organization-manager idp application saml application create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--organization-id` | `string`

Set the ID of the organization to use. ||
|| `--name` | `string`

A name of the SAML application. ||
|| `--description` | `string`

Specifies a textual description of the SAML application. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--group-distribution-type` | `string`

Specifies the group distribution type for the SAML application. Values: 'none', 'assigned-groups', 'all-groups' ||
|| `--group-attribute-name` | `string`

Name of the SAML attribute that contains group information. ||
|| `--entity-id` | `string`

Service provider entity ID. ||
|| `--acs-url` | `value[,value]`

Assertion Consumer Service URL. Can be specified multiple times. ||
|| `--acs-url-index` | `value[,value]`

Optional index for ACS URL. Must be specified for all --acs-url flags or omitted entirely. Example: --acs-url url1 --acs-url-index 1 --acs-url url2 --acs-url-index 0 ||
|| `--slo-url` | `value[,value]`

Single Logout Service URL. Can be specified multiple times. ||
|| `--slo-response-url` | `value[,value]`

Optional response URL for SLO. Must match the number of --slo-url flags if provided. Use empty string ("") for not specified response URLs. ||
|| `--slo-protocol-binding` | `value[,value]`

Protocol binding for SLO (HTTP_POST or HTTP_REDIRECT). Required and must match the number of --slo-url flags. ||
|| `--signature-mode` | `string`

Signature mode for SAML assertions and responses (ASSERTIONS, RESPONSE, or RESPONSE_AND_ASSERTIONS). Values: 'assertions', 'response', 'response-and-assertions' ||
|| `--name-id-format` | `string`

NameID format (PERSISTENT or EMAIL). Values: 'persistent', 'email' ||
|| `--attribute` | `value[,value]`

Attribute mapping in format 'name=value'. Can be specified multiple times. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#