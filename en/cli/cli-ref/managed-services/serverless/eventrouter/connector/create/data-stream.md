---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/serverless/eventrouter/connector/create/data-stream.md
---

# yc serverless eventrouter connector create data-stream

Create a data stream connector

#### Command Usage

Syntax: 

`yc serverless eventrouter connector create data-stream <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--bus-id`|<b>`string`</b><br/>Connector bus id.|
|`--name`|<b>`string`</b><br/>Connector name.|
|`--description`|<b>`string`</b><br/>Connector description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--deletion-protection`|Prevents accidental connector removal.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--database`|<b>`string`</b><br/>Stream database. Example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********|
|`--stream-name`|<b>`string`</b><br/>Stream name, absolute or relative.|
|`--consumer`|<b>`string`</b><br/>Stream consumer name.|
|`--service-account-id`|<b>`string`</b><br/>Service account which has read permission on the stream.|

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
