---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kafka/cli-ref-beta/connector/index.md
---

# yc beta managed-kafka connector

A set of methods for managing Apache Kafka® connectors.

#### Command Usage

Syntax: 

`yc beta managed-kafka connector <command>`

#### Command Tree

- [yc beta managed-kafka connector create](create.md) — Creates a new Apache Kafka® connector in a cluster.
- [yc beta managed-kafka connector delete](delete.md) — Deletes an Apache Kafka® connector.
- [yc beta managed-kafka connector get](get.md) — Returns information about an Apache Kafka® connector.
- [yc beta managed-kafka connector list](list.md) — Retrieves the list of Apache Kafka® connectors in a cluster.
- [yc beta managed-kafka connector pause](pause.md) — Pauses an Apache Kafka® connector.
- [yc beta managed-kafka connector resume](resume.md) — Resumes an Apache Kafka® connector.
- [yc beta managed-kafka connector update](update.md) — Updates an Apache Kafka® connector.

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
