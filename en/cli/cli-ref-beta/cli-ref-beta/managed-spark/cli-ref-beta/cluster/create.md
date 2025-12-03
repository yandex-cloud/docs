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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--config`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--config`|<b>`dependencies={deb-packages=value,`</b><br/>pip-packages=value}, history-server={enabled=true}, metastore={cluster-id=value}, resource-pools={driver={resource-preset-id=value, scale-policy={scale-type={auto-scale={max-size=1, min-size=1}}}}, executor={resource-preset-id=value, scale-policy={scale-type={auto-scale={max-size=1, min-size=1}}}}}, spark-version=value<br/><br/>Shorthand Syntax:<br/>{dependencies={deb-packages=str,..., pip-packages=str,...}, history-server={enabled=bool}, metastore={cluster-id=str}, resource-pools={driver={resource-preset-id=str, scale-policy={scale-type={auto-scale={max-size=int, min-size=int} \| fixed-scale={size=int}}}}, executor={resource-preset-id=str, scale-policy={scale-type={auto-scale={max-size=int, min-size=int} \| fixed-scale={size=int}}}}}, spark-version=str}<br/>Fields:<br/>dependencies    struct            — Container custom environment dependencies<br/>deb-packages  []string  —<br/>pip-packages  []string  —<br/>history-server  struct            — Configuration for HistoryServer<br/>enabled  bool  —<br/>metastore       struct            — Metastore Cluster<br/>cluster-id  string  —<br/>resource-pools  struct  required  —<br/>driver    struct  required  —<br/>resource-preset-id  string  required  — ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).<br/>scale-policy        struct  required  —<br/>scale-type  oneof<auto-scale\|fixed-scale>  — Oneof scale-type field<br/>fixed-scale  struct  —<br/>size  int  —<br/>auto-scale   struct  —<br/>max-size  int  —<br/>min-size  int  —<br/>executor  struct  required  —<br/>resource-preset-id  string  required  — ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).<br/>scale-policy        struct  required  —<br/>scale-type  oneof<auto-scale\|fixed-scale>  — Oneof scale-type field<br/>fixed-scale  struct  —<br/>size  int  —<br/>auto-scale   struct  —<br/>max-size  int  —<br/>min-size  int  —<br/>spark-version   string            — Spark version. Format: "Major.Minor"<br/>|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster|
|`--description`|<b>`string`</b><br/>Description of the Spark cluster. 0-256 characters long.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create Spark cluster in.|
|`--labels`|<b>`stringToString`</b><br/>|
|`--logging`|<b>`shorthand/json`</b><br/>Cloud logging configuration<br/><br/>Example:|
|`--logging`|<b>`destination={folder-id=value},`</b><br/>enabled=true<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, enabled=bool}<br/>Fields:<br/>enabled      bool                           —<br/>destination  oneof<folder-id\|log-group-id>  — Oneof destination field<br/>folder-id     string  —<br/>log-group-id  string  —<br/>|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>Window of maintenance operations.<br/><br/>Example:<br/>--maintenance-window policy={anytime={}}<br/><br/>Shorthand Syntax:<br/>{policy={anytime={} \| weekly-maintenance-window={day=MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN, hour=int}}}<br/>Fields:<br/>policy  oneof<anytime\|weekly-maintenance-window>  — Oneof policy field<br/>anytime                    struct  —<br/>weekly-maintenance-window  struct  —<br/>day   enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>  —<br/>hour  int                                — Hour of the day in UTC.<br/>|
|`--name`|<b>`string`</b><br/>Name of the Spark cluster. The name must be unique within the folder.|
|`--network`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--network`|<b>`security-group-ids=value,`</b><br/>subnet-ids=value<br/><br/>Shorthand Syntax:<br/>{security-group-ids=str,..., subnet-ids=str,...}<br/>Fields:<br/>security-group-ids  []string  — User security groups<br/>subnet-ids          []string  — IDs of VPC network subnets where instances of the cluster are attached.<br/>|
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
