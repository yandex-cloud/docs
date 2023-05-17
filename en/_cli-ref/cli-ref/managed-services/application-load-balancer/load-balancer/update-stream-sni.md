---
editable: false
---

# yc application-load-balancer load-balancer update-stream-sni

Updates Stream sni match of the application load balancer's listener.

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer update-stream-sni <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the Application load balancer.|
|`--name`|<b>`string`</b><br/>Name of the Application load balancer.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--listener-name`|<b>`string`</b><br/>Name of the listener to add/update SNI match to.|
|`--sni-name`|<b>`string`</b><br/>Name of the SNI match to add/update.|
|`--server-name`|<b>`value[,value]`</b><br/>Server name to match.|
|`--certificate-id`|<b>`value[,value]`</b><br/>Certificate ID for SNI match.|
|`--backend-group-id`|<b>`string`</b><br/>Backend group id for SNI match.|
|`--backend-group-name`|<b>`string`</b><br/>Backend group name for SNI match.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
