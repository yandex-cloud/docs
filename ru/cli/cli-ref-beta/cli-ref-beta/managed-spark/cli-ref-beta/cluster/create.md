---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-spark/cli-ref-beta/cluster/create.md
---

# yc beta managed-spark cluster create

Creates a Spark cluster.

#### Command Usage

Syntax: 

`yc beta managed-spark cluster create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--config`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>dependencies = {<br/>deb-packages = str,...,<br/>pip-packages = str,...<br/>},<br/>history-server = {<br/>enabled = bool<br/>},<br/>metastore = {<br/>cluster-id = str<br/>},<br/>resource-pools = {<br/>driver = {<br/>resource-preset-id = str,<br/>scale-policy = {<br/>scale-type = auto-scale={<br/>max-size = int,<br/>min-size = int<br/>} \| fixed-scale={<br/>size = int<br/>}<br/>}<br/>},<br/>executor = {<br/>resource-preset-id = str,<br/>scale-policy = {<br/>scale-type = auto-scale={<br/>max-size = int,<br/>min-size = int<br/>} \| fixed-scale={<br/>size = int<br/>}<br/>}<br/>}<br/>},<br/>spark-version = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"dependencies": {<br/>"deb-packages": [<br/>"str", ...<br/>],<br/>"pip-packages": [<br/>"str", ...<br/>]<br/>},<br/>"history-server": {<br/>"enabled": "bool"<br/>},<br/>"metastore": {<br/>"cluster-id": "str"<br/>},<br/>"resource-pools": {<br/>"driver": {<br/>"resource-preset-id": "str",<br/>"scale-policy": {<br/>"scale-type": {<br/>"auto-scale": {<br/>"max-size": "int",<br/>"min-size": "int"<br/>},<br/>"fixed-scale": {<br/>"size": "int"<br/>}<br/>}<br/>}<br/>},<br/>"executor": {<br/>"resource-preset-id": "str",<br/>"scale-policy": {<br/>"scale-type": {<br/>"auto-scale": {<br/>"max-size": "int",<br/>"min-size": "int"<br/>},<br/>"fixed-scale": {<br/>"size": "int"<br/>}<br/>}<br/>}<br/>}<br/>},<br/>"spark-version": "str"<br/>}"<br/>Fields:<br/>dependencies -> (struct)<br/>Container custom environment dependencies<br/>deb-packages -> ([]string)<br/>pip-packages -> ([]string)<br/>history-server -> (struct)<br/>Configuration for HistoryServer<br/>enabled -> (bool)<br/>metastore -> (struct)<br/>Metastore Cluster<br/>cluster-id -> (string)<br/>resource-pools -> (struct)<br/>driver -> (struct)<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).<br/>scale-policy -> (struct)<br/>scale-type -> (oneof<auto-scale\|fixed-scale>)<br/>Oneof scale-type field<br/>fixed-scale -> (struct)<br/>size -> (int)<br/>auto-scale -> (struct)<br/>max-size -> (int)<br/>min-size -> (int)<br/>executor -> (struct)<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).<br/>scale-policy -> (struct)<br/>scale-type -> (oneof<auto-scale\|fixed-scale>)<br/>Oneof scale-type field<br/>fixed-scale -> (struct)<br/>size -> (int)<br/>auto-scale -> (struct)<br/>max-size -> (int)<br/>min-size -> (int)<br/>spark-version -> (string)<br/>Spark version. Format: "Major.Minor"|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster|
|`--description`|<b>`string`</b><br/>Description of the Spark cluster. 0-256 characters long.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create Spark cluster in.|
|`--labels`|<b>`stringToString`</b><br/>|
|`--logging`|<b>`shorthand/json`</b><br/>Cloud logging configuration<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>enabled = bool<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"enabled": "bool"<br/>}"<br/>Fields:<br/>enabled -> (bool)<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>folder-id -> (string)<br/>log-group-id -> (string)|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>Window of maintenance operations.<br/>Shorthand Syntax:<br/>{<br/>policy = anytime={} \| weekly-maintenance-window={<br/>day = MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN,<br/>hour = int<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"policy": {<br/>"anytime": {},<br/>"weekly-maintenance-window": {<br/>"day": "MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN",<br/>"hour": "int"<br/>}<br/>}<br/>}"<br/>Fields:<br/>policy -> (oneof<anytime\|weekly-maintenance-window>)<br/>Oneof policy field<br/>anytime -> (struct)<br/>weekly-maintenance-window -> (struct)<br/>day -> (enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>)<br/>hour -> (int)<br/>Hour of the day in UTC.|
|`--name`|<b>`string`</b><br/>Name of the Spark cluster. The name must be unique within the folder.|
|`--network`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>security-group-ids = str,...,<br/>subnet-ids = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"security-group-ids": [<br/>"str", ...<br/>],<br/>"subnet-ids": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>security-group-ids -> ([]string)<br/>User security groups<br/>subnet-ids -> ([]string)<br/>IDs of VPC network subnets where instances of the cluster are attached.|
|`--service-account-id`|<b>`string`</b><br/>Service account that will be used to access YC resources|
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
