---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/eventrouter/rule/index.md
---

# yc beta serverless eventrouter rule

A set of methods for managing rules for serverless eventrouter.

#### Command Usage

Syntax: 

`yc beta serverless eventrouter rule <command>`

#### Command Tree

- [yc beta serverless eventrouter rule create](create.md) — Creates a rule in the specified folder.
- [yc beta serverless eventrouter rule delete](delete.md) — Deletes the specified rule.
- [yc beta serverless eventrouter rule disable](disable.md) — Disables the specified rule.
- [yc beta serverless eventrouter rule enable](enable.md) — Enables the specified rule.
- [yc beta serverless eventrouter rule get](get.md) — Returns the specified rules.
- [yc beta serverless eventrouter rule list](list.md) — Retrieves the list of rules in the specified folder.
- [yc beta serverless eventrouter rule list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified rule.
- [yc beta serverless eventrouter rule list-operations](list-operations.md) — Lists operations for the specified rule.
- [yc beta serverless eventrouter rule set-access-bindings](set-access-bindings.md) — Sets access bindings for the rule.
- [yc beta serverless eventrouter rule update](update.md) — Updates the specified rule.
- [yc beta serverless eventrouter rule update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified rule.

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
