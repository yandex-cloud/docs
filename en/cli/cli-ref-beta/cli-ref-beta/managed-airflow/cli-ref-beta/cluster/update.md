---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-airflow/cli-ref-beta/cluster/update.md
---

# yc beta managed-airflow cluster update

Updates the specified Apache Airflow cluster.

#### Command Usage

Syntax: 

`yc beta managed-airflow cluster update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the Apache Airflow Cluster resource to update.|
|`--code-sync`|<b>`shorthand/json`</b><br/>Parameters of the location and access to the code that will be executed in the cluster.<br/><br/>Example:|
|`--code-sync`|<b>`source={git-sync={branch=value,`</b><br/>repo=value, ssh-key=value, sub-path=value}}<br/><br/>Shorthand Syntax:<br/>{source={git-sync={branch=str, repo=str, ssh-key=str, sub-path=str} \| s3={bucket=str}}}<br/>Fields:<br/>source  oneof<git-sync\|s3>  — Oneof source field<br/>s3        struct  —<br/>bucket  string  — The name of the Object Storage bucket that stores DAG files used in the cluster.<br/>git-sync  struct  —<br/>branch    string  required  — Git branch name to sync from.<br/>repo      string  required  — Git repository URL.<br/>ssh-key   string            — SSH private key for repository authentication.<br/>sub-path  string            — Subdirectory path within the repository containing DAG files.<br/>|
|`--config-spec`|<b>`shorthand/json`</b><br/>Configuration of Apache Airflow components.<br/><br/>Example:|
|`--config-spec`|<b>`airflow={config={key=value}},`</b><br/>airflow-version=value, dag-processor={count=1, resources={resource-preset-id=value}}, dependencies={deb-packages=value, pip-packages=value}, lockbox={enabled=true}, python-version=value, scheduler={count=1, resources={resource-preset-id=value}}, triggerer={count=1, resources={resource-preset-id=value}}, webserver={count=1, resources={resource-preset-id=value}}, worker={max-count=1, min-count=1, resources={resource-preset-id=value}}<br/><br/>Shorthand Syntax:<br/>{airflow={config={key=str, key=...}}, airflow-version=str, dag-processor={count=int, resources={resource-preset-id=str}}, dependencies={deb-packages=str,..., pip-packages=str,...}, lockbox={enabled=bool}, python-version=str, scheduler={count=int, resources={resource-preset-id=str}}, triggerer={count=int, resources={resource-preset-id=str}}, webserver={count=int, resources={resource-preset-id=str}}, worker={max-count=int, min-count=int, resources={resource-preset-id=str}}}<br/>Fields:<br/>airflow          struct  — Configuration of the Apache Airflow application itself.<br/>config  map[string,string]  — Properties to be passed to Apache Airflow configuration file.<br/>airflow-version  string  — Apache Airflow version. Format: "Major.Minor"<br/>dag-processor    struct  — Configuration of dag-processor instances.<br/>count      int     — The number of dag-processor instances in the cluster.<br/>resources  struct  — Resources allocated to dag-processor instances.<br/>resource-preset-id  string  — ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>dependencies     struct  — The list of additional packages installed in the cluster.<br/>deb-packages  []string  — System packages that are installed in the cluster.<br/>pip-packages  []string  — Python packages that are installed in the cluster.<br/>lockbox          struct  — Configuration of Lockbox Secret Backend.<br/>enabled  bool  — The setting allows to enable Lockbox Secret Backend.<br/>python-version   string  — Python version. Format: "Major.Minor"<br/>scheduler        struct  — Configuration of scheduler instances.<br/>count      int     — The number of scheduler instances in the cluster.<br/>resources  struct  — Resources allocated to scheduler instances.<br/>resource-preset-id  string  — ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>triggerer        struct  — Configuration of triggerer instances.<br/>count      int     — The number of triggerer instances in the cluster.<br/>resources  struct  — Resources allocated to triggerer instances.<br/>resource-preset-id  string  — ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>webserver        struct  — Configuration of webserver instances.<br/>count      int     — The number of webserver instances in the cluster.<br/>resources  struct  — Resources allocated to webserver instances.<br/>resource-preset-id  string  — ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>worker           struct  — Configuration of worker instances.<br/>max-count  int     — The maximum number of worker instances in the cluster.<br/>min-count  int     — The minimum number of worker instances in the cluster.<br/>resources  struct  — Resources allocated to worker instances.<br/>resource-preset-id  string  — ID of the preset for computational resources available to an instance (CPU, memory etc.).<br/>|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster|
|`--description`|<b>`string`</b><br/>New description of the Apache Airflow cluster.|
|`--labels`|<b>`stringToString`</b><br/>Custom labels for the Apache Airflow cluster as '' key:value '' pairs. For example, "env": "prod".<br/><br/>The new set of labels will completely replace the old ones. To add a label, request the current<br/>set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set.|
|`--logging`|<b>`shorthand/json`</b><br/>Cloud Logging configuration.<br/><br/>Example:|
|`--logging`|<b>`destination={folder-id=value},`</b><br/>enabled=true, min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, enabled=bool, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>enabled      bool                                     — Logs generated by the Airflow components are delivered to Cloud Logging.<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum log entry level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>folder-id     string  — Logs should be written to default log group for specified folder.<br/>log-group-id  string  — Logs should be written to log group resolved by ID.<br/>|
|`--maintenance-window`|<b>`shorthand/json`</b><br/>Window of maintenance operations.<br/><br/>Example:<br/>--maintenance-window policy={anytime={}}<br/><br/>Shorthand Syntax:<br/>{policy={anytime={} \| weekly-maintenance-window={day=MON\|TUE\|WED\|THU\|FRI\|SAT\|SUN, hour=int}}}<br/>Fields:<br/>policy  oneof<anytime\|weekly-maintenance-window>  — Oneof policy field<br/>anytime                    struct  —<br/>weekly-maintenance-window  struct  —<br/>day   enum<FRI\|MON\|SAT\|SUN\|THU\|TUE\|WED>  —<br/>hour  int                                — Hour of the day in UTC.<br/>|
|`--name`|<b>`string`</b><br/>New name of the cluster.|
|`--network-spec`|<b>`shorthand/json`</b><br/>Network related configuration options.<br/><br/>Example:<br/>--network-spec security-group-ids=value<br/><br/>Shorthand Syntax:<br/>{security-group-ids=str,...}<br/>Fields:<br/>security-group-ids  []string  — User security groups.<br/>|
|`--service-account-id`|<b>`string`</b><br/>Service account used to access Cloud resources.<br/>For more information, see [documentation](https://yandex.cloud/ru/docs/managed-airflow/concepts/impersonation).|
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
