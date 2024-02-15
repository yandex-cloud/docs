---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/datatransfer/endpoint/create/mysql-source.md
---

# yc datatransfer endpoint create mysql-source

Create MySQL source

#### Command Usage

Syntax: 

`yc datatransfer endpoint create mysql-source [<ENDPOINT-NAME>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--file`|<b>`string`</b><br/>Path to a file with grpc request, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/datatransfer/v1|
|`--name`|<b>`string`</b><br/>Endpoint name|
|`--description`|<b>`string`</b><br/>Endpoint description|
|`--cluster-id`|<b>`string`</b><br/>Yandex Managed MySQL cluster ID|
|`--host`|<b>`value[,value]`</b><br/>MySQL server host name or IP address|
|`--port`|<b>`int`</b><br/>MySQL server port|
|`--ca-certificate`|<b>`string`</b><br/>Path to the CA certificate of the MySQL server. Implies enabled TLS|
|`--subnet-id`|<b>`string`</b><br/>Yandex Virtual Private Cloud subnet ID to access the MySQL server through|
|`--database`|<b>`string`</b><br/>Database name|
|`--user`|<b>`string`</b><br/>User name|
|`--raw-password`|<b>`string`</b><br/>Raw password value (unsafe, consider --password-file)|
|`--password-file`|<b>`string`</b><br/>Path to the file containing password|
|`-i`,`--include-table-regex`|<b>`value[,value]`</b><br/>Do not transfer the tables which do not match the specified regular expression|
|`-p`,`--exclude-table-regex`|<b>`value[,value]`</b><br/>Do not transfer the tables which match the specified regular expression|
|`--timezone`|<b>`string`</b><br/>Used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Defaults to the local timezone|
|`-b`,`--transfer-before-data`|<b>`value[,value]`</b><br/>Schema objects to transfer before transferring data, one of [view, routine, trigger, tables]|
|`-a`,`--transfer-after-data`|<b>`value[,value]`</b><br/>Schema objects to transfer after transferring data, one of [view, routine, trigger, tables]|

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
