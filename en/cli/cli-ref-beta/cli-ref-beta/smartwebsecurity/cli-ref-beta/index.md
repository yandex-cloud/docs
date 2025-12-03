---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/smartwebsecurity/cli-ref-beta/index.md
---

# yc beta smartwebsecurity

Manage SmartWebSecurity resources

#### Command Usage

Syntax: 

`yc beta smartwebsecurity <group>`

#### Command Tree

- [yc beta smartwebsecurity security-profile](security-profile/index.md) — A set of methods for managing SecurityProfile resources.
	- [yc beta smartwebsecurity security-profile create](security-profile/create.md) — Creates a security profile in the specified folder using the data specified in the request.
	- [yc beta smartwebsecurity security-profile delete](security-profile/delete.md) — Deletes the specified security profile.
	- [yc beta smartwebsecurity security-profile get](security-profile/get.md) — Returns the specified SecurityProfile resource.
	- [yc beta smartwebsecurity security-profile list](security-profile/list.md) — Retrieves the list of SecurityProfile resources in the specified folder.
	- [yc beta smartwebsecurity security-profile update](security-profile/update.md) — Updates the specified security profile.

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
