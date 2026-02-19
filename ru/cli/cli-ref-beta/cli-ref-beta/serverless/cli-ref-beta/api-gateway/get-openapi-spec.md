---
editable: false
noIndex: true
---

# yc beta serverless api-gateway get-openapi-spec

Returns the OpenAPI specification of specified API gateway.

#### Command Usage

Syntax:

`yc beta serverless api-gateway get-openapi-spec <API-GATEWAY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--api-gateway-id` | `string`

ID of the API gateway to get specification from. ||
|| `--format` | `enum`

Format of returned specification. Default is the original format used in [CreateApiGatewayRequest]. Possible Values: 'json', 'yaml' ||
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