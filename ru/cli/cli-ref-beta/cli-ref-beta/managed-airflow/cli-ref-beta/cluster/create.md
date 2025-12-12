---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-airflow/cli-ref-beta/cluster/create.md
---

# yc beta managed-airflow cluster create

Creates an Apache Airflow cluster.

#### Command Usage

Syntax: 

`yc beta managed-airflow cluster create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--admin-password`|<b>`string`</b><br/>Password of user 'admin'.|
|`--code-sync`|<b>`shorthand/json`</b><br/>Parameters of the location and access to the code that will be executed in the cluster.<br/>Shorthand Syntax:<br/>{<br/>source = git-sync={<br/>branch = str,<br/>repo = str,<br/>ssh-key = str,<br/>sub-path = str<br/>} \| s3={<br/>bucket = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"source": {<br/>"git-sync": {<br/>"branch": "str",<br/>"repo": "str",<br/>"ssh-key": "str",<br/>"sub-path": "str"<br/>},<br/>"s3": {<br/>"bucket": "str"<br/>}<br/>}<br/>}"<br/>Fields:<br/>source -> (oneof<git-sync\|s3>)<br/>Oneof source field<br/>s3 -> (struct)<br/>bucket -> (string)<br/>The name of the Object Storage bucket that stores DAG files used in the cluster.<br/>git-sync -> (struct)<br/>branch -> (string)<br/>Git branch name to sync from.<br/>repo -> (string)<br/>Git repository URL.<br/>ssh-key -> (string)<br/>SSH private key for repository authentication.<br/>sub-path -> (string)<br/>Subdirectory path within the repository containing DAG files.|
|`--config`|<b>`shorthand/json`</b><br/>Configuration of Apache Airflow components.<br/>Shorthand Syntax:<br/>{<br/>airflow = {<br/>config = {key=str, key=...}<br/>},<br/>airflow-version = str,<br/>dag-processor = {<br/>count = int,<br/>resources = {<br/>resource-preset-id = str<br/>}<br/>},<br/>dependencies = {<br/>deb-packages = str,...,<br/>pip-packages = str,...<br/>},<br/>lockbox = {<br/>enabled = bool<br/>},<br/>python-version = str,<br/>scheduler = {<br/>count = int,<br/>resources = {<br/>resource-preset-id = str<br/>}<br/>},<br/>triggerer = {<br/>count = int,<br/>resources = {<br/>resource-preset-id = str<br/>}<br/>},<br/>version-id = str,<br/>webserver = {<br/>count = int,<br/>resources = {<br/>resource-preset-id = str<br/>}<br/>},<br/>worker = {<br/>max-count = int,<br/>min-count = int,<br/>resources = {<br/>resource-preset-id = str<br/>}<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"airflow": {<br/>"config": {<br/>"\<key\>": "str", ...<br/>}<br/>},<br/>"airflow-version": "str",<br/>"dag-processor": {<br/>"count": "int",<br/>"resources": {<br/>"resource-preset-id": "str"<br/>}<br/>},<br/>"dependencies": {<br/>"deb-packages": [<br/>"str", ...<br/>],<br/>"pip-packages": [<br/>"str", ...<br/>]<br/>},<br/>"lockbox": {<br/>"enabled": "bool"<br/>},<br/>"python-version": "str",<br/>"scheduler": {<br/>"count": "int",<br/>"resources": {<br/>"resource-preset-id": "str"<br/>}<br/>},<br/>"triggerer": {<br/>"count": "int",<br/>"resources": {<br/>"resource-preset-id": "str"<br/>}<br/>},<br/>"version-id": "str",<br/>"webserver": {<br/>"count": "int",<br/>"resources": {<br/>"resource-preset-id": "str"<br/>}<br/>},<br/>"worker": {<br/>"max-count": "int",<br/>"min-count": "int",<br/>"resources": {<br/>"resource-preset-id": "str"<br/>}<br/>}<br/>}"<br/>Fields:<br/>airflow -> (struct)<br/>Configuration of the Apache Airflow application itself.<br/>config -> (map[string,string])<br/>Properties to be passed to Apache Airflow configuration file.<br/>airflow-version -> (string)<br/>Apache Airflow version. Format: "Major.Minor"<br/>dag-processor -> (struct)<br/>Configuration of dag-processor instances.<br/>count -> (int)<br/>The number of dag-processor instances in the cluster.<br/>resources -> (struct)<br/>Resources allocated to dag-processor instances.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>dependencies -> (struct)<br/>The list of additional packages installed in the cluster.<br/>deb-packages -> ([]string)<br/>System packages that are installed in the cluster.<br/>pip-packages -> ([]string)<br/>Python packages that are installed in the cluster.<br/>lockbox -> (struct)<br/>Configuration of Lockbox Secret Backend.<br/>enabled -> (bool)<br/>The setting allows to enable Lockbox Secret Backend.<br/>python-version -> (string)<br/>Python version. Format: "Major.Minor"<br/>scheduler -> (struct)<br/>Configuration of scheduler instances.<br/>count -> (int)<br/>The number of scheduler instances in the cluster.<br/>resources -> (struct)<br/>Resources allocated to scheduler instances.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>triggerer -> (struct)<br/>Configuration of triggerer instances.<br/>count -> (int)<br/>The number of triggerer instances in the cluster.<br/>resources -> (struct)<br/>Resources allocated to triggerer instances.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>version-id -> (string)<br/>Version of Apache Airflow that runs on the cluster. Use 'airflow_version' instead.<br/>webserver -> (struct)<br/>Configuration of webserver instances.<br/>count -> (int)<br/>The number of webserver instances in the cluster.<br/>resources -> (struct)<br/>Resources allocated to webserver instances.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>worker -> (struct)<br/>Configuration of worker instances.<br/>max-count -> (int)<br/>The maximum number of worker instances in the cluster.<br/>min-count -> (int)<br/>The minimum number of worker instances in the cluster.<br/>resources -> (struct)<br/>Resources allocated to worker instances.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources available to an instance (CPU, memory etc.).|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--description`|<b>`string`</b><br/>Description of the Apache Airflow cluster.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create Apache Airflow cluster in.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the Apache Airflow cluster as '' key:value '' pairs. For example, "env": "prod".|
|`--logging`|<b>`shorthand/json`</b><br/>Cloud Logging configuration.<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>enabled = bool,<br/>min-level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"enabled": "bool",<br/>"min-level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL"<br/>}"<br/>Fields:<br/>enabled -> (bool)<br/>Logs generated by the Airflow components are delivered to Cloud Logging.<br/>min-level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Minimum log entry level. See [LogLevel.Level] for details.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>folder-id -> (string)<br/>Logs should be written to default log group for specified folder.<br/>log-group-id -> (string)<br/>Logs should be written to log group resolved by ID.|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>Window of maintenance operations.<br/>Shorthand Syntax:<br/>{<br/>policy = anytime={} \| weekly-maintenance-window={<br/>day = MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN,<br/>hour = int<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"policy": {<br/>"anytime": {},<br/>"weekly-maintenance-window": {<br/>"day": "MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN",<br/>"hour": "int"<br/>}<br/>}<br/>}"<br/>Fields:<br/>policy -> (oneof<anytime\|weekly-maintenance-window>)<br/>Oneof policy field<br/>anytime -> (struct)<br/>weekly-maintenance-window -> (struct)<br/>day -> (enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>)<br/>hour -> (int)<br/>Hour of the day in UTC.|
|`--name`|<b>`string`</b><br/>Name of the Apache Airflow cluster. The name must be unique within the folder.|
|`--network`|<b>`shorthand/json`</b><br/>Network related configuration options.<br/>Shorthand Syntax:<br/>{<br/>security-group-ids = str,...,<br/>subnet-ids = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"security-group-ids": [<br/>"str", ...<br/>],<br/>"subnet-ids": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>security-group-ids -> ([]string)<br/>User security groups.<br/>subnet-ids -> ([]string)<br/>IDs of VPC network subnets where instances of the cluster are attached.|
|`--service-account-id`|<b>`string`</b><br/>Service account used to access Cloud resources. For more information, see documentation.|
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
