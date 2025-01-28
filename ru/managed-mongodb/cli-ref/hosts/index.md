---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-mongodb/cli-ref/hosts/index.md
---

# yc managed-mongodb hosts

Manage hosts of a MongoDB cluster.

#### Command Usage

Syntax: 

`yc managed-mongodb hosts <command>`

Aliases: 

- `host`

#### Command Tree

- [yc managed-mongodb hosts add](add.md) — Add new hosts to the cluster in specified availability zones.
- [yc managed-mongodb hosts delete](delete.md) — Remove specified hosts from the a cluster.
- [yc managed-mongodb hosts list](list.md) — List hosts for a MongoDB cluster.
- [yc managed-mongodb hosts resetup](resetup.md) — Resetup specified MongoD hosts.
- [yc managed-mongodb hosts restart](restart.md) — Restart specified MongoD hosts.
- [yc managed-mongodb hosts stepdown](stepdown.md) — Stepdown specified MongoD hosts.
- [yc managed-mongodb hosts update](update.md) — Update specified hosts in the cluster.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
