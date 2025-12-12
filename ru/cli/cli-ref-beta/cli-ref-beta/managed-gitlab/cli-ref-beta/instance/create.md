---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-gitlab/cli-ref-beta/instance/create.md
---

# yc beta managed-gitlab instance create

Creates a new GitLab instance in the specified folder.

#### Command Usage

Syntax: 

`yc beta managed-gitlab instance create <APPROVAL-RULES-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--admin-email`|<b>`string`</b><br/>Admin user email.|
|`--admin-login`|<b>`string`</b><br/>Admin user login.|
|`--approval-rules-id`|<b>`string`</b><br/>ID of approval rules for the instance.|
|`--backup-retain-period-days`|<b>`int`</b><br/>Number of days to retain backups.|
|`--deletion-protection`|Whether deletion protection is enabled.|
|`--description`|<b>`string`</b><br/>Description of the instance.|
|`--disk-size`|<b>`int`</b><br/>Disk size in bytes.|
|`--domain-prefix`|<b>`string`</b><br/>Domain prefix for the GitLab instance.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create instance in.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the instance as '' key:value '' pairs. For example, "env": "prod".|
|`--maintenance-delete-untagged`|Whether to delete untagged resources during maintenance.|
|`--name`|<b>`string`</b><br/>Name of the instance (must be unique within the folder).|
|`--resource-preset-id`|<b>`string`</b><br/>ID of the resource preset for computational resources.|
|`--subnet-id`|<b>`string`</b><br/>ID of the subnet where instance will be created.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
