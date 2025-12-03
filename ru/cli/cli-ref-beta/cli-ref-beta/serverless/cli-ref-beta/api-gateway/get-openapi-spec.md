---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/api-gateway/get-openapi-spec.md
---

# yc beta serverless api-gateway get-openapi-spec

Returns the OpenAPI specification of specified API gateway.

#### Command Usage

Syntax: 

`yc beta serverless api-gateway get-openapi-spec <API-GATEWAY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--api-gateway-id`|<b>`string`</b><br/>ID of the API gateway to get specification from.|
|`--format`|<b>`enum`</b><br/>Format of returned specification. Default is the original format used in [CreateApiGatewayRequest]. Possible Values: 'json', 'yaml'|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
