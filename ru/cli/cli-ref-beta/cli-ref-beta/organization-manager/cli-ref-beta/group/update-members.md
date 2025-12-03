---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/group/update-members.md
---

# yc beta organization-manager group update-members

Update group members.

#### Command Usage

Syntax: 

`yc beta organization-manager group update-members <GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--group-id`|<b>`string`</b><br/>ID of the group to update.<br/>To get the group ID, use a [GroupService.List] request.|
|`--member-deltas`|<b>`shorthand/json`</b><br/>Updates to group members.<br/><br/>Example:|
|`--member-deltas`|<b>`[{action=ADD,`</b><br/>subject-id=value}]<br/><br/>Shorthand Syntax:<br/>[{action=ADD\|REMOVE, subject-id=str},...]<br/>Fields:<br/>action      enum<ADD\|REMOVE>  required  — The action that is being performed on a group member.<br/>subject-id  string            required  — ID of the subject that is being added or removed from a group.<br/><br/>Subject type can be one of following values:<br/>* 'userAccount': An account on Yandex, added to Yandex Cloud.<br/>* 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory.<br/>|
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
