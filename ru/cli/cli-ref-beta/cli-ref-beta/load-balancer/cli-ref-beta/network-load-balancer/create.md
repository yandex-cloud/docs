---
editable: false
noIndex: true
---

# yc beta load-balancer network-load-balancer create

Creates a network load balancer in the specified folder using the data specified in the request.

#### Command Usage

Syntax:

`yc beta load-balancer network-load-balancer create <FOLDER-ID>`

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
|| `--allow-zonal-shift` | Specifies if network load balancer available to zonal shift. ||
|| `--attached-target-groups` | `shorthand/json`

List of attached target groups for the network load balancer.

Shorthand Syntax:

```hcl
[
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
  }, ...
]
```

JSON Syntax:

```json
[
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
  }, ...
]
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
|| `--deletion-protection` | Specifies if network load balancer protected from deletion. ||
|| `--description` | `string`

Description of the network load balancer. ||
|| `--folder-id` | `string`

ID of the folder to create a network load balancer in. To get the folder ID, use a [NetworkLoadBalancerService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs. ||
|| `--listener-specs` | `shorthand/json`

List of listeners and their specs for the network load balancer.

Shorthand Syntax:

```hcl
[
  {
    address = external-address-spec={
      address = string,
      ip-version = IPV4|IPV6
    } | internal-address-spec={
      address = string,
      ip-version = IPV4|IPV6,
      subnet-id = string
    },
    name = string,
    port = integer,
    protocol = TCP|UDP,
    target-port = integer
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "address": {
      "external-address-spec": {
        "address": "string",
        "ip-version": "IPV4|IPV6"
      },
      "internal-address-spec": {
        "address": "string",
        "ip-version": "IPV4|IPV6",
        "subnet-id": "string"
      }
    },
    "name": "string",
    "port": "integer",
    "protocol": "TCP|UDP",
    "target-port": "integer"
  }, ...
]
```

Fields:

```
name -> (string)
  Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.
port -> (integer)
  Port for incoming traffic.
protocol -> (struct)
  Protocol for incoming traffic.
target-port -> (integer)
  Port of a target. Acceptable values are 1 to 65535, inclusive.
address -> (oneof<external-address-spec|internal-address-spec>)
  Oneof address field
  external-address-spec -> (struct)
    External IP address specification.
    address -> (string)
      Public IP address for a listener. If you provide a static public IP address for the [NetworkLoadBalancerService.Update] method, it will replace the existing listener address.
    ip-version -> (struct)
      IP version.
  internal-address-spec -> (struct)
    Internal IP address specification.
    address -> (string)
      Internal IP address for a listener.
    ip-version -> (struct)
      IP version.
    subnet-id -> (string)
      ID of the subnet.
``` ||
|| `--name` | `string`

Name of the network load balancer. The name must be unique within the folder. ||
|| `--region-id` | `string`

ID of the region where the network load balancer resides. ||
|| `--type` | `enum`

Type of the network load balancer. Possible Values: 'external', 'internal' ||
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