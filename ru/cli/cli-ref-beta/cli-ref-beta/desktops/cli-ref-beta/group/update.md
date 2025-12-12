---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/desktops/cli-ref-beta/group/update.md
---

# yc beta desktops group update

Updates desktop group properties

#### Command Usage

Syntax: 

`yc beta desktops group update <DESKTOP-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--boot-disk-spec`|<b>`shorthand/json`</b><br/>Boot disk specification of the desktop group.<br/>Shorthand Syntax:<br/>{<br/>size = int,<br/>type = HDD\|SSD<br/>}<br/>JSON Syntax:<br/>"{<br/>"size": "int",<br/>"type": "HDD\|SSD"<br/>}"<br/>Fields:<br/>size -> (int)<br/>Size of disk.<br/>type -> (enum<HDD\|SSD>)<br/>Type of disk.|
|`--data-disk-spec`|<b>`shorthand/json`</b><br/>Data disk specification of the desktop group.<br/>Shorthand Syntax:<br/>{<br/>size = int,<br/>type = HDD\|SSD<br/>}<br/>JSON Syntax:<br/>"{<br/>"size": "int",<br/>"type": "HDD\|SSD"<br/>}"<br/>Fields:<br/>size -> (int)<br/>Size of disk.<br/>type -> (enum<HDD\|SSD>)<br/>Type of disk.|
|`--description`|<b>`string`</b><br/>|
|`--desktop-group-id`|<b>`string`</b><br/>|
|`--desktop-image-id`|<b>`string`</b><br/>|
|`--group-config`|<b>`shorthand/json`</b><br/>Configuration of the desktop group.<br/>Shorthand Syntax:<br/>{<br/>desktop-type = PERSISTENT\|NON_PERSISTENT,<br/>max-desktops-amount = int,<br/>members = [<br/>{<br/>id = str,<br/>type = str<br/>}, ...<br/>],<br/>min-ready-desktops = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"desktop-type": "PERSISTENT\|NON_PERSISTENT",<br/>"max-desktops-amount": "int",<br/>"members": [<br/>{<br/>"id": "str",<br/>"type": "str"<br/>}, ...<br/>],<br/>"min-ready-desktops": "int"<br/>}"<br/>Fields:<br/>desktop-type -> (enum<NON_PERSISTENT\|PERSISTENT>)<br/>Type of the desktop.<br/>max-desktops-amount -> (int)<br/>Maximum number of desktops.<br/>members -> ([]struct)<br/>List of members of the desktop group.<br/>id -> (string)<br/>ID of the subject. It can contain one of the following values: * 'allAuthenticatedUsers': A special public group that represents anyone who is authenticated. It can be used only if the [type] is 'system'. * 'allUsers': A special public group that represents anyone. No authentication is required. For example, you don't need to specify the IAM token in an API query. It can be used only if the [type] is 'system'. * 'group:organization:\<id\>:users': A special system group that represents all members of organization with given \<id\>. It can be used only if the [type] is 'system'. * 'group:federation:\<id\>:users': A special system group that represents all users of federation with given \<id\>. It can be used only if the [type] is 'system'. * '<cloud generated id>': An identifier that represents a user account. It can be used only if the [type] is 'userAccount', 'federatedUser' or 'serviceAccount'.<br/>type -> (string)<br/>Type of the subject. It can contain one of the following values: * 'userAccount': An account on Yandex or Yandex Connect, added to Yandex Cloud. * 'serviceAccount': A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount] resource. * 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory. * 'system': System group. This type represents several accounts with a common system identifier. For more information, see documentation.<br/>min-ready-desktops -> (int)<br/>Minimum number of ready desktops.|
|`--labels`|<b>`stringToString`</b><br/>|
|`--name`|<b>`string`</b><br/>|
|`--resources-spec`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>core-fraction = int,<br/>cores = int,<br/>memory = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"core-fraction": "int",<br/>"cores": "int",<br/>"memory": "int"<br/>}"<br/>Fields:<br/>core-fraction -> (int)<br/>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.<br/>cores -> (int)<br/>Number of CPU cores.<br/>memory -> (int)<br/>RAM volume, in bytes.|
|`--auto-update-policy`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{}<br/>JSON Syntax:<br/>"{}"|
|`--manual-update-policy`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{}<br/>JSON Syntax:<br/>"{}"|
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
