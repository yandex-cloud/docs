---
editable: false
noIndex: true
---

# yc beta managed-mongodb cluster update-hosts

Updates the specified parameters for the host.

#### Command Usage

Syntax:

`yc beta managed-mongodb cluster update-hosts <CLUSTER-ID>`

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
|| `--cluster-id` | `string`

ID of the MongoDB cluster to update hosts from. To get the MongoDB cluster ID, use a [ClusterService.List] request. ||
|| `--update-host-specs` | `shorthand/json`

New configurations to apply to hosts of a Managed Service for MongoDB cluster.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    hidden = boolean,
    host-name = string,
    priority = float64,
    secondary-delay-secs = integer,
    tags = {key=string, key=...}
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "boolean",
    "hidden": "boolean",
    "host-name": "string",
    "priority": "float64",
    "secondary-delay-secs": "integer",
    "tags": {
      "<key>": "string", ...
    }
  }, ...
]
```

Fields:

```
assign-public-ip -> (boolean)
  Determines whether the host should get a public IP address after the update.
hidden -> (boolean)
  Determines if the host is a hidden replica set member. Such members cannot become primary in a replica set, and they are invisible to client applications. However, hidden members can participate in elections of the primary host. For more information, see the MongoDB documentation.
host-name -> (string)
  Host to be updated. Specify the host FQDN.
priority -> (float64)
  Priority of the host to be elected as the primary in the replica set. The minimum value is '0' if the Managed Service for MongoDB cluster contains three or more secondary hosts. Otherwise, the minimum value is '1'.
secondary-delay-secs -> (integer)
  The time, in seconds, by which the given replica set member lags behind the primary host.
tags -> (map[string,string])
  Host tag list that contains key-value pairs for the given replica set member. For more information about how to specify the tags and what values to choose, see the MongoDB documentation.
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