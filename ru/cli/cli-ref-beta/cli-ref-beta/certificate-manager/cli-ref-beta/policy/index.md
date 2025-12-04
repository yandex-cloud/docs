---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/policy/index.md
---

# yc beta certificate-manager policy

A set of methods for managing policies.

#### Command Usage

Syntax: 

`yc beta certificate-manager policy <command>`

#### Command Tree

- [yc beta certificate-manager policy create](create.md) — Creates a policy for the specified certificate authority.
- [yc beta certificate-manager policy delete](delete.md) — Deletes the specified policy.
- [yc beta certificate-manager policy get](get.md) — Returns the specified policy.
- [yc beta certificate-manager policy list](list.md) — Retrieves the list of policies of the specified certificate authority.
- [yc beta certificate-manager policy list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified policy.
- [yc beta certificate-manager policy set-access-bindings](set-access-bindings.md) — Sets access bindings for the policy.
- [yc beta certificate-manager policy update](update.md) — Updates the specified policy.
- [yc beta certificate-manager policy update-access-bindings](update-access-bindings.md) — Updates access bindings for the policy.

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
