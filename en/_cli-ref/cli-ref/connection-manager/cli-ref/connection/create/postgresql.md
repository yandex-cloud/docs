---
editable: false
---

# yc connection-manager connection create postgresql

Create PostgreSQL connection

#### Command Usage

Syntax: 

`yc connection-manager connection create postgresql [<CONNECTION-NAME>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the connection.|
|`--description`|<b>`string`</b><br/>Description of the connection.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of connection labels as key-value pairs.|
|`--databases`|<b>`value[,value]`</b><br/>Databases list.|
|`--user`|<b>`string`</b><br/>Name of the user.|
|`--password`|<b>`string`</b><br/>Raw password.|
|`--password-gen-opts`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Password generations options.<br/><br/>Possible property names:<br/><ul> <li><code>length</code>:     Lockbox password generation length.</li> <li><code>include-uppercase</code>:     Lockbox password generation include_uppercase parameter.</li> <li><code>include-lowercase</code>:     Lockbox password generation include_lowercase parameter.</li> <li><code>include-digits</code>:     Lockbox password generation include_digits parameter.</li> <li><code>include-punctuation</code>:     Lockbox password generation include_punctuation parameter.</li> <li><code>included-punctuation</code>:     Lockbox password generation included_punctuation parameter.</li> <li><code>excluded-punctuation</code>:     Lockbox password generation excluded_punctuation parameter.</li> <li><code>cookie</code>:     Password cookie.</li> </ul>|
|`--managed-cluster-id`|<b>`string`</b><br/>Identifier of the cluster.|
|`--hosts`|<b>`value[,value]`</b><br/>List of PostgreSQL hosts in format 'host:port'.|
|`--tls-disabled`|Disable TLS for PostgreSQL connection.|
|`--ca-certificate`|<b>`string`</b><br/>CA certificate file for TLS connection.|

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
