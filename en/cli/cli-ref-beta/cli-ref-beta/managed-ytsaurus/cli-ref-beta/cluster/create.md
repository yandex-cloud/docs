---
editable: false
noIndex: true
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
  v4-cidr-blocks = string,...
}
```

JSON Syntax:

```json
{
  "v4-cidr-blocks": [
    "string", ...
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
|| `--labels` | `map<string><string>`

Cluster labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the cluster. ||
|| `--security-group-ids` | `[]string`

IDs of the security groups to attach to the cluster. ||
|| `--spec` | `shorthand/json`

Cluster specification.

Shorthand Syntax:

```hcl
{
  client-logging = {
    audit-logs-enabled = boolean,
    destination = folder-id=string | log-group-id=string,
    service-account-id = string
  },
  compute = [
    {
      disks = [
        {
          locations = string,...,
          size-gb = integer,
          type = string
        }, ...
      ],
      name = string,
      preset = string,
      scale-policy = {
        policy = auto={
          max-size = integer,
          min-size = integer
        } | fixed={
          size = integer
        }
      }
    }, ...
  ],
  cron = {
    clear-tmp = {
      account-usage-ratio-save-per-owner = float64,
      account-usage-ratio-save-total = float64,
      interval = duration,
      max-dir-node-count = integer
    }
  },
  excel = {
    enabled = boolean
  },
  flavor = DEMO,
  odin = {
    checks-ttl = duration
  },
  proxy = {
    http = {
      count = integer
    },
    rpc = {
      count = integer
    },
    task = {
      count = integer
    }
  },
  storage = {
    hdd = {
      count = integer,
      size-gb = integer
    },
    ssd = {
      changelogs = {
        size-gb = integer
      },
      count = integer,
      size-gb = integer,
      type = string
    }
  },
  tablet = {
    count = integer,
    preset = string
  }
}
```

JSON Syntax:

```json
{
  "client-logging": {
    "audit-logs-enabled": "boolean",
    "destination": {
      "folder-id": "string",
      "log-group-id": "string"
    },
    "service-account-id": "string"
  },
  "compute": [
    {
      "disks": [
        {
          "locations": [
            "string", ...
          ],
          "size-gb": "integer",
          "type": "string"
        }, ...
      ],
      "name": "string",
      "preset": "string",
      "scale-policy": {
        "policy": {
          "auto": {
            "max-size": "integer",
            "min-size": "integer"
          },
          "fixed": {
            "size": "integer"
          }
        }
      }
    }, ...
  ],
  "cron": {
    "clear-tmp": {
      "account-usage-ratio-save-per-owner": "float64",
      "account-usage-ratio-save-total": "float64",
      "interval": "duration",
      "max-dir-node-count": "integer"
    }
  },
  "excel": {
    "enabled": "boolean"
  },
  "flavor": "DEMO",
  "odin": {
    "checks-ttl": "duration"
  },
  "proxy": {
    "http": {
      "count": "integer"
    },
    "rpc": {
      "count": "integer"
    },
    "task": {
      "count": "integer"
    }
  },
  "storage": {
    "hdd": {
      "count": "integer",
      "size-gb": "integer"
    },
    "ssd": {
      "changelogs": {
        "size-gb": "integer"
      },
      "count": "integer",
      "size-gb": "integer",
      "type": "string"
    }
  },
  "tablet": {
    "count": "integer",
    "preset": "string"
  }
}
```

Fields:

```
client-logging -> (struct)
  Client Cloud logging configuration.
  audit-logs-enabled -> (boolean)
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
    size-gb -> (integer)
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
        size -> (integer)
          Amount of exec nodes.
      auto -> (struct)
        Scale policy that can adjust number of running exec nodes within specified range based on some criteria.
        max-size -> (integer)
          Maximum amount of exec nodes.
        min-size -> (integer)
          Minimal amount of exec nodes.
cron -> (struct)
  Cluster regular processing settings.
  clear-tmp -> (struct)
    Cluster regular tmp-account cleaning settings.
    account-usage-ratio-save-per-owner -> (float64)
      Per account max space usage ratio.
    account-usage-ratio-save-total -> (float64)
      Total max space usage ratio.
    interval -> (duration)
      Script starting interval.
    max-dir-node-count -> (integer)
      Max nodes in every directory.
excel -> (struct)
  Cluster Excel configuration.
  enabled -> (boolean)
    Enable Excel.
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
    count -> (integer)
      Total amount of HTTP proxies.
  rpc -> (struct)
    Configuration of rpc proxies.
    count -> (integer)
      Total amount of RPC proxies.
  task -> (struct)
    Configuration of task proxies.
    count -> (integer)
      Total amount of task proxies.
storage -> (struct)
  Cluster storage configuration.
  hdd -> (struct)
    Configuration of cluster HDD strorage.
    count -> (integer)
      Total amount of HDD disks.
    size-gb -> (integer)
      Size of a single HDD disk in GB.
  ssd -> (struct)
    Configuration of cluster SSD strorage
    changelogs -> (struct)
      Configuration of dynamic table changelogs.
      size-gb -> (integer)
        Size of changelogs disk in GB.
    count -> (integer)
      Total amount of SSD disks.
    size-gb -> (integer)
      Size of a single SSD disk in GB.
    type -> (string)
      Type of a SSD disk.
tablet -> (struct)
  Cluster tablet nodes configuration.
  count -> (integer)
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