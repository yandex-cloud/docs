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
|`--boot-disk-spec`|<b>`shorthand/json`</b><br/>Boot disk specification of the desktop group.<br/><br/>Example:|
|`--boot-disk-spec`|<b>`size=1,`</b><br/>type=HDD<br/><br/>Shorthand Syntax:<br/>{size=int, type=HDD\|SSD}<br/>Fields:<br/>size  int                      — Size of disk.<br/>type  enum<HDD\|SSD>  required  — Type of disk.<br/>|
|`--data-disk-spec`|<b>`shorthand/json`</b><br/>Data disk specification of the desktop group.<br/><br/>Example:|
|`--data-disk-spec`|<b>`size=1,`</b><br/>type=HDD<br/><br/>Shorthand Syntax:<br/>{size=int, type=HDD\|SSD}<br/>Fields:<br/>size  int                      — Size of disk.<br/>type  enum<HDD\|SSD>  required  — Type of disk.<br/>|
|`--description`|<b>`string`</b><br/>|
|`--desktop-group-id`|<b>`string`</b><br/>|
|`--desktop-image-id`|<b>`string`</b><br/>|
|`--group-config`|<b>`shorthand/json`</b><br/>Configuration of the desktop group.<br/><br/>Example:|
|`--group-config`|<b>`desktop-type=PERSISTENT,`</b><br/>max-desktops-amount=1, members=[{id=value, type=value}], min-ready-desktops=1<br/><br/>Shorthand Syntax:<br/>{desktop-type=PERSISTENT\|NON_PERSISTENT, max-desktops-amount=int, members=[{id=str, type=str},...], min-ready-desktops=int}<br/>Fields:<br/>desktop-type         enum<NON_PERSISTENT\|PERSISTENT>  — Type of the desktop.<br/>max-desktops-amount  int                              — Maximum number of desktops.<br/>members              []struct                         — List of members of the desktop group.<br/>id    string  required  — ID of the subject.<br/><br/>It can contain one of the following values:<br/>* 'allAuthenticatedUsers': A special public group that represents anyone<br/>who is authenticated. It can be used only if the [type] is 'system'.<br/>* 'allUsers': A special public group that represents anyone. No authentication is required.<br/>For example, you don't need to specify the IAM token in an API query.<br/>It can be used only if the [type] is 'system'.<br/>* 'group:organization:\<id\>:users': A special system group that represents all members of organization<br/>with given \<id\>. It can be used only if the [type] is 'system'.<br/>* 'group:federation:\<id\>:users': A special system group that represents all users of federation<br/>with given \<id\>. It can be used only if the [type] is 'system'.<br/>* '<cloud generated id>': An identifier that represents a user account.<br/>It can be used only if the [type] is 'userAccount', 'federatedUser' or 'serviceAccount'.<br/>type  string  required  — Type of the subject.<br/><br/>It can contain one of the following values:<br/>* 'userAccount': An account on Yandex or Yandex Connect, added to Yandex Cloud.<br/>* 'serviceAccount': A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount] resource.<br/>* 'federatedUser': A federated account. This type represents a user from an identity federation, like Active Directory.<br/>* 'system': System group. This type represents several accounts with a common system identifier.<br/><br/>For more information, see [Subject to which the role is assigned](https://yandex.cloud/ru/docs/iam/concepts/access-control/#subject).<br/>min-ready-desktops   int                              — Minimum number of ready desktops.<br/>|
|`--labels`|<b>`stringToString`</b><br/>|
|`--name`|<b>`string`</b><br/>|
|`--resources-spec`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--resources-spec`|<b>`core-fraction=1,`</b><br/>cores=1, memory=1<br/><br/>Shorthand Syntax:<br/>{core-fraction=int, cores=int, memory=int}<br/>Fields:<br/>core-fraction  int  — Baseline level of CPU performance with the ability to burst performance above that baseline level.<br/>This field sets baseline performance for each core.<br/>cores          int  — Number of CPU cores.<br/>memory         int  — RAM volume, in bytes.<br/>|
|`--auto-update-policy`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--auto-update-policy<br/><br/>Shorthand Syntax:<br/>{}|
|`--manual-update-policy`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--manual-update-policy<br/><br/>Shorthand Syntax:<br/>{}|
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
