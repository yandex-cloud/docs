---
sourcePath: en/_cli-ref/cli-ref/managed-services/dns/bind-file/migrate-to-terraform.md
---
# yc dns bind-file migrate-to-terraform

Writes terraform specification to stdout

#### Command Usage

Syntax: 

`yc dns bind-file migrate-to-terraform <PATH TO FILE> [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--file`|<b>`string`</b><br/>Path to a text file that contains dns resource records in text form described in rfc1035.|
|`--zone-name`|<b>`string`</b><br/>The name of the dns zone where records will be created.|
|`--exclude-types`|<b>`string`</b><br/>The types of records to exclude. Default value - NS,SOA.|
|`--domain`|<b>`string`</b><br/>The domain that will be used as origin.|

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
