---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# yc logging read

Read logs

#### Command Usage

Syntax: 

`yc logging read <LOG-GROUP-NAME>|<LOG-GROUP-ID>`

#### Global Flags

| Flag | Description |
|----|----|
|`--group-id`|<b>`string`</b><br/>Log group id.|
|`--group-name`|<b>`string`</b><br/>Log group name.|
|`--since`|<b>`timestamp`</b><br/>Show logs since this time|
|`--until`|<b>`timestamp`</b><br/>Show logs until this time|
|`-f`,`--follow`|Output logs as they arrive --resource-types value[,value]   Show logs with these resource types (comma-separated) --resource-ids value[,value]     Show logs with these resource ids (comma-separated) --levels value[,value]           Show logs with these levels (comma-separated)|
|`--filter`|<b>`string`</b><br/>Use this filter|
|`--limit`|<b>`int`</b><br/>The maximum number of records to show.|

#### Flags

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
