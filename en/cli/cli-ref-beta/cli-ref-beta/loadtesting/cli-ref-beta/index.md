---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/loadtesting/cli-ref-beta/index.md
---

# yc beta loadtesting

Manage Load Testing resources

#### Command Usage

Syntax: 

`yc beta loadtesting <group>`

#### Command Tree

- [yc beta loadtesting agent](agent/index.md) — A set of methods for managing Load Testing agents.
	- [yc beta loadtesting agent create](agent/create.md) — Creates an agent in the specified folder.
	- [yc beta loadtesting agent delete](agent/delete.md) — Deletes the specified agent.
	- [yc beta loadtesting agent get](agent/get.md) — Returns the specified agent.
	- [yc beta loadtesting agent list](agent/list.md) — Retrieves the list of agents in the specified folder.
	- [yc beta loadtesting agent update](agent/update.md) — Updates the specified agent.
- [yc beta loadtesting report](report/index.md) — A set of methods for managing test reports.
	- [yc beta loadtesting report calculate-kpi-values](report/calculate-kpi-values.md) — Returns a list of KPI values for tests matching the specified filter.
	- [yc beta loadtesting report get-table](report/get-table.md) — Returns a report table for the specified test.
- [yc beta loadtesting test](test/index.md) — A set of methods for managing tests.
	- [yc beta loadtesting test create](test/create.md) — Creates (runs) a test in the specified folder.
	- [yc beta loadtesting test delete](test/delete.md) — Deletes specified tests.
	- [yc beta loadtesting test get](test/get.md) — Returns the specified test.
	- [yc beta loadtesting test list](test/list.md) — Retrieves the list of test in the specified folder.
	- [yc beta loadtesting test stop](test/stop.md) — Stops the specified test.
- [yc beta loadtesting test-config](test-config/index.md) — A set of methods for managing test configurations.
	- [yc beta loadtesting test-config create](test-config/create.md) — Creates a test config in the specified folder.
	- [yc beta loadtesting test-config delete](test-config/delete.md) — Deletes the specified config.
	- [yc beta loadtesting test-config get](test-config/get.md) — Returns the specified config.
	- [yc beta loadtesting test-config list](test-config/list.md) — Retrieves the list of configs in the specified folder.

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
