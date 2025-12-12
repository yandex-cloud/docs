---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/point-of-presence/get.md
---

# yc beta cic point-of-presence get

Returns the specified PointOfPresence resource.

#### Command Usage

Syntax: 

`yc beta cic point-of-presence get <POINT-OF-PRESENCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--point-of-presence-id`|<b>`string`</b><br/>ID of the PointOfPresence resource to return. To get the pointOfPresence ID use a [PointOfPresenceService.List] request.|

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
