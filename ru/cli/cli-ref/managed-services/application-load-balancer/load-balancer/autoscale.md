---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/load-balancer/autoscale.md
---

# yc application-load-balancer load-balancer autoscale

Modify scaling settings of the application load balancer.

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer autoscale <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the Application load balancer.|
|`--name`|<b>`string`</b><br/>Name of the Application load balancer.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--min-zone-size`|<b>`int`</b><br/>Lower limit for the number of resource units in each availability zone.<br/>If not specified previously (using other instruments such as management console), the default value is 2. To revert to it, specify it explicitly.<br/>The minimum value is 2.|
|`--max-size`|<b>`int`</b><br/>Upper limit for the total number of resource units across all availability zones.<br/>If a positive value is specified, it must be at least the lower limit in each zone multiplied by the number of zones in which the load balancer is hosted.<br/>By default, there is no upper limit. To remove it, specify 0.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
