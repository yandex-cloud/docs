---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/eventrouter/rule/create.md
---

# yc beta serverless eventrouter rule create

Creates a rule in the specified folder.

#### Command Usage

Syntax: 

`yc beta serverless eventrouter rule create <BUS-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bus-id`|<b>`string`</b><br/>ID of the bus to create a rule for.|
|`--deletion-protection`|Flag that disallow deletion of the rule.|
|`--description`|<b>`string`</b><br/>Description of the rule.|
|`--filter`|<b>`shorthand/json`</b><br/>Filter for the rule.<br/><br/>Example:<br/>--filter condition={jq-filter=value}<br/><br/>Shorthand Syntax:<br/>{condition={jq-filter=str}}<br/>Fields:<br/>condition  oneof\<jq-filter\>  — Oneof condition field<br/>jq-filter  string  — JQ filter for matching events.<br/>|
|`--labels`|<b>`stringToString`</b><br/>Labels for the rule.|
|`--name`|<b>`string`</b><br/>Name of the rule.|
|`--targets`|<b>`shorthand/json`</b><br/>Targets for the rule.<br/><br/>Example:|
|`--targets`|<b>`[{dead-letter={dead-letter-queue={queue-arn=value,`</b><br/>service-account-id=value}}, retry-settings={maximum-age=1h30m, retry-attempts=1}, status=ENABLED, target={container={batch-settings={cutoff=1h30m, max-bytes=1, max-count=1}, container-id=value, container-revision-id=value, path=value, service-account-id=value}}, transformer={transformer={jq-transformer=value}}}]<br/><br/>Shorthand Syntax:<br/>[{dead-letter={dead-letter-queue={queue-arn=str, service-account-id=str}}, retry-settings={maximum-age=duration, retry-attempts=int}, status=ENABLED\|DISABLED\|RESOURCE_NOT_FOUND\|PERMISSION_DENIED\|SUBJECT_NOT_FOUND, target={container={batch-settings={cutoff=duration, max-bytes=int, max-count=int}, container-id=str, container-revision-id=str, path=str, service-account-id=str} \| function={batch-settings={cutoff=duration, max-bytes=int, max-count=int}, function-id=str, function-tag=str, service-account-id=str} \| gateway-ws-broadcast={batch-settings={cutoff=duration, max-bytes=int, max-count=int}, gateway-id=str, path=str, service-account-id=str} \| logging={destination={folder-id=str \| log-group-id=str}, service-account-id=str} \| workflow={batch-settings={cutoff=duration, max-bytes=int, max-count=int}, service-account-id=str, workflow-id=str} \| yds={database=str, service-account-id=str, stream-name=str} \| ymq={queue-arn=str, service-account-id=str}}, transformer={transformer={jq-transformer=str}}},...]<br/>Fields:<br/>retry-settings  struct                                                                         — Retry settings of the target.<br/>maximum-age     duration  — Event goes to dlq when its age exceeds this value. Default is 24h.<br/>retry-attempts  int       — Maximum number of retries (extra calls) before an action fails.<br/>status          enum<DISABLED\|ENABLED\|PERMISSION_DENIED\|RESOURCE_NOT_FOUND\|SUBJECT_NOT_FOUND>  — Status of the target.<br/>transformer     struct                                                                         — Transformer of the target.<br/>transformer  oneof\<jq-transformer\>  — Oneof transformer field<br/>jq-transformer  string  — JQ string inrerpolation expression for changing event format.<br/>dead-letter     oneof\<dead-letter-queue\>                                                       — Oneof dead-letter field<br/>dead-letter-queue  struct  — Dead letter queue.<br/>queue-arn           string            — ID of the queue.<br/>service-account-id  string  required  — Service account which has write permission on the queue.<br/>target          oneof<container\|function\|gateway-ws-broadcast\|logging\|workflow\|yds\|ymq>        — Oneof target field<br/>yds                   struct  —<br/>database            string  required  — Stream database.<br/>service-account-id  string  required  — Service account, which has write permission on the stream.<br/>stream-name         string  required  — Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test.<br/>ymq                   struct  —<br/>queue-arn           string  required  — Queue ARN.<br/>Example: yrn:yc:ymq:ru-central1:aoe***:test<br/>service-account-id  string  required  — Service account which has write access to the queue.<br/>function              struct  —<br/>batch-settings      struct            — Batch settings.<br/>cutoff     duration  required  — Maximum batch size: trigger will send a batch if its lifetime exceeds this value.<br/>max-bytes  int                 — Maximum batch size: trigger will send a batch if total size of events exceeds this value.<br/>max-count  int                 — Maximum batch size: trigger will send a batch if number of events exceeds this value.<br/>function-id         string  required  — Function ID.<br/>function-tag        string            — Function tag, optional.<br/>service-account-id  string            — Service account which has call permission on the function, optional.<br/>container             struct  —<br/>batch-settings         struct            — Batch settings.<br/>cutoff     duration  required  — Maximum batch size: trigger will send a batch if its lifetime exceeds this value.<br/>max-bytes  int                 — Maximum batch size: trigger will send a batch if total size of events exceeds this value.<br/>max-count  int                 — Maximum batch size: trigger will send a batch if number of events exceeds this value.<br/>container-id           string  required  — Container ID.<br/>container-revision-id  string            — Container revision ID.<br/>path                   string            — Endpoint HTTP path to invoke.<br/>service-account-id     string            — Service account which should be used to call a container, optional.<br/>gateway-ws-broadcast  struct  —<br/>batch-settings      struct            — Batch settings.<br/>cutoff     duration  required  — Maximum batch size: trigger will send a batch if its lifetime exceeds this value.<br/>max-bytes  int                 — Maximum batch size: trigger will send a batch if total size of events exceeds this value.<br/>max-count  int                 — Maximum batch size: trigger will send a batch if number of events exceeds this value.<br/>gateway-id          string  required  — Gateway ID.<br/>path                string  required  — Path.<br/>service-account-id  string  required  — Service account which has permission for writing to websockets.<br/>logging               struct  —<br/>service-account-id  string                         required  — Service account which has permission for writing logs.<br/>destination         oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  —<br/>folder-id     string  —<br/>workflow              struct  —<br/>batch-settings      struct            — Batch settings.<br/>cutoff     duration  required  — Maximum batch size: trigger will send a batch if its lifetime exceeds this value.<br/>max-bytes  int                 — Maximum batch size: trigger will send a batch if total size of events exceeds this value.<br/>max-count  int                 — Maximum batch size: trigger will send a batch if number of events exceeds this value.<br/>service-account-id  string  required  — SA which should be used to start workflow.<br/>workflow-id         string  required  — Workflow ID.<br/>|
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
