# yc application-load-balancer load-balancer create

Create an application load balancer

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer create <LOAD-BALANCER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the application load balancer.|
|`--description`|<b>`string`</b><br/>A description of the application load balancer.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--region-id`|<b>`string`</b><br/>A region id of the application load balancer.|
|`--network-id`|<b>`string`</b><br/>ID of the network to which the loadbalancer connects.|
|`--network-name`|<b>`string`</b><br/>Name of the network to which the loadbalancer connects.|
|`--security-group-id`|<b>`value[,value]`</b><br/>Security groups for the load balancer, --security-group-id id1 --security-group-id=id2|
|`--location`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of load balancer locations.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-id</code>:     Subnet id.</li> <li><code>subnet-name</code>:     Subnet name.</li> <li><code>zone</code>:     Zone of the subnet.</li> <li><code>traffic-disabled</code>:     Disable traffic in zone.</li> </ul>|
|`--log-group-id`|<b>`string`</b><br/>ID of the log group to which the loadbalancer send logs.|
|`--log-group-name`|<b>`string`</b><br/>Name of the log group to which the loadbalancer send logs.|
|`--log-group-use-default`|Use default log group in the folder where load balancer resides.|
|`--disable-logging`|Do not send access logs to Cloud Logging log group.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
