---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/application-load-balancer/cli-ref/load-balancer/logging/
---

# yc application-load-balancer load-balancer logging

Manage cloud logging settings of the load balancer.

#### Command Usage

Syntax:

`yc application-load-balancer load-balancer logging <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the Application load balancer. ||
|| `--name` | `string`

Name of the Application load balancer. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--log-group-id` | `string`

ID of the log group to which the loadbalancer send logs. ||
|| `--log-group-name` | `string`

Name of the log group to which the loadbalancer send logs. ||
|| `--log-group-use-default` | Use default log group in the folder where load balancer resides. ||
|| `--disable` | Do not send access logs to Cloud Logging log group. ||
|| `--enable` | Send access logs to specified Cloud Logging log group. ||
|| `--discard` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Discard a percentage of logs for given codes. Multiple discard rules can be provided, order is preserved and the first matching rule is applied.

Provided set of rules replaces any previously defined rules.

Example (discard 90%% of codes 200, 3XX, GRPC_OK and 15%% of any other codes):

--discard codes=[200,3XX,GRPC_OK],percent=90 --discard codes=ALL,percent=15

Possible property names:

- `codes`: codes to be discarded. value can be an http code (100..599), an interval (1XX..5XX or ALL) or a grpc-code marked by prefix (GRPC_OK..GRPC_UNAUTHENTICATED) (required)

- `percent`: percent of logs to be discarded if matched by codes (required) ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#