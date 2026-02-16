---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/load-balancer/cli-ref-beta/network-load-balancer/update.md
---

# yc beta load-balancer network-load-balancer update

Updates the specified network load balancer.

#### Command Usage

Syntax:

`yc beta load-balancer network-load-balancer update <NETWORK-LOAD-BALANCER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--allow-zonal-shift` | Specifies if network load balancer available to zonal shift. ||
|| `--attached-target-groups` | `shorthand/json`

A list of attached target groups for the network load balancer.

Shorthand Syntax:

```hcl
[
  {
    health-checks = [
      {
        healthy-threshold = int,
        interval = duration,
        name = str,
        options = http-options={
          path = str,
          port = int
        } | tcp-options={
          port = int
        },
        timeout = duration,
        unhealthy-threshold = int
      }, ...
    ],
    target-group-id = str
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "health-checks": [
      {
        "healthy-threshold": "int",
        "interval": "duration",
        "name": "str",
        "options": {
          "http-options": {
            "path": "str",
            "port": "int"
          },
          "tcp-options": {
            "port": "int"
          }
        },
        "timeout": "duration",
        "unhealthy-threshold": "int"
      }, ...
    ],
    "target-group-id": "str"
  }, ...
]
```

Fields:

```
health-checks -> ([]struct)
  A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.
  healthy-threshold -> (int)
    Number of successful health checks required in order to set the '' HEALTHY '' status for the target. The default is 2.
  interval -> (duration)
    The interval between health checks. The default is 2 seconds.
  name -> (string)
    Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.
  timeout -> (duration)
    Timeout for a target to return a response for the health check. The default is 1 second.
  unhealthy-threshold -> (int)
    Number of failed health checks before changing the status to '' UNHEALTHY ''. The default is 2.
  options -> (oneof<http-options|tcp-options>)
    Oneof options field
    tcp-options -> (struct)
      Options for TCP health check.
      port -> (int)
        Port to use for TCP health checks.
    http-options -> (struct)
      Options for HTTP health check.
      path -> (string)
        URL path to set for health checking requests for every target in the target group. For example '' /ping ''. The default path is '' / ''.
      port -> (int)
        Port to use for HTTP health checks.
target-group-id -> (string)
  ID of the target group.
``` ||
|| `--deletion-protection` | Specifies if network load balancer protected from deletion. ||
|| `--description` | `string`

Description of the network load balancer. ||
|| `--labels` | `stringToString`

Resource labels as '' key:value '' pairs. The existing set of '' labels '' is completely replaced with the provided set. ||
|| `--listener-specs` | `shorthand/json`

A list of listeners and their specs for the network load balancer.

Shorthand Syntax:

```hcl
[
  {
    address = external-address-spec={
      address = str,
      ip-version = IPV4|IPV6
    } | internal-address-spec={
      address = str,
      ip-version = IPV4|IPV6,
      subnet-id = str
    },
    name = str,
    port = int,
    protocol = TCP|UDP,
    target-port = int
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "address": {
      "external-address-spec": {
        "address": "str",
        "ip-version": "IPV4|IPV6"
      },
      "internal-address-spec": {
        "address": "str",
        "ip-version": "IPV4|IPV6",
        "subnet-id": "str"
      }
    },
    "name": "str",
    "port": "int",
    "protocol": "TCP|UDP",
    "target-port": "int"
  }, ...
]
```

Fields:

```
name -> (string)
  Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.
port -> (int)
  Port for incoming traffic.
protocol -> (struct)
  Protocol for incoming traffic.
target-port -> (int)
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
|| `--network-load-balancer-id` | `string`

ID of the network load balancer to update. To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request. ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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