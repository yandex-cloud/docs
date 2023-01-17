---
editable: false
---

# yc managed-kafka connector

Manage Kafka connectors.

#### Command Usage

Syntax: 

`yc managed-kafka connector <command>`

Aliases: 

- `connectors`

#### Command Tree

- [yc managed-kafka connector get](get.md) — Get information about a Kafka connector.
- [yc managed-kafka connector list](list.md) — List connectors of a Kafka cluster.
- [yc managed-kafka connector delete](delete.md) — Delete a Kafka connector.
- [yc managed-kafka connector pause](pause.md) — Pause a Kafka connector.
- [yc managed-kafka connector resume](resume.md) — Resume a Kafka connector.

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
