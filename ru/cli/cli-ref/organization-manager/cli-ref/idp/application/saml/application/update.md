---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/organization-manager/cli-ref/idp/application/saml/application/update/
---

# yc organization-manager idp application saml application update

Update the specified SAML application

#### Command Usage

Syntax:

`yc organization-manager idp application saml application update <SAML-APPLICATION-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

SAML application id. ||
|| `--organization-id` | `string`

Set the ID of the organization to use. ||
|| `--new-name` | `string`

A new name of the SAML application. ||
|| `--description` | `string`

Specifies a textual description of the SAML application. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--group-distribution-type` | `string`

Specifies the group distribution type for the SAML application. Values: 'none', 'assigned-groups', 'all-groups' ||
|| `--group-attribute-value` | `string`

Source of the group value provided to the application. Values: 'name', 'id', 'external-id' ||
|| `--group-attribute-name` | `string`

Name of the SAML attribute that contains group information. ||
|| `--entity-id` | `string`

Service provider entity ID. ||
|| `--acs-url` | `[]string`

Assertion Consumer Service URL. Can be specified multiple times. ||
|| `--acs-url-index` | `[]string`

Optional index for ACS URL. Must be specified for all --acs-url flags or omitted entirely. Example: --acs-url url1 --acs-url-index 1 --acs-url url2 --acs-url-index 0 ||
|| `--slo-url` | `[]string`

Single Logout Service URL. Can be specified multiple times. ||
|| `--slo-response-url` | `[]string`

Optional response URL for SLO. Must match the number of --slo-url flags if provided. Use empty string ("") for not specified response URLs. ||
|| `--slo-protocol-binding` | `[]string`

Protocol binding for SLO (HTTP_POST or HTTP_REDIRECT). Required and must match the number of --slo-url flags. ||
|| `--signature-mode` | `string`

Signature mode for SAML assertions and responses (ASSERTIONS, RESPONSE, or RESPONSE_AND_ASSERTIONS). Values: 'assertions', 'response', 'response-and-assertions' ||
|| `--signature-certificate-id` | `string`

ID of the signature certificate to use. ||
|| `--name-id-format` | `string`

NameID format (PERSISTENT or EMAIL). Values: 'persistent', 'email' ||
|| `--attribute` | `[]string`

Attribute mapping in format 'name=value'. Can be specified multiple times. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#