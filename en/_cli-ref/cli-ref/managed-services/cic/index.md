---
editable: false
---

# yc cic

[PREVIEW] Manage Yandex Cloud Interconnect resources

#### Command Usage

Syntax: 

`yc cic <group>`

#### Command Tree

- [yc cic partner](partner/index.md) — [PREVIEW] Manage partners.
	- [yc cic partner get](partner/get.md) — Get information about a partner.
	- [yc cic partner list](partner/list.md) — List partners in a folder.
- [yc cic point-of-presence](point-of-presence/index.md) — [PREVIEW] Manage point of presences.
	- [yc cic point-of-presence get](point-of-presence/get.md) — Get information about a point of presence.
	- [yc cic point-of-presence list](point-of-presence/list.md) — List point of presences in a folder.
- [yc cic trunk-connection](trunk-connection/index.md) — [PREVIEW] Manage trunk connections.
	- [yc cic trunk-connection get](trunk-connection/get.md) — Get information about a trunk connection.
	- [yc cic trunk-connection list](trunk-connection/list.md) — List trunk connections in a folder.
- [yc cic private-connection](private-connection/index.md) — [PREVIEW] Manage privateConnections.
	- [yc cic private-connection get](private-connection/get.md) — Get information about a privateConnection.
	- [yc cic private-connection list](private-connection/list.md) — List privateConnections in a folder.
- [yc cic public-connection](public-connection/index.md) — [PREVIEW] Manage publicConnections.
	- [yc cic public-connection get](public-connection/get.md) — Get information about an publicConnection.
	- [yc cic public-connection list](public-connection/list.md) — List publicConnections in a folder.

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
