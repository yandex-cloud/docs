---
editable: false
noIndex: true
---

# yc beta load-balancer network-load-balancer add-listener

Adds a listener to the specified network load balancer.

#### Command Usage

Syntax:

`yc beta load-balancer network-load-balancer add-listener <NETWORK-LOAD-BALANCER-ID>`

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
|| `--listener-spec` | `shorthand/json`

Listener spec.

Shorthand Syntax:

```hcl
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
}
```

JSON Syntax:

```json
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
}
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
|| `--network-load-balancer-id` | `string`

ID of the network load balancer to add a listener to. To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request. ||
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