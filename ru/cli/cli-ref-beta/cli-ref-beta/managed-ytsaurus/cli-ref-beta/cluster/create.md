---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-ytsaurus/cli-ref-beta/cluster/create.md
---

# yc beta managed-ytsaurus cluster create

Creates a cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-ytsaurus cluster create <FOLDER-ID>`

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
|| `--cidr-blocks-whitelist` | `shorthand/json`

CIDRs whitelist.

Shorthand Syntax:

```hcl
{
  v4-cidr-blocks = str,...
}
```

JSON Syntax:

```json
{
  "v4-cidr-blocks": [
    "str", ...
  ]
}
```

Fields:

```
v4-cidr-blocks -> ([]string)
  IPv4 CIDR blocks.
``` ||
|| `--description` | `string`

Description of the cluster. ||
|| `--folder-id` | `string`

ID of the folder to create the cluster in. ||
|| `--labels` | `stringToString`

Cluster labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the cluster. ||
|| `--security-group-ids` | `strings`

IDs of the security groups to attach to the cluster. ||
|| `--spec` | `shorthand/json`

Cluster specification.

Shorthand Syntax:

```hcl
{
  client-logging = {
    audit-logs-enabled = bool,
    destination = folder-id=str | log-group-id=str,
    service-account-id = str
  },
  compute = [
    {
      disks = [
        {
          locations = str,...,
          size-gb = int,
          type = str
        }, ...
      ],
      name = str,
      preset = str,
      scale-policy = {
        policy = auto={
          max-size = int,
          min-size = int
        } | fixed={
          size = int
        }
      }
    }, ...
  ],
  cron = {
    clear-tmp = {
      account-usage-ratio-save-per-owner = double,
      account-usage-ratio-save-total = double,
      interval = duration,
      max-dir-node-count = int
    }
  },
  flavor = DEMO,
  odin = {
    checks-ttl = duration
  },
  proxy = {
    http = {
      count = int
    },
    rpc = {
      count = int
    }
  },
  storage = {
    hdd = {
      count = int,
      size-gb = int
    },
    ssd = {
      changelogs = {
        size-gb = int
      },
      count = int,
      size-gb = int,
      type = str
    }
  },
  tablet = {
    count = int,
    preset = str
  }
}
```

JSON Syntax:

```json
{
  "client-logging": {
    "audit-logs-enabled": "bool",
    "destination": {
      "folder-id": "str",
      "log-group-id": "str"
    },
    "service-account-id": "str"
  },
  "compute": [
    {
      "disks": [
        {
          "locations": [
            "str", ...
          ],
          "size-gb": "int",
          "type": "str"
        }, ...
      ],
      "name": "str",
      "preset": "str",
      "scale-policy": {
        "policy": {
          "auto": {
            "max-size": "int",
            "min-size": "int"
          },
          "fixed": {
            "size": "int"
          }
        }
      }
    }, ...
  ],
  "cron": {
    "clear-tmp": {
      "account-usage-ratio-save-per-owner": "double",
      "account-usage-ratio-save-total": "double",
      "interval": "duration",
      "max-dir-node-count": "int"
    }
  },
  "flavor": "DEMO",
  "odin": {
    "checks-ttl": "duration"
  },
  "proxy": {
    "http": {
      "count": "int"
    },
    "rpc": {
      "count": "int"
    }
  },
  "storage": {
    "hdd": {
      "count": "int",
      "size-gb": "int"
    },
    "ssd": {
      "changelogs": {
        "size-gb": "int"
      },
      "count": "int",
      "size-gb": "int",
      "type": "str"
    }
  },
  "tablet": {
    "count": "int",
    "preset": "str"
  }
}
```

Fields:

```
client-logging -> (struct)
  Client Cloud logging configuration.
  audit-logs-enabled -> (bool)
    Enable audit logs.
  service-account-id -> (string)
    ID of Service account used for write logs.
  destination -> (oneof<folder-id|log-group-id>)
    Oneof destination field
    log-group-id -> (string)
      ID of cloud logging group.
    folder-id -> (string)
      ID of cloud logging folder. Used default loging group.
compute -> ([]struct)
  Cluster exec nodes configuration.
  disks -> ([]struct)
    Configuration of exec node strorage.
    locations -> ([]string)
      Locations on a disk.
    size-gb -> (int)
      Size of a single disk in GB.
    type -> (string)
      Type of a disk.
  name -> (string)
    Name for exec pool.
  preset -> (string)
    VM configuration preset name.
  scale-policy -> (struct)
    Exec nodes scaling policy.
    policy -> (oneof<auto|fixed>)
      Oneof policy field
      fixed -> (struct)
        Scale policy that doesn't change number of running exec nodes over time.
        size -> (int)
          Amount of exec nodes.
      auto -> (struct)
        Scale policy that can adjust number of running exec nodes within specified range based on some criteria.
        max-size -> (int)
          Maximum amount of exec nodes.
        min-size -> (int)
          Minimal amount of exec nodes.
cron -> (struct)
  Cluster regular processing settings.
  clear-tmp -> (struct)
    Cluster regular tmp-account cleaning settings.
    account-usage-ratio-save-per-owner -> (double)
      Per account max space usage ratio.
    account-usage-ratio-save-total -> (double)
      Total max space usage ratio.
    interval -> (duration)
      Script starting interval.
    max-dir-node-count -> (int)
      Max nodes in every directory.
flavor -> (struct)
  Cluster flavor (type).
odin -> (struct)
  Odin configuration.
  checks-ttl -> (duration)
    TTL of Odin check samples.
proxy -> (struct)
  Cluster proxies configuration.
  http -> (struct)
    Configuration of HTTP proxies.
    count -> (int)
      Total amount of HTTP proxies.
  rpc -> (struct)
    Configuration of rpc proxies.
    count -> (int)
      Total amount of RPC proxies.
storage -> (struct)
  Cluster storage configuration.
  hdd -> (struct)
    Configuration of cluster HDD strorage.
    count -> (int)
      Total amount of HDD disks.
    size-gb -> (int)
      Size of a single HDD disk in GB.
  ssd -> (struct)
    Configuration of cluster SSD strorage
    changelogs -> (struct)
      Configuration of dynamic table changelogs.
      size-gb -> (int)
        Size of changelogs disk in GB.
    count -> (int)
      Total amount of SSD disks.
    size-gb -> (int)
      Size of a single SSD disk in GB.
    type -> (string)
      Type of a SSD disk.
tablet -> (struct)
  Cluster tablet nodes configuration.
  count -> (int)
    Total amount of tablet nodes.
  preset -> (string)
    VM configuration preset name.
``` ||
|| `--subnet-id` | `string`

ID of the subnet to create the cluster in. ||
|| `--zone-id` | `string`

ID of the availability zone where the cluster resides. ||
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