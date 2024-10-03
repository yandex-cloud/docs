---
editable: false
---

# yc serverless trigger update

Update the specified trigger

#### Command Usage

Syntax: 

`yc serverless trigger update <command>`

#### Command Tree

- [yc serverless trigger update timer](timer.md) — Update timer trigger
- [yc serverless trigger update message-queue](message-queue.md) — Update message queue trigger
- [yc serverless trigger update internet-of-things](internet-of-things.md) — Update internet of things trigger
- [yc serverless trigger update iot-broker](iot-broker.md) — Update IoT broker trigger
- [yc serverless trigger update object-storage](object-storage.md) — Update object storage trigger
- [yc serverless trigger update container-registry](container-registry.md) — Update container registry trigger
- [yc serverless trigger update logging](logging.md) — Update logging trigger
- [yc serverless trigger update yds](yds.md) — Update YDS trigger
- [yc serverless trigger update billing-budget](billing-budget.md) — Update billing budget trigger
- [yc serverless trigger update mail](mail.md) — Update Mail trigger

#### Flags

| Flag | Description |
|----|----|
|`--new-name`|<b>`string`</b><br/>New trigger name.|
|`--description`|<b>`string`</b><br/>Trigger description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs.|
|`--id`|<b>`string`</b><br/>Trigger id.|
|`--name`|<b>`string`</b><br/>Trigger name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
