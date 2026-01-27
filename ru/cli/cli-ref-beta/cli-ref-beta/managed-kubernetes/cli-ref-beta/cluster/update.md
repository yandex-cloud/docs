---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kubernetes/cli-ref-beta/cluster/update.md
---

# yc beta managed-kubernetes cluster update

Updates the specified Kubernetes cluster.

#### Command Usage

Syntax:

`yc beta managed-kubernetes cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the Kubernetes cluster to update. To get the Kubernetes cluster ID use a [ClusterService.List] request. ||
|| `--description` | `string`

Description of the Kubernetes cluster. ||
|| `--ip-allocation-policy` | `shorthand/json`

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
|| `--labels` | `stringToString`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--master-spec` | `shorthand/json`

Specification of the master update.

Shorthand Syntax:

```hcl
{
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
  scale-policy = {
    scale-type = auto-scale={
      min-resource-preset-id = str
    }
  },
  security-group-ids = str,...,
  version = {
    specifier = latest-revision=bool | version=str
  }
}
```

JSON Syntax:

```json
{
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
  "version": {
    "specifier": {
      "latest-revision": "bool",
      "version": "str"
    }
  }
}
```

Fields:

```
external-v6-address-spec -> (struct)
  Specification of parameters for external IPv6 networking.
  address -> (string)
    IP address.
locations -> ([]struct)
  Update master instance locations.
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
version -> (struct)
  Specification of the master update.
  specifier -> (oneof<latest-revision|version>)
    Oneof specifier field
    version -> (string)
      Request update to a newer version of Kubernetes (1.x -> 1.y).
    latest-revision -> (bool)
      Request update to the latest revision for the current version.
``` ||
|| `--name` | `string`

Name of the Kubernetes cluster. The name must be unique within the folder. ||
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