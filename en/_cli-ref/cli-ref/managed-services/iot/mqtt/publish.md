---
editable: false
---

# yc iot mqtt publish

Publish telemetry

#### Command Usage

Syntax: 

`yc iot mqtt publish [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cert`|<b>`string`</b><br/>Client certificate for authentication.|
|`--key`|<b>`string`</b><br/>Client private key for authentication.|
|`-u`,`--username`|<b>`string`</b><br/>Provide a username.|
|`-P`,`--password`|<b>`string`</b><br/>Provide a password. Not recommended for usage. Will ask password when --password isn't present.|
|`-t`,`--topic`|<b>`string`</b><br/>Mqtt topic name.|
|`-q`,`--qos`|<b>`string`</b><br/>Quality of service level to use for all messages (0 or 1)/(at-most-once or at-least-once). Defaults to 0.|
|`-m`,`--message`|<b>`string`</b><br/>Message payload to send.|
|`-f`,`--file`|<b>`string`</b><br/>Send the contents of a file as the message.|
|`-l`,`--stdin`|Read messages from stdin, sending a separate message for each line.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
