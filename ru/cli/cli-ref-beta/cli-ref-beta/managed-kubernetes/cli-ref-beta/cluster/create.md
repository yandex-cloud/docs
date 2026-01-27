---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kubernetes/cli-ref-beta/cluster/create.md
---

# yc beta managed-kubernetes cluster create

Creates a Kubernetes cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-kubernetes cluster create <FOLDER-ID>`

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
|| `--description` | `string`

Description of the Kubernetes cluster. ||
|| `--folder-id` | `string`

ID of the folder to create a Kubernetes cluster in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--ip-allocation-policy` | `shorthand/json`

IP allocation policy of the Kubernetes cluster.

Shorthand Syntax:

```hcl
{
  cluster-ipv4-cidr-block = str,
  cluster-ipv6-cidr-block = str,
  node-ipv4-cidr-mask-size = int,
  service-ipv4-cidr-block = str,
  service-ipv6-cidr-block = str
}
```

JSON Syntax:

```json
{
  "cluster-ipv4-cidr-block": "str",
  "cluster-ipv6-cidr-block": "str",
  "node-ipv4-cidr-mask-size": "int",
  "service-ipv4-cidr-block": "str",
  "service-ipv6-cidr-block": "str"
}
```

Fields:

```
cluster-ipv4-cidr-block -> (string)
  CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.
cluster-ipv6-cidr-block -> (string)
  IPv6 range for allocating pod IP addresses.
node-ipv4-cidr-mask-size -> (int)
  Size of the masks that are assigned for each node in the cluster. If not specified, 24 is used.
service-ipv4-cidr-block -> (string)
  CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in.
service-ipv6-cidr-block -> (string)
  IPv6 range for allocating Kubernetes service IP addresses
``` ||
|| `--kms-provider` | `shorthand/json`

KMS provider configuration.

Shorthand Syntax:

```hcl
{
  key-id = str
}
```

JSON Syntax:

```json
{
  "key-id": "str"
}
```

Fields:

```
key-id -> (string)
  KMS key ID for secrets encryption. To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List] request.
``` ||
|| `--labels` | `stringToString`

Resource labels as 'key:value' pairs. ||
|| `--master-spec` | `shorthand/json`

Master specification of the Kubernetes cluster.

Shorthand Syntax:

```hcl
{
  etcd-cluster-size = int,
  external-v4-address-spec = {
    address = str
  },
  external-v6-address-spec = {
    address = str
  },
  locations = [
    {
      subnet-id = str,
      zone-id = str
    }, ...
  ],
  maintenance-policy = {
    auto-upgrade = bool,
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
  },
  master-logging = {
    audit-enabled = bool,
    cluster-autoscaler-enabled = bool,
    destination = folder-id=str | log-group-id=str,
    enabled = bool,
    events-enabled = bool,
    kube-apiserver-enabled = bool
  },
  master-type = regional-master-spec={
    external-v4-address-spec = {
      address = str
    },
    external-v6-address-spec = {
      address = str
    },
    locations = [
      {
        internal-v4-address-spec = {
          subnet-id = str
        },
        zone-id = str
      }, ...
    ],
    region-id = str
  } | zonal-master-spec={
    external-v4-address-spec = {
      address = str
    },
    internal-v4-address-spec = {
      subnet-id = str
    },
    zone-id = str
  },
  scale-policy = {
    scale-type = auto-scale={
      min-resource-preset-id = str
    }
  },
  security-group-ids = str,...,
  version = str
}
```

JSON Syntax:

```json
{
  "etcd-cluster-size": "int",
  "external-v4-address-spec": {
    "address": "str"
  },
  "external-v6-address-spec": {
    "address": "str"
  },
  "locations": [
    {
      "subnet-id": "str",
      "zone-id": "str"
    }, ...
  ],
  "maintenance-policy": {
    "auto-upgrade": "bool",
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
  },
  "master-logging": {
    "audit-enabled": "bool",
    "cluster-autoscaler-enabled": "bool",
    "destination": {
      "folder-id": "str",
      "log-group-id": "str"
    },
    "enabled": "bool",
    "events-enabled": "bool",
    "kube-apiserver-enabled": "bool"
  },
  "master-type": {
    "regional-master-spec": {
      "external-v4-address-spec": {
        "address": "str"
      },
      "external-v6-address-spec": {
        "address": "str"
      },
      "locations": [
        {
          "internal-v4-address-spec": {
            "subnet-id": "str"
          },
          "zone-id": "str"
        }, ...
      ],
      "region-id": "str"
    },
    "zonal-master-spec": {
      "external-v4-address-spec": {
        "address": "str"
      },
      "internal-v4-address-spec": {
        "subnet-id": "str"
      },
      "zone-id": "str"
    }
  },
  "scale-policy": {
    "scale-type": {
      "auto-scale": {
        "min-resource-preset-id": "str"
      }
    }
  },
  "security-group-ids": [
    "str", ...
  ],
  "version": "str"
}
```

Fields:

```
etcd-cluster-size -> (int)
  Number of etcd nodes in cluster. Works in conjunction with [locations]. See it's documentation for details. Optional. If not set, will be assumed equal to the number of locations.
external-v4-address-spec -> (struct)
  Specification of parameters for external IPv4 networking.
  address -> (string)
    IP address.
external-v6-address-spec -> (struct)
  Specification of parameters for external IPv6 networking.
  address -> (string)
    IP address.
locations -> ([]struct)
  Locations specification for Kubernetes control-plane (master) instances. Works in conjunction with [etcd_cluster_size]. See it's documentation for details. Possible combinations: - 1 location and etcd_cluster_size = 1 - a single node cluster whose availability is limited by the availability of a single Compute Instance; downtime is expected during cluster updates. - 1 location and etcd_cluster_size = 3 - a highly available cluster within a single availability zone; can survive the failure of a Compute Instance, a server, or an individual server rack. - 3 location and etcd_cluster_size = 3 - a highly available cluster with each etcd instance located within separate availability zone; can survive the failure of a single availability zone.
  subnet-id -> (string)
    ID of the VPC network's subnet where the master resides. If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.
  zone-id -> (string)
    ID of the availability zone where the master resides.
maintenance-policy -> (struct)
  Maintenance policy of the master.
  auto-upgrade -> (bool)
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
master-logging -> (struct)
  Cloud Logging for master components.
  audit-enabled -> (bool)
    Identifies whether Cloud Logging is enabled for audit logs.
  cluster-autoscaler-enabled -> (bool)
    Identifies whether Cloud Logging is enabled for cluster-autoscaler.
  enabled -> (bool)
    Identifies whether Cloud Logging is enabled for master components.
  events-enabled -> (bool)
    Identifies whether Cloud Logging is enabled for events.
  kube-apiserver-enabled -> (bool)
    Identifies whether Cloud Logging is enabled for kube-apiserver.
  destination -> (oneof<folder-id|log-group-id>)
    Oneof destination field
    log-group-id -> (string)
      ID of the log group where logs of master components should be stored.
    folder-id -> (string)
      ID of the folder where logs should be stored (in default group).
scale-policy -> (struct)
  Scale policy of the master.
  scale-type -> (oneof<auto-scale>)
    Oneof scale-type field
    auto-scale -> (struct)
      min-resource-preset-id -> (string)
        Preset of computing resources to be used as lower boundary for scaling.
security-group-ids -> ([]string)
  Master security groups.
version -> (string)
  Version of Kubernetes components that runs on the master.
master-type -> (oneof<regional-master-spec|zonal-master-spec>)
  Oneof master-type field
  zonal-master-spec -> (struct)
    Specification of the zonal master.
    external-v4-address-spec -> (struct)
      Specification of parameters for external IPv4 networking.
      address -> (string)
        IP address.
    internal-v4-address-spec -> (struct)
      Specification of parameters for internal IPv4 networking.
      subnet-id -> (string)
        ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.
    zone-id -> (string)
      ID of the availability zone.
  regional-master-spec -> (struct)
    Specification of the regional master.
    external-v4-address-spec -> (struct)
      Specify to allocate a static public IP for the master.
      address -> (string)
        IP address.
    external-v6-address-spec -> (struct)
      Specification of parameters for external IPv6 networking.
      address -> (string)
        IP address.
    locations -> ([]struct)
      List of locations where the master will be allocated.
      internal-v4-address-spec -> (struct)
        If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.
        subnet-id -> (string)
          ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.
      zone-id -> (string)
        ID of the availability zone.
    region-id -> (string)
      ID of the availability zone where the master resides.
``` ||
|| `--name` | `string`

Name of the Kubernetes cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network. ||
|| `--network-policy` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  provider = CALICO
}
```

JSON Syntax:

```json
{
  "provider": "CALICO"
}
```

Fields:

```
provider -> (struct)
``` ||
|| `--node-service-account-id` | `string`

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| `--release-channel` | `enum`

Release channel for the master. Possible Values: 'rapid', 'regular', 'stable' ||
|| `--service-account-id` | `string`

Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have 'edit' role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides. ||
|| `--workload-identity-federation` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  enabled = bool
}
```

JSON Syntax:

```json
{
  "enabled": "bool"
}
```

Fields:

```
enabled -> (bool)
  Identifies whether Workload Identity Federation is enabled.
``` ||
|| `--gateway-ipv4-address` | `string`

Gateway IPv4 address. ||
|| `--cilium` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  routing-mode = TUNNEL
}
```

JSON Syntax:

```json
{
  "routing-mode": "TUNNEL"
}
```

Fields:

```
routing-mode -> (struct)
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