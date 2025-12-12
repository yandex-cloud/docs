---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-postgresql/cli-ref-beta/database/update.md
---

# yc beta managed-postgresql database update

Updates the specified PostgreSQL database.

#### Command Usage

Syntax: 

`yc beta managed-postgresql database update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the PostgreSQL cluster to update a database in. To get the cluster ID use a [ClusterService.List] request.|
|`--database-name`|<b>`string`</b><br/>Name of the database to update. To get the name of the database use a [DatabaseService.List] request.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the database Default value: 'unspecified' (inherits cluster's deletion_protection)|
|`--extensions`|<b>`shorthand/json`</b><br/>PostgreSQL extensions that should be enabled for the database. If the field is sent, the list of enabled extensions is rewritten entirely. Therefore, to disable an active extension you should simply send the list omitting this extension.<br/>Shorthand Syntax:<br/>[<br/>{<br/>name = str,<br/>version = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"name": "str",<br/>"version": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>name -> (string)<br/>Name of the extension, e.g. 'pg_trgm' or 'pg_btree'. Extensions supported by Managed Service for PostgreSQL are documentation.<br/>version -> (string)<br/>Version of the extension. The setting is deprecated and has no effect.|
|`--new-database-name`|<b>`string`</b><br/>Optional. New name of the database.|
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
