---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-opensearch/cli-ref-beta/cluster/update-auth-settings.md
---

# yc beta managed-opensearch cluster update-auth-settings

Updates auth settings for specified cluster.

#### Command Usage

Syntax: 

`yc beta managed-opensearch cluster update-auth-settings <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>Required. ID of the OpenSearch cluster.|
|`--settings`|<b>`shorthand/json`</b><br/>Required. Auth settings.<br/><br/>Example:|
|`--settings`|<b>`saml={dashboards-url=value,`</b><br/>enabled=true, idp-entity-id=value, idp-metadata-file=1, jwt-default-expiration-timeout=42, roles-key=value, sp-entity-id=value, subject-key=value}<br/><br/>Shorthand Syntax:<br/>{saml={dashboards-url=str, enabled=bool, idp-entity-id=str, idp-metadata-file=uint,..., jwt-default-expiration-timeout=int, roles-key=str, sp-entity-id=str, subject-key=str}}<br/>Fields:<br/>saml  struct  — SAML settings<br/>dashboards-url                  string  — Required. The OpenSearch Dashboards base URL.<br/>enabled                         bool    —<br/>idp-entity-id                   string  — Required. The entity ID of your IdP.<br/>idp-metadata-file               bytes   — Required. The SAML 2.0 metadata file of your IdP.<br/>jwt-default-expiration-timeout  int     — default jwt expiration timeout.<br/>roles-key                       string  — Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used.<br/>sp-entity-id                    string  — Required. The entity ID of the service provider.<br/>subject-key                     string  — Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used.<br/>|
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
