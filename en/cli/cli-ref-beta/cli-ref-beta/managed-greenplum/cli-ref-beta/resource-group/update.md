---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-greenplum/cli-ref-beta/resource-group/update.md
---

# yc beta managed-greenplum resource-group update

Update resource group

#### Command Usage

Syntax: 

`yc beta managed-greenplum resource-group update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>|
|`--resource-group`|<b>`shorthand/json`</b><br/><br/>Example:|
|`--resource-group`|<b>`concurrency=42,`</b><br/>cpu-rate-limit=42, is-user-defined=true, memory-limit=42, memory-shared-quota=42, memory-spill-ratio=42, name=value<br/><br/>Shorthand Syntax:<br/>{concurrency=int, cpu-rate-limit=int, is-user-defined=bool, memory-limit=int, memory-shared-quota=int, memory-spill-ratio=int, name=str}<br/>Fields:<br/>concurrency          int               — References to CONCURRENCY from gp resource group parameter<br/>cpu-rate-limit       int               — References to CPU_RATE_LIMIT from gp resource group parameter<br/>is-user-defined      bool              —<br/>memory-limit         int               — References to MEMORY_LIMIT from gp resource group parameter<br/>memory-shared-quota  int               — References to MEMORY_SHARED_QUOTA from gp resource group parameter<br/>memory-spill-ratio   int               — References to MEMORY_SPILL_RATIO from gp resource group parameter<br/>name                 string  required  —<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
