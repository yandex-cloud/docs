# yc iot mqtt subscribe

Subscribe telemetry

#### Command Usage

Syntax: 

`yc iot mqtt subscribe [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cert`|<b>`string`</b><br/>Client certificate for authentication.|
|`--key`|<b>`string`</b><br/>Client private key for authentication.|
|`-u`,`--username`|<b>`string`</b><br/>Provide a username.|
|`-P`,`--password`|<b>`string`</b><br/>Provide a password. Not recommended for usage. Will ask password when --password isn't present.|
|`-t`,`--topic`|<b>`string`</b><br/>Mqtt topic name.|
|`-q`,`--qos`|<b>`string`</b><br/>Quality of service level to use for all messages (0 or 1)/(at-most-once or at-least-once). Defaults to 0.|
|`--details`|Print topic name, qos, message id for subscribed data.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
