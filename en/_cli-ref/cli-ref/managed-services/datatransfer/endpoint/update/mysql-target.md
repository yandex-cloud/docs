---
editable: false
---

# yc datatransfer endpoint update mysql-target

Update MySQL target

#### Command Usage

Syntax: 

`yc datatransfer endpoint update mysql-target [<ENDPOINT-ID>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
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
|`--sql-mode`|<b>`string`</b><br/>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION|
|`--skip-constraint-checks`|This option sets FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. Disable for replication speed, but not if the schema contains cascading operations|
|`--timezone`|<b>`string`</b><br/>For parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone|

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
