---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-trino/cli-ref/catalog/create/sqlserver.md
---

# yc managed-trino catalog create sqlserver

Create MS SQL Server catalog

#### Command Usage

Syntax: 

`yc managed-trino catalog create sqlserver <CATALOG-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Trino cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Trino cluster name.|
|`--name`|<b>`string`</b><br/>Name of the Trino catalog.|
|`--description`|<b>`string`</b><br/>Description of the catalog.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of Trino catalog labels as key-value pairs.|
|`--on-premise-connection-url`|<b>`string`</b><br/>OnPremise connection URL.|
|`--on-premise-user-name`|<b>`string`</b><br/>OnPremise connection username.|
|`--on-premise-password`|<b>`string`</b><br/>OnPremise connection password.|
|`--additional-properties`|<b>`key=value[,key=value...]`</b><br/>A list of Trino catalog additional properties as key-value pairs.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
