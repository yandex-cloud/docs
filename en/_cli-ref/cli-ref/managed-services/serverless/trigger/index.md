# yc serverless trigger

Manage triggers

#### Command Usage

Syntax: 

`yc serverless trigger <group|command>`

#### Command Tree

- [yc serverless trigger get](get.md) — Show information about the specified trigger
- [yc serverless trigger list](list.md) — List triggers
- [yc serverless trigger update](update.md) — Update the specified trigger
- [yc serverless trigger add-labels](add-labels.md) — Add labels to specified trigger
- [yc serverless trigger remove-labels](remove-labels.md) — Remove labels from specified trigger
- [yc serverless trigger delete](delete.md) — Delete the specified trigger
- [yc serverless trigger pause](pause.md) — Pause the specified trigger
- [yc serverless trigger resume](resume.md) — Resume the specified trigger
- [yc serverless trigger list-operations](list-operations.md) — Show history of the tag for the specified trigger
- [yc serverless trigger create](create/index.md) — Create triggers
	- [yc serverless trigger create timer](create/timer.md) — Create timer trigger
	- [yc serverless trigger create message-queue](create/message-queue.md) — Create message queue trigger
	- [yc serverless trigger create internet-of-things](create/internet-of-things.md) — Create internet of things trigger
	- [yc serverless trigger create iot-broker](create/iot-broker.md) — Create IoT broker trigger
	- [yc serverless trigger create object-storage](create/object-storage.md) — Create object storage trigger
	- [yc serverless trigger create container-registry](create/container-registry.md) — Create container registry trigger
	- [yc serverless trigger create cloud-logs](create/cloud-logs.md) — Create cloud logs trigger
	- [yc serverless trigger create logging](create/logging.md) — Create logging trigger
	- [yc serverless trigger create billing-budget](create/billing-budget.md) — Create billing budget trigger
	- [yc serverless trigger create yds](create/yds.md) — Create YDS trigger
	- [yc serverless trigger create mail](create/mail.md) — Create Mail trigger

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
