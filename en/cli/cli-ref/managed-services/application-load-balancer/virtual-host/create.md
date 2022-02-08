---
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/virtual-host/create.md
---
# yc application-load-balancer virtual-host create

Create an virtual host for the http router

#### Command Usage

Syntax: 

`yc application-load-balancer virtual-host create <VIRTUAL-HOST-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--http-router-id`|<b>`string`</b><br/> ID of the Http router.|
|`--http-router-name`|<b>`string`</b><br/> Name of the Http router.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--authority`|<b>`value[,value]`</b><br/> Specifies domains (:authority/Host header values) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'|
|`--modify-request-header`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Specifies modifications to be applied to the request headers.  Possible property names:  name Specifies the name of the header to modify.  append Specifies the value to be appended to the header.  replace Specifies the new value for the header.  rename Specifies the new name fot the header.  remove Remove the specified header  |
|`--modify-response-header`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Specifies modifications to be applied to the response headers.  Possible property names:  name Specifies the name of the header to modify.  append Specifies the value to be appended to the header.  replace Specifies the new value for the header.  rename Specifies the new name fot the header.  remove Remove the specified header|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
