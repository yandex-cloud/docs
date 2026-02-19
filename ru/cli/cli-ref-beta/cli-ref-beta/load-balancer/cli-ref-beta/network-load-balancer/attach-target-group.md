---
editable: false
noIndex: true
---

# yc beta load-balancer network-load-balancer attach-target-group

Attaches a target group to the specified network load balancer.

#### Command Usage

Syntax:

`yc beta load-balancer network-load-balancer attach-target-group <NETWORK-LOAD-BALANCER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--attached-target-group` | `shorthand/json`

ID of the attached target group to attach to the network load balancer. To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request.

Shorthand Syntax:

```hcl
{
  health-checks = [
    {
      healthy-threshold = integer,
      interval = duration,
      name = string,
      options = http-options={
        path = string,
        port = integer
      } | tcp-options={
        port = integer
      },
      timeout = duration,
      unhealthy-threshold = integer
    }, ...
  ],
  target-group-id = string
}
```

JSON Syntax:

```json
{
  "health-checks": [
    {
      "healthy-threshold": "integer",
      "interval": "duration",
      "name": "string",
      "options": {
        "http-options": {
          "path": "string",
          "port": "integer"
        },
        "tcp-options": {
          "port": "integer"
        }
      },
      "timeout": "duration",
      "unhealthy-threshold": "integer"
    }, ...
  ],
  "target-group-id": "string"
}
```

Fields:

```
health-checks -> ([]struct)
  A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.
  healthy-threshold -> (integer)
    Number of successful health checks required in order to set the '' HEALTHY '' status for the target. The default is 2.
  interval -> (duration)
    The interval between health checks. The default is 2 seconds.
  name -> (string)
    Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.
  timeout -> (duration)
    Timeout for a target to return a response for the health check. The default is 1 second.
  unhealthy-threshold -> (integer)
    Number of failed health checks before changing the status to '' UNHEALTHY ''. The default is 2.
  options -> (oneof<http-options|tcp-options>)
    Oneof options field
    tcp-options -> (struct)
      Options for TCP health check.
      port -> (integer)
        Port to use for TCP health checks.
    http-options -> (struct)
      Options for HTTP health check.
      path -> (string)
        URL path to set for health checking requests for every target in the target group. For example '' /ping ''. The default path is '' / ''.
      port -> (integer)
        Port to use for HTTP health checks.
target-group-id -> (string)
  ID of the target group.
``` ||
|| `--network-load-balancer-id` | `string`

ID of the network load balancer to attach the target group to. To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#