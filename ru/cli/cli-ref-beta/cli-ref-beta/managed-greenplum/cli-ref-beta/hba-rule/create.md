---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-greenplum/cli-ref-beta/hba-rule/create.md
---

# yc beta managed-greenplum hba-rule create

Create single HBA rule for the specified Greenplum cluster to the end of HBA rules list.

#### Command Usage

Syntax: 

`yc beta managed-greenplum hba-rule create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List] request.|
|`--hba-rule`|<b>`shorthand/json`</b><br/>New hba rule for the cluster.<br/>Shorthand Syntax:<br/>{<br/>address = str,<br/>auth-method = MD5\|LDAP\|REJECT\|IAM,<br/>connection-type = HOST\|HOSTSSL\|HOSTNOSSL,<br/>database = str,<br/>priority = int,<br/>user = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"address": "str",<br/>"auth-method": "MD5\|LDAP\|REJECT\|IAM",<br/>"connection-type": "HOST\|HOSTSSL\|HOSTNOSSL",<br/>"database": "str",<br/>"priority": "int",<br/>"user": "str"<br/>}"<br/>Fields:<br/>address -> (string)<br/>Specifies the client machine addresses that this record matches.<br/>auth-method -> (enum<IAM\|LDAP\|MD5\|REJECT>)<br/>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html<br/>connection-type -> (enum<HOST\|HOSTNOSSL\|HOSTSSL>)<br/>database -> (string)<br/>Specifies which database names this record matches.<br/>priority -> (int)<br/>Priority of the Greenplum cluster rule.<br/>user -> (string)<br/>Specifies which database role names this user matches.|
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
