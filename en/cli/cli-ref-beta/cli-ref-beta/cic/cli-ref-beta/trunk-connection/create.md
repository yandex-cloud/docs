---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/trunk-connection/create.md
---

# yc beta cic trunk-connection create

Creates a TrunkConnection resource in the specified folder using the data specified in the request.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cic trunk-connection create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--capacity`|<b>`enum`</b><br/>Capacity of the trunkConnection Possible Values: 'capacity-50-mbps', 'capacity-100-mbps', 'capacity-200-mbps', 'capacity-300-mbps', 'capacity-400-mbps', 'capacity-500-mbps', 'capacity-1-gbps', 'capacity-2-gbps', 'capacity-3-gbps', 'capacity-4-gbps', 'capacity-5-gbps', 'capacity-10-gbps', 'capacity-20-gbps', 'capacity-30-gbps', 'capacity-40-gbps', 'capacity-50-gbps', 'capacity-100-gbps', 'capacity-200-gbps'|
|`--deletion-protection`|Deletion protection flag.<br/>Optional.<br/>If set prohibits deletion of the trunkConnection.|
|`--description`|<b>`string`</b><br/>Optional description of the trunkConnection. 0-256 characters long.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder that the trunkConnection belongs to.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels, 'key:value' pairs.<br/>No more than 64 per resource.<br/>The maximum string length in characters for each value is 63.<br/>Each value must match the regular expression '[-_0-9a-z]*'.<br/>The string length in characters for each key must be 1-63.<br/>Each key must match the regular expression '[a-z][-_0-9a-z]*'.|
|`--name`|<b>`string`</b><br/>Name of the trunkConnection.<br/>The name must be unique within the folder.<br/>Value must match the regular expression ''\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?''.|
|`--point-of-presence-id`|<b>`string`</b><br/>ID of pointOfPresence that the trunkConnection is deployed on.<br/>Optional.<br/>If is not set scheduler selects it by himself.|
|`--region-id`|<b>`string`</b><br/>ID of the region that the trunkConnection belongs to.|
|`--single-port-direct-joint`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--single-port-direct-joint transceiver-type=TRANSCEIVER_TYPE_1000BASE_LX<br/><br/>Shorthand Syntax:<br/>{transceiver-type=TRANSCEIVER_TYPE_1000BASE_LX\|TRANSCEIVER_TYPE_10GBASE_LR\|TRANSCEIVER_TYPE_10GBASE_ER\|TRANSCEIVER_TYPE_100GBASE_LR4\|TRANSCEIVER_TYPE_100GBASE_ER4}<br/>Fields:<br/>transceiver-type  enum<TRANSCEIVER_TYPE_1000BASE_LX\|TRANSCEIVER_TYPE_100GBASE_ER4\|TRANSCEIVER_TYPE_100GBASE_LR4\|TRANSCEIVER_TYPE_10GBASE_ER\|TRANSCEIVER_TYPE_10GBASE_LR>  — Type of transceiver that the trunkConnection is deployed on.<br/>|
|`--lag-direct-joint`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--lag-direct-joint`|<b>`lag-allocation-settings={lag={lag-size=1}},`</b><br/>transceiver-type=TRANSCEIVER_TYPE_1000BASE_LX<br/><br/>Shorthand Syntax:<br/>{lag-allocation-settings={lag={lag-size=int}}, transceiver-type=TRANSCEIVER_TYPE_1000BASE_LX\|TRANSCEIVER_TYPE_10GBASE_LR\|TRANSCEIVER_TYPE_10GBASE_ER\|TRANSCEIVER_TYPE_100GBASE_LR4\|TRANSCEIVER_TYPE_100GBASE_ER4}<br/>Fields:<br/>lag-allocation-settings  struct                                                                                                                                                  — LAG allocation settings that the trunkConnection is deployed on.<br/>lag  oneof\<lag-size\>  — Oneof lag field<br/>lag-size  int  — Size of LAG.<br/>Must be from 1 to 10 inclusively.<br/>transceiver-type         enum<TRANSCEIVER_TYPE_1000BASE_LX\|TRANSCEIVER_TYPE_100GBASE_ER4\|TRANSCEIVER_TYPE_100GBASE_LR4\|TRANSCEIVER_TYPE_10GBASE_ER\|TRANSCEIVER_TYPE_10GBASE_LR>  — Type of transceiver that the trunkConnection is deployed on.<br/>|
|`--partner-joint-info`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--partner-joint-info partner-id=example<br/><br/>Shorthand Syntax:<br/>{partner-id=str}<br/>Fields:<br/>partner-id  str  — ID of partner that the trunkConnection is deployed on.<br/>Optional.<br/>If is not set scheduler selects it by himself.<br/>|
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
