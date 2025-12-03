---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-sqlserver/cli-ref-beta/user/create.md
---

# yc beta managed-sqlserver user create

Creates an SQL Server user in the specified cluster.

#### Command Usage

Syntax: 

`yc beta managed-sqlserver user create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the SQL Server cluster to create a user for.<br/><br/>To get the cluster ID, use a [ClusterService.List] request.|
|`--user-spec`|<b>`shorthand/json`</b><br/>Properties of the user to be created.<br/><br/>Example:|
|`--user-spec`|<b>`name=value,`</b><br/>password=value, permissions=[{database-name=value, roles=DB_OWNER}], server-roles=MDB_MONITOR<br/><br/>Shorthand Syntax:<br/>{name=str, password=str, permissions=[{database-name=str, roles=DB_OWNER\|DB_SECURITYADMIN\|DB_ACCESSADMIN\|DB_BACKUPOPERATOR\|DB_DDLADMIN\|DB_DATAWRITER\|DB_DATAREADER\|DB_DENYDATAWRITER\|DB_DENYDATAREADER,...},...], server-roles=MDB_MONITOR,...}<br/>Fields:<br/>name          string    required  — Name of the SQL Server user.<br/>password      string    required  — Password of the SQL Server user.<br/>permissions   []struct            — Set of permissions to grant to the user.<br/>database-name  string  — Name of the database the permission grants access to.<br/>roles          []int   — Roles granted to the user within the database.<br/>server-roles  []int               — Set of server roles.<br/>|
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
