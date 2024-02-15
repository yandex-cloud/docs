---
editable: false
---

# yc loadtesting

Manage Yandex Load Testing resources

#### Command Usage

Syntax: 

`yc loadtesting <group>`

#### Command Tree

- [yc loadtesting agent](agent/index.md) — Manage load testing agents
	- [yc loadtesting agent get](agent/get.md) — Show information about the specified load testing agent
	- [yc loadtesting agent list](agent/list.md) — List agents
	- [yc loadtesting agent create](agent/create.md) — Create a load testing agent
	- [yc loadtesting agent delete](agent/delete.md) — Delete the specified load testing agent
- [yc loadtesting test-config](test-config/index.md) — Manage load testing test configs
	- [yc loadtesting test-config get](test-config/get.md) — Show information about the specified load testing config
	- [yc loadtesting test-config list](test-config/list.md) — List load testing configs
	- [yc loadtesting test-config create](test-config/create.md) — Create a load testing config
- [yc loadtesting test](test/index.md) — Manage load testing test config executions
	- [yc loadtesting test get](test/get.md) — Show information about the specified test
	- [yc loadtesting test list](test/list.md) — List tests
	- [yc loadtesting test create](test/create.md) — Create a test
	- [yc loadtesting test delete](test/delete.md) — Delete the specified test
	- [yc loadtesting test stop](test/stop.md) — Stop running test
	- [yc loadtesting test get-report-table](test/get-report-table.md) — Get report table for finished test.

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
|`-h`,`--help`|Display help for the command.|
