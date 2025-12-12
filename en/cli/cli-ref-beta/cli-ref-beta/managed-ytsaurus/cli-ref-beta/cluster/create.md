---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-ytsaurus/cli-ref-beta/cluster/create.md
---

# yc beta managed-ytsaurus cluster create

Creates a cluster in the specified folder.

#### Command Usage

Syntax: 

`yc beta managed-ytsaurus cluster create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cidr-blocks-whitelist`|<b>`shorthand/json`</b><br/>CIDRs whitelist.<br/>Shorthand Syntax:<br/>{<br/>v4-cidr-blocks = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"v4-cidr-blocks": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>v4-cidr-blocks -> ([]string)<br/>IPv4 CIDR blocks.|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the cluster in.|
|`--labels`|<b>`stringToString`</b><br/>Cluster labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the cluster.|
|`--security-group-ids`|<b>`strings`</b><br/>IDs of the security groups to attach to the cluster.|
|`--spec`|<b>`shorthand/json`</b><br/>Cluster specification.<br/>Shorthand Syntax:<br/>{<br/>client-logging = {<br/>audit-logs-enabled = bool,<br/>destination = folder-id=str \| log-group-id=str,<br/>service-account-id = str<br/>},<br/>compute = [<br/>{<br/>disks = [<br/>{<br/>locations = str,...,<br/>size-gb = int,<br/>type = str<br/>}, ...<br/>],<br/>name = str,<br/>preset = str,<br/>scale-policy = {<br/>policy = auto={<br/>max-size = int,<br/>min-size = int<br/>} \| fixed={<br/>size = int<br/>}<br/>}<br/>}, ...<br/>],<br/>cron = {<br/>clear-tmp = {<br/>account-usage-ratio-save-per-owner = double,<br/>account-usage-ratio-save-total = double,<br/>interval = duration,<br/>max-dir-node-count = int<br/>}<br/>},<br/>flavor = DEMO,<br/>odin = {<br/>checks-ttl = duration<br/>},<br/>proxy = {<br/>http = {<br/>count = int<br/>},<br/>rpc = {<br/>count = int<br/>}<br/>},<br/>storage = {<br/>hdd = {<br/>count = int,<br/>size-gb = int<br/>},<br/>ssd = {<br/>count = int,<br/>size-gb = int,<br/>type = str<br/>}<br/>},<br/>tablet = {<br/>count = int,<br/>preset = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"client-logging": {<br/>"audit-logs-enabled": "bool",<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"service-account-id": "str"<br/>},<br/>"compute": [<br/>{<br/>"disks": [<br/>{<br/>"locations": [<br/>"str", ...<br/>],<br/>"size-gb": "int",<br/>"type": "str"<br/>}, ...<br/>],<br/>"name": "str",<br/>"preset": "str",<br/>"scale-policy": {<br/>"policy": {<br/>"auto": {<br/>"max-size": "int",<br/>"min-size": "int"<br/>},<br/>"fixed": {<br/>"size": "int"<br/>}<br/>}<br/>}<br/>}, ...<br/>],<br/>"cron": {<br/>"clear-tmp": {<br/>"account-usage-ratio-save-per-owner": "double",<br/>"account-usage-ratio-save-total": "double",<br/>"interval": "duration",<br/>"max-dir-node-count": "int"<br/>}<br/>},<br/>"flavor": "DEMO",<br/>"odin": {<br/>"checks-ttl": "duration"<br/>},<br/>"proxy": {<br/>"http": {<br/>"count": "int"<br/>},<br/>"rpc": {<br/>"count": "int"<br/>}<br/>},<br/>"storage": {<br/>"hdd": {<br/>"count": "int",<br/>"size-gb": "int"<br/>},<br/>"ssd": {<br/>"count": "int",<br/>"size-gb": "int",<br/>"type": "str"<br/>}<br/>},<br/>"tablet": {<br/>"count": "int",<br/>"preset": "str"<br/>}<br/>}"<br/>Fields:<br/>client-logging -> (struct)<br/>Client Cloud logging configuration.<br/>audit-logs-enabled -> (bool)<br/>Enable audit logs.<br/>service-account-id -> (string)<br/>ID of Service account used for write logs.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>ID of cloud logging group.<br/>folder-id -> (string)<br/>ID of cloud logging folder. Used default loging group.<br/>compute -> ([]struct)<br/>disks -> ([]struct)<br/>locations -> ([]string)<br/>size-gb -> (int)<br/>type -> (string)<br/>name -> (string)<br/>Name for exec pool.<br/>preset -> (string)<br/>scale-policy -> (struct)<br/>policy -> (oneof<auto\|fixed>)<br/>Oneof policy field<br/>fixed -> (struct)<br/>size -> (int)<br/>auto -> (struct)<br/>max-size -> (int)<br/>min-size -> (int)<br/>cron -> (struct)<br/>Cluster regular processing settings.<br/>clear-tmp -> (struct)<br/>Cluster regular tmp-account cleaning settings.<br/>account-usage-ratio-save-per-owner -> (double)<br/>Per account max space usage ratio.<br/>account-usage-ratio-save-total -> (double)<br/>Total max space usage ratio.<br/>interval -> (duration)<br/>Script starting interval.<br/>max-dir-node-count -> (int)<br/>Max nodes in every directory.<br/>flavor -> (enum\<DEMO\>)<br/>odin -> (struct)<br/>checks-ttl -> (duration)<br/>proxy -> (struct)<br/>http -> (struct)<br/>count -> (int)<br/>rpc -> (struct)<br/>count -> (int)<br/>storage -> (struct)<br/>hdd -> (struct)<br/>count -> (int)<br/>size-gb -> (int)<br/>ssd -> (struct)<br/>count -> (int)<br/>size-gb -> (int)<br/>type -> (string)<br/>tablet -> (struct)<br/>count -> (int)<br/>preset -> (string)|
|`--subnet-id`|<b>`string`</b><br/>ID of the subnet to create the cluster in.|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the cluster resides.|
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
