---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance-group/update-access-bindings.md
---

# yc beta compute instance-group update-access-bindings

Updates access bindings for the specified instance group.

#### Command Usage

Syntax: 

`yc beta compute instance-group update-access-bindings <RESOURCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--access-binding-deltas`|<b>`shorthand/json`</b><br/>Updates to access bindings.<br/><br/>Example:|
|`--access-binding-deltas`|<b>`[{access-binding={role-id=value,`</b><br/>subject={id=value, type=value}}, action=ADD}]<br/><br/>Shorthand Syntax:<br/>[{access-binding={role-id=str, subject={id=str, type=str}}, action=ADD\|REMOVE},...]<br/>Fields:<br/>access-binding  struct            required  — Access binding. For more information, see [Access Bindings](https://yandex.cloud/ru/docs/iam/concepts/access-control/#access-bindings).<br/>role-id  string  required  — ID of the [yandex.cloud.iam.v1.Role] that is assigned to the [subject].<br/>subject  struct  required  — Identity for which access binding is being created.<br/>It can represent an account with a unique ID or several accounts with a system identifier.<br/>id    string  required  — ID of the subject.<br/><br/>It can contain one of the following values:<br/>* 'allAuthenticatedUsers': A special public group that represents anyone<br/>who is authenticated. It can be used only if the [type] is 'system'.<br/>* 'allUsers': A special public group that represents anyone. No authentication is required.<br/>For example, you don't need to specify the IAM token in an API query.<br/>It can be used only if the [type] is 'system'.<br/>* 'group:organization:\<id\>:users': A special system group that represents all members of organization<br/>with given \<id\>. It can be used only if the [type] is 'system'.<br/>* 'group:federation:\<id\>:users': A special system group that represents all users of federation<br/>with given \<id\>. It can be used only if the [type] is 'system'.<br/>* '<cloud generated id>': An identifier that represents a user account.<br/>It can be used only if the [type] is 'userAccount', 'federatedUser' or 'serviceAccount'.<br/>type  string  required  — Type of the subject.<br/><br/>It can contain one of the following values:<br/>* 'userAccount': An account on Yandex or Yandex Connect, added to Yandex Cloud.<br/>* 'serviceAccount': A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount] resource.<br/>* 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory.<br/>* 'system': System group. This type represents several accounts with a common system identifier.<br/><br/>For more information, see [Subject to which the role is assigned](https://yandex.cloud/ru/docs/iam/concepts/access-control/#subject).<br/>action          enum<ADD\|REMOVE>  required  — The action that is being performed on an access binding.<br/>|
|`--resource-id`|<b>`string`</b><br/>ID of the resource for which access bindings are being updated.|
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
