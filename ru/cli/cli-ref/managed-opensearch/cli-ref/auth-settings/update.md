---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-opensearch/cli-ref/auth-settings/update.md
---

# yc managed-opensearch auth-settings update

Update authorization settings for a managed OpenSearch cluster.

#### Command Usage

Syntax: 

`yc managed-opensearch auth-settings update <CLUSTER-NAME>|<CLUSTER-ID> [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--id`|<b>`string`</b><br/>ID of the OpenSearch cluster.|
|`--name`|<b>`string`</b><br/>Name of the OpenSearch cluster.|
|`--saml`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Settings for authentication through SAML.<br/><br/>Possible property names:<br/><ul> <li><code>enabled</code>:     Enable authentication through SAML.</li> <li><code>idp-entity-id</code>:     The entity ID of your IdP. Required.</li> <li><code>idp-metadata-file</code>:     The path to the SAML 2.0 metadata file of your IdP. Required</li> <li><code>sp-entity-id</code>:     The entity ID of the service provider. Required.</li> <li><code>dashboards-url</code>:     The OpenSearch Dashboards base URL. Required.</li> <li><code>subject-key</code>:     The attribute in the SAML response where the subject is stored. Optional. If not configured, the NameID attribute is used.</li> <li><code>roles-key</code>:     The attribute in the SAML response where the roles are stored. Optional. If not configured, no roles are used.</li> <li><code>jwt-default-expiration-timeout</code>:     Default jwt expiration timeout. Optional.</li> </ul>|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
