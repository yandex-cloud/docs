---
editable: false
noIndex: true
---

# yc beta managed-kubernetes node-group update

Updates the specified node group.

#### Command Usage

Syntax:

`yc beta managed-kubernetes node-group update <NODE-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--allocation-policy` | `shorthand/json`

Allocation policy of the node group by the zones and regions.

Shorthand Syntax:

```hcl
{
  locations = [
    {
      subnet-id = string,
      zone-id = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "locations": [
    {
      "subnet-id": "string",
      "zone-id": "string"
    }, ...
  ]
}
```

Fields:

```
locations -> ([]struct)
  List of locations where resources for the node group will be allocated.
  subnet-id -> (string)
    ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted.
  zone-id -> (string)
    ID of the availability zone where the nodes may reside.
``` ||
|| `--allowed-unsafe-sysctls` | `[]string`

Support for unsafe sysctl parameters. For more details see documentation. ||
|| `--deploy-policy` | `shorthand/json`

Deploy policy according to which the updates are rolled out. If not specified, the default is used.

Shorthand Syntax:

```hcl
{
  max-expansion = integer,
  max-unavailable = integer
}
```

JSON Syntax:

```json
{
  "max-expansion": "integer",
  "max-unavailable": "integer"
}
```

Fields:

```
max-expansion -> (integer)
  The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If [max_unavailable] is not specified or set to zero, [max_expansion] must be set to a non-zero value.
max-unavailable -> (integer)
  The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If [max_expansion] is not specified or set to zero, [max_unavailable] must be set to a non-zero value.
``` ||
|| `--description` | `string`

Description of the node group. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--maintenance-policy` | `shorthand/json`

Maintenance policy of the node group.

Shorthand Syntax:

```hcl
{
  auto-repair = boolean,
  auto-upgrade = boolean,
  maintenance-window = {
    policy = anytime={} | daily-maintenance-window={
      duration = duration,
      start-time = timeofday
    } | weekly-maintenance-window={
      days-of-week = [
        {
          days = [
            MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY, ...
          ],
          duration = duration,
          start-time = timeofday
        }, ...
      ]
    }
  }
}
```

JSON Syntax:

```json
{
  "auto-repair": "boolean",
  "auto-upgrade": "boolean",
  "maintenance-window": {
    "policy": {
      "anytime": {},
      "daily-maintenance-window": {
        "duration": "duration",
        "start-time": "timeofday"
      },
      "weekly-maintenance-window": {
        "days-of-week": [
          {
            "days": [
              "MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY", ...
            ],
            "duration": "duration",
            "start-time": "timeofday"
          }, ...
        ]
      }
    }
  }
}
```

Fields:

```
auto-repair -> (boolean)
  If set to true, automatic repairs are enabled. Default value is false.
auto-upgrade -> (boolean)
  If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.
maintenance-window -> (struct)
  Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.
  policy -> (oneof<anytime|daily-maintenance-window|weekly-maintenance-window>)
    Oneof policy field
    anytime -> (struct)
      Updating the master at any time.
    daily-maintenance-window -> (struct)
      Updating the master on any day during the specified time window.
      duration -> (duration)
        Window duration.
      start-time -> (timeofday)
        Window start time, in the UTC timezone.
    weekly-maintenance-window -> (struct)
      Updating the master on selected days during the specified time window.
      days-of-week -> ([]struct)
        Days of the week and the maintenance window for these days when automatic updates are allowed.
        days -> ([]struct)
          Days of the week when automatic updates are allowed.
        duration -> (duration)
          Window duration.
        start-time -> (timeofday)
          Window start time, in the UTC timezone.
``` ||
|| `--name` | `string`

Name of the node group. The name must be unique within the folder. ||
|| `--node-group-id` | `string`

ID of the node group to update. To get the node group ID use a [NodeGroupService.List] request. ||
|| `--node-labels` | `map<string><string>`

Labels that are assigned to the nodes of the node group at creation time. ||
|| `--node-taints` | `shorthand/json`

Taints that are applied to the nodes of the node group at creation time.

Shorthand Syntax:

```hcl
[
  {
    effect = NO_SCHEDULE|PREFER_NO_SCHEDULE|NO_EXECUTE,
    key = string,
    value = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "effect": "NO_SCHEDULE|PREFER_NO_SCHEDULE|NO_EXECUTE",
    "key": "string",
    "value": "string"
  }, ...
]
```

Fields:

```
effect -> (struct)
  The effect of the taint on pods that do not tolerate the taint.
key -> (string)
  The taint key to be applied to a node.
value -> (string)
  The taint value corresponding to the taint key.
``` ||
|| `--node-template` | `shorthand/json`

Node template for the node group. Change may trigger nodes rolling reboot or recreate.

Shorthand Syntax:

```hcl
{
  boot-disk-spec = {
    disk-size = integer,
    disk-type-id = string
  },
  container-network-settings = {
    pod-mtu = integer
  },
  container-runtime-settings = {
    type = DOCKER|CONTAINERD
  },
  gpu-settings = {
    gpu-cluster-id = string,
    gpu-environment = RUNC_DRIVERS_CUDA|RUNC
  },
  labels = {key=string, key=...},
  metadata = {key=string, key=...},
  name = string,
  network-interface-specs = [
    {
      primary-v4-address-spec = {
        dns-record-specs = [
          {
            dns-zone-id = string,
            fqdn = string,
            ptr = boolean,
            ttl = integer
          }, ...
        ],
        one-to-one-nat-spec = {
          ip-version = IPV4|IPV6
        }
      },
      primary-v6-address-spec = {
        dns-record-specs = [
          {
            dns-zone-id = string,
            fqdn = string,
            ptr = boolean,
            ttl = integer
          }, ...
        ],
        one-to-one-nat-spec = {
          ip-version = IPV4|IPV6
        }
      },
      security-group-ids = string,...,
      subnet-ids = string,...
    }, ...
  ],
  network-settings = {
    type = STANDARD|SOFTWARE_ACCELERATED
  },
  placement-policy = {
    placement-group-id = string
  },
  platform-id = string,
  resources-spec = {
    core-fraction = integer,
    cores = integer,
    gpus = integer,
    memory = integer
  },
  scheduling-policy = {
    preemptible = boolean
  },
  v4-address-spec = {
    dns-record-specs = [
      {
        dns-zone-id = string,
        fqdn = string,
        ptr = boolean,
        ttl = integer
      }, ...
    ],
    one-to-one-nat-spec = {
      ip-version = IPV4|IPV6
    }
  }
}
```

JSON Syntax:

```json
{
  "boot-disk-spec": {
    "disk-size": "integer",
    "disk-type-id": "string"
  },
  "container-network-settings": {
    "pod-mtu": "integer"
  },
  "container-runtime-settings": {
    "type": "DOCKER|CONTAINERD"
  },
  "gpu-settings": {
    "gpu-cluster-id": "string",
    "gpu-environment": "RUNC_DRIVERS_CUDA|RUNC"
  },
  "labels": {
    "<key>": "string", ...
  },
  "metadata": {
    "<key>": "string", ...
  },
  "name": "string",
  "network-interface-specs": [
    {
      "primary-v4-address-spec": {
        "dns-record-specs": [
          {
            "dns-zone-id": "string",
            "fqdn": "string",
            "ptr": "boolean",
            "ttl": "integer"
          }, ...
        ],
        "one-to-one-nat-spec": {
          "ip-version": "IPV4|IPV6"
        }
      },
      "primary-v6-address-spec": {
        "dns-record-specs": [
          {
            "dns-zone-id": "string",
            "fqdn": "string",
            "ptr": "boolean",
            "ttl": "integer"
          }, ...
        ],
        "one-to-one-nat-spec": {
          "ip-version": "IPV4|IPV6"
        }
      },
      "security-group-ids": [
        "string", ...
      ],
      "subnet-ids": [
        "string", ...
      ]
    }, ...
  ],
  "network-settings": {
    "type": "STANDARD|SOFTWARE_ACCELERATED"
  },
  "placement-policy": {
    "placement-group-id": "string"
  },
  "platform-id": "string",
  "resources-spec": {
    "core-fraction": "integer",
    "cores": "integer",
    "gpus": "integer",
    "memory": "integer"
  },
  "scheduling-policy": {
    "preemptible": "boolean"
  },
  "v4-address-spec": {
    "dns-record-specs": [
      {
        "dns-zone-id": "string",
        "fqdn": "string",
        "ptr": "boolean",
        "ttl": "integer"
      }, ...
    ],
    "one-to-one-nat-spec": {
      "ip-version": "IPV4|IPV6"
    }
  }
}
```

Fields:

```
boot-disk-spec -> (struct)
  Specification for the boot disk that will be attached to the node.
  disk-size -> (integer)
    Size of the disk, specified in bytes.
  disk-type-id -> (string)
    ID of the disk type.
container-network-settings -> (struct)
  Container network settings for the node template.
  pod-mtu -> (integer)
    MTU (Maximum Transmission Unit) size for pod network interfaces.
container-runtime-settings -> (struct)
  Container runtime settings for the node template.
  type -> (struct)
    Type of container runtime.
gpu-settings -> (struct)
  GPU settings
  gpu-cluster-id -> (string)
    GPU cluster id, that mk8s node will join.
  gpu-environment -> (struct)
    GPU environment configured on node.
labels -> (map[string,string])
  these labels will be assigned to compute nodes (instances), created by the nodegroup
metadata -> (map[string,string])
  The metadata as 'key:value' pairs assigned to this instance template. Only SSH keys are supported as metadata. For more information, see documentation.
name -> (string)
  Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list.
network-interface-specs -> ([]struct)
  New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec'
  primary-v4-address-spec -> (struct)
    Primary IPv4 address that is assigned to the instance for this network interface.
    dns-record-specs -> ([]struct)
      Internal DNS configuration.
      dns-zone-id -> (string)
        DNS zone id (optional, if not set, private zone is used).
      fqdn -> (string)
        FQDN (required).
      ptr -> (boolean)
        When set to true, also create PTR DNS record (optional).
      ttl -> (integer)
        DNS record ttl, values in 0-86400 (optional).
    one-to-one-nat-spec -> (struct)
      One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.
      ip-version -> (struct)
        IP version for the public IP address.
  primary-v6-address-spec -> (struct)
    Primary IPv6 address that is assigned to the instance for this network interface.
    dns-record-specs -> ([]struct)
      Internal DNS configuration.
      dns-zone-id -> (string)
        DNS zone id (optional, if not set, private zone is used).
      fqdn -> (string)
        FQDN (required).
      ptr -> (boolean)
        When set to true, also create PTR DNS record (optional).
      ttl -> (integer)
        DNS record ttl, values in 0-86400 (optional).
    one-to-one-nat-spec -> (struct)
      One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.
      ip-version -> (struct)
        IP version for the public IP address.
  security-group-ids -> ([]string)
    IDs of security groups.
  subnet-ids -> ([]string)
    IDs of the subnets.
network-settings -> (struct)
  this parameter allows to specify type of network acceleration used on nodes (instances)
  type -> (struct)
    Network type that specifies the network configuration for the node group instances.
placement-policy -> (struct)
  Placement policy configuration that controls physical placement of node group instances in the cloud infrastructure for optimizing performance and reliability.
  placement-group-id -> (string)
    Identifier of placement group
platform-id -> (string)
  ID of the hardware platform configuration for the node.
resources-spec -> (struct)
  Computing resources of the node such as the amount of memory and number of cores.
  core-fraction -> (integer)
    Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core.
  cores -> (integer)
    Number of cores available to the node.
  gpus -> (integer)
    Number of GPUs available to the node.
  memory -> (integer)
    Amount of memory available to the node, specified in bytes.
scheduling-policy -> (struct)
  Scheduling policy configuration.
  preemptible -> (boolean)
    True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see documentation.
v4-address-spec -> (struct)
  Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs.
  dns-record-specs -> ([]struct)
    Internal DNS configuration.
    dns-zone-id -> (string)
      DNS zone id (optional, if not set, private zone is used).
    fqdn -> (string)
      FQDN (required).
    ptr -> (boolean)
      When set to true, also create PTR DNS record (optional).
    ttl -> (integer)
      DNS record ttl, values in 0-86400 (optional).
  one-to-one-nat-spec -> (struct)
    One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.
    ip-version -> (struct)
      IP version for the public IP address.
``` ||
|| `--scale-policy` | `shorthand/json`

Scale policy of the node group.

Shorthand Syntax:

```hcl
{
  scale-type = auto-scale={
    initial-size = integer,
    max-size = integer,
    min-size = integer
  } | fixed-scale={
    size = integer
  }
}
```

JSON Syntax:

```json
{
  "scale-type": {
    "auto-scale": {
      "initial-size": "integer",
      "max-size": "integer",
      "min-size": "integer"
    },
    "fixed-scale": {
      "size": "integer"
    }
  }
}
```

Fields:

```
scale-type -> (oneof<auto-scale|fixed-scale>)
  Oneof scale-type field
  fixed-scale -> (struct)
    Fixed scale policy of the node group.
    size -> (integer)
      Number of nodes in the node group.
  auto-scale -> (struct)
    Auto scale policy of the node group.
    initial-size -> (integer)
      Initial number of nodes in the node group.
    max-size -> (integer)
      Maximum number of nodes in the node group.
    min-size -> (integer)
      Minimum number of nodes in the node group.
``` ||
|| `--version` | `shorthand/json`

Version of Kubernetes components that runs on the nodes.

Shorthand Syntax:

```hcl
{
  specifier = latest-revision=boolean | version=string
}
```

JSON Syntax:

```json
{
  "specifier": {
    "latest-revision": "boolean",
    "version": "string"
  }
}
```

Fields:

```
specifier -> (oneof<latest-revision|version>)
  Oneof specifier field
  version -> (string)
    Request update to a newer version of Kubernetes (1.x -> 1.y).
  latest-revision -> (boolean)
    Request update to the latest revision for the current version.
``` ||
|| `--workload-identity-federation` | `shorthand/json`

Workload Identity Federation parameters of the node group.

Shorthand Syntax:

```hcl
{
  enabled = boolean
}
```

JSON Syntax:

```json
{
  "enabled": "boolean"
}
```

Fields:

```
enabled -> (boolean)
  Identifies whether Workload Identity Federation is enabled.
``` ||
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