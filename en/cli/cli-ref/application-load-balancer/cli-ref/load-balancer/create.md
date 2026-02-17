---
editable: false
---

# yc application-load-balancer load-balancer create

Create an application load balancer

#### Command Usage

Syntax:

`yc application-load-balancer load-balancer create <LOAD-BALANCER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the application load balancer. ||
|| `--description` | `string`

A description of the application load balancer. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--region-id` | `string`

A region id of the application load balancer. ||
|| `--network-id` | `string`

ID of the network to which the loadbalancer connects. ||
|| `--network-name` | `string`

Name of the network to which the loadbalancer connects. ||
|| `--security-group-id` | `value[,value]`

Security groups for the load balancer, --security-group-id id1 --security-group-id=id2 ||
|| `--location` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of load balancer locations.

Possible property names:

- `subnet-id`: Subnet id.

- `subnet-name`: Subnet name.

- `zone`: Zone of the subnet.

- `traffic-disabled`: Disable traffic in zone. ||
|| `--log-group-id` | `string`

ID of the log group to which the loadbalancer send logs. ||
|| `--log-group-name` | `string`

Name of the log group to which the loadbalancer send logs. ||
|| `--log-group-use-default` | Use default log group in the folder where load balancer resides. ||
|| `--disable-logging` | Do not send access logs to Cloud Logging log group. ||
|| `--allow-zonal-shift` | Specifies whether application load balancer is available to zonal shift. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#