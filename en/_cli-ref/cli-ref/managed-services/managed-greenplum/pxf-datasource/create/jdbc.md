---
editable: false
---

# yc managed-greenplum pxf-datasource create jdbc

Create jdbc pxf-datasource for specified Greenplum cluster

#### Command Usage

Syntax: 

`yc managed-greenplum pxf-datasource create jdbc <DATASOURCE-NAME> [Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Greenplum cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Greenplum cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--driver`|<b>`string`</b><br/>JDBC driver|
|`--url`|<b>`string`</b><br/>JDBC URL|
|`--user`|<b>`string`</b><br/>JDBC user|
|`--password`|<b>`string`</b><br/>JDBC password|
|`--statement-batch-size`|<b>`int`</b><br/>JDBC statement batch size|
|`--statement-fetch-size`|<b>`int`</b><br/>JDBC statement fetch size|
|`--statement-query-timeout`|<b>`int`</b><br/>JDBC statement query timeout|
|`--pool-enabled`|JDBC statement query timeout|
|`--pool-maximum-size`|<b>`int`</b><br/>JDBC maximum pool size|
|`--pool-connection-timeout`|<b>`int`</b><br/>JDBC connection timeout in milliseconds|
|`--pool-idle-timeout`|<b>`int`</b><br/>JDBC idle timeout in milliseconds|
|`--pool-minimum-idle`|<b>`int`</b><br/>JDBC maximum idle|
|`--xml`|<b>`value[,value]`</b><br/>Load datasource from xml files|
|`--force`|Ignore xml errors|

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
|`-h`,`--help`|Display help for the command.|
