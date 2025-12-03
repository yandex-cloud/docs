---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-postgresql/cli-ref-beta/database/create.md
---

# yc beta managed-postgresql database create

Creates a new PostgreSQL database in the specified cluster.

#### Command Usage

Syntax: 

`yc beta managed-postgresql database create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the PostgreSQL cluster to create a database in.<br/>To get the cluster ID use a [ClusterService.List] request.|
|`--database-spec`|<b>`shorthand/json`</b><br/>Configuration of the database to create.<br/><br/>Example:|
|`--database-spec`|<b>`deletion-protection=true,`</b><br/>extensions=[{name=value, version=value}], lc-collate=value, lc-ctype=value, name=value, owner=value, template-db=value<br/><br/>Shorthand Syntax:<br/>{deletion-protection=bool, extensions=[{name=str, version=str},...], lc-collate=str, lc-ctype=str, name=str, owner=str, template-db=str}<br/>Fields:<br/>deletion-protection  bool                — Deletion Protection inhibits deletion of the database<br/><br/>Default value: 'unspecified' (inherits cluster's deletion_protection)<br/>extensions           []struct            — PostgreSQL extensions to be enabled for the database.<br/>name     string  — Name of the extension, e.g. 'pg_trgm' or 'pg_btree'.<br/>Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](https://yandex.cloud/ru/docs/managed-postgresql/operations/extensions/cluster-extensions).<br/>version  string  — Version of the extension. The setting is deprecated and has no effect.<br/>lc-collate           string              — POSIX locale for string sorting order.<br/>Can only be set at creation time.<br/>lc-ctype             string              — POSIX locale for character classification.<br/>Can only be set at creation time.<br/>name                 string    required  — Name of the PostgreSQL database. 1-63 characters long.<br/>owner                string    required  — Name of the user to be assigned as the owner of the database.<br/>To get the list of available PostgreSQL users, make a [UserService.List] request.<br/>template-db          string              — Name of the PostgreSQL database template.<br/>|
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
