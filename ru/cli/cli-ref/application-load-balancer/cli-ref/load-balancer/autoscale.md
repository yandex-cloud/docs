---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/load-balancer/autoscale.md
---

# yc application-load-balancer load-balancer autoscale

Modify scaling settings of the application load balancer.

#### Command Usage

Syntax:

`yc application-load-balancer load-balancer autoscale <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the Application load balancer. ||
|| `--name` | `string`

Name of the Application load balancer. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--min-zone-size` | `int`

Lower limit for the number of resource units in each availability zone.
If not specified previously (using other instruments such as management console), the default value is 2. To revert to it, specify it explicitly.
The minimum value is 2. ||
|| `--max-size` | `int`

Upper limit for the total number of resource units across all availability zones.
If a positive value is specified, it must be at least the lower limit in each zone multiplied by the number of zones in which the load balancer is hosted.
By default, there is no upper limit. To remove it, specify 0. ||
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