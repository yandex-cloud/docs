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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cidr-blocks-whitelist`|<b>`shorthand/json`</b><br/>CIDRs whitelist.<br/><br/>Example:<br/>--cidr-blocks-whitelist v4-cidr-blocks=value<br/><br/>Shorthand Syntax:<br/>{v4-cidr-blocks=str,...}<br/>Fields:<br/>v4-cidr-blocks  []string  — IPv4 CIDR blocks.<br/>|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the cluster in.|
|`--labels`|<b>`stringToString`</b><br/>Cluster labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the cluster.|
|`--security-group-ids`|<b>`strings`</b><br/>IDs of the security groups to attach to the cluster.|
|`--spec`|<b>`shorthand/json`</b><br/>Cluster specification.<br/><br/>Example:|
|`--spec`|<b>`client-logging={audit-logs-enabled=true,`</b><br/>destination={folder-id=value}, service-account-id=value}, compute=[{disks=[{locations=value, size-gb=1, type=value}], name=value, preset=value, scale-policy={policy={auto={max-size=1, min-size=1}}}}], cron={clear-tmp={account-usage-ratio-save-per-owner=1.0, account-usage-ratio-save-total=1.0, interval=1h30m, max-dir-node-count=1}}, flavor=DEMO, odin={checks-ttl=1h30m}, proxy={http={count=1}, rpc={count=1}}, storage={hdd={count=1, size-gb=1}, ssd={count=1, size-gb=1, type=value}}, tablet={count=1, preset=value}<br/><br/>Shorthand Syntax:<br/>{client-logging={audit-logs-enabled=bool, destination={folder-id=str \| log-group-id=str}, service-account-id=str}, compute=[{disks=[{locations=str,..., size-gb=int, type=str},...], name=str, preset=str, scale-policy={policy={auto={max-size=int, min-size=int} \| fixed={size=int}}}},...], cron={clear-tmp={account-usage-ratio-save-per-owner=double, account-usage-ratio-save-total=double, interval=duration, max-dir-node-count=int}}, flavor=DEMO, odin={checks-ttl=duration}, proxy={http={count=int}, rpc={count=int}}, storage={hdd={count=int, size-gb=int}, ssd={count=int, size-gb=int, type=str}}, tablet={count=int, preset=str}}<br/>Fields:<br/>client-logging  struct      — Client Cloud logging configuration.<br/>audit-logs-enabled  bool                           — Enable audit logs.<br/>service-account-id  string                         — ID of Service account used for write logs.<br/>destination         oneof<folder-id\|log-group-id>  — Oneof destination field<br/>log-group-id  string  — ID of cloud logging group.<br/>folder-id     string  — ID of cloud logging folder. Used default loging group.<br/>compute         []struct    —<br/>disks         []struct  —<br/>locations  []string  —<br/>size-gb    int       —<br/>type       string    —<br/>name          string    — Name for exec pool.<br/>preset        string    —<br/>scale-policy  struct    —<br/>policy  oneof<auto\|fixed>  — Oneof policy field<br/>fixed  struct  —<br/>size  int  —<br/>auto   struct  —<br/>max-size  int  —<br/>min-size  int  —<br/>cron            struct      — Cluster regular processing settings.<br/>clear-tmp  struct  — Cluster regular tmp-account cleaning settings.<br/>account-usage-ratio-save-per-owner  double    — Per account max space usage ratio.<br/>account-usage-ratio-save-total      double    — Total max space usage ratio.<br/>interval                            duration  — Script starting interval.<br/>max-dir-node-count                  int       — Max nodes in every directory.<br/>flavor          enum\<DEMO\>  —<br/>odin            struct      —<br/>checks-ttl  duration  —<br/>proxy           struct      —<br/>http  struct  —<br/>count  int  —<br/>rpc   struct  —<br/>count  int  —<br/>storage         struct      —<br/>hdd  struct  —<br/>count    int  —<br/>size-gb  int  —<br/>ssd  struct  —<br/>count    int     —<br/>size-gb  int     —<br/>type     string  —<br/>tablet          struct      —<br/>count   int     —<br/>preset  string  —<br/>|
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
