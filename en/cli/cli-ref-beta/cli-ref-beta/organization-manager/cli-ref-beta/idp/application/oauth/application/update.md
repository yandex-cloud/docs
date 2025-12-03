---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/application/oauth/application/update.md
---

# yc beta organization-manager idp application oauth application update

Updates the specified OAuth application.

#### Command Usage

Syntax: 

`yc beta organization-manager idp application oauth application update <APPLICATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--application-id`|<b>`string`</b><br/>ID of the OAuth application to update.<br/>To get the OAuth application ID, make a [ApplicationService.List] request.|
|`--client-grant`|<b>`shorthand/json`</b><br/>Connection to the OAuth client with specified scopes<br/><br/>Example:|
|`--client-grant`|<b>`authorized-scopes=value,`</b><br/>client-id=value<br/><br/>Shorthand Syntax:<br/>{authorized-scopes=str,..., client-id=str}<br/>Fields:<br/>authorized-scopes  []string            — List of authorized client scopes by the application<br/>client-id          string    required  — OAuth client id<br/>|
|`--description`|<b>`string`</b><br/>Description of the OAuth application.|
|`--group-claims-settings`|<b>`shorthand/json`</b><br/>Settings of the group claims<br/><br/>Example:<br/>--group-claims-settings group-distribution-type=NONE<br/><br/>Shorthand Syntax:<br/>{group-distribution-type=NONE\|ASSIGNED_GROUPS\|ALL_GROUPS}<br/>Fields:<br/>group-distribution-type  enum<ALL_GROUPS\|ASSIGNED_GROUPS\|NONE>  — Represents current distribution type of the groups. I.e. which groups are visible for the application users.<br/>|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as key:value pairs.|
|`--name`|<b>`string`</b><br/>Name of the OAuth application.<br/>The name must be unique within the organization.|
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
