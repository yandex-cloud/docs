---
editable: false
---

# yc managed-gitlab instance create

Create Gitlab instance

#### Command Usage

Syntax: 

`yc managed-gitlab instance create <INSTANCE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the Gitlab instance.|
|`--description`|<b>`string`</b><br/>Description of the instance.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of Gitlab instance labels as key-value pairs.|
|`--resource-preset-id`|<b>`string`</b><br/>ID of the preset for computational resources available to the instance (CPU, memory etc.). One of: s2.micro, s2.small, s2.medium, s2.large.|
|`--disk-size`|<b>`byteSize`</b><br/>Amount of disk storage available to a instance in GB.|
|`--admin-login`|<b>`string`</b><br/>A login of admin user in Gitlab.|
|`--admin-email`|<b>`string`</b><br/>A email of admin user in Gitlab.|
|`--domain-prefix`|<b>`string`</b><br/>Domain prefix for Gitlab instance.|
|`--subnet-id`|<b>`string`</b><br/>ID of the subnet that Gitlab instance should be created in.|
|`--backup-retain-period-days`|<b>`int`</b><br/>Auto backups retain period in days.|
|`--maintenance-delete-untagged`|Delete untagged images during maintenance.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the instance.|
|`--approval-rules`|<b>`string`</b><br/>Approval rules configuration. One of: BASIC, STANDARD, ADVANCED.|
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
