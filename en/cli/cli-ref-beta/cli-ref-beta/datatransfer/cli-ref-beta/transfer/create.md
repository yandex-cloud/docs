---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/datatransfer/cli-ref-beta/transfer/create.md
---

# yc beta datatransfer transfer create

Creates a transfer in the specified folder.

#### Command Usage

Syntax: 

`yc beta datatransfer transfer create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--data-objects`|<b>`shorthand/json`</b><br/><br/><br/>Example:<br/>--data-objects include-objects=value<br/><br/>Shorthand Syntax:<br/>{include-objects=str,...}<br/>Fields:<br/>include-objects  []string  —<br/>|
|`--description`|<b>`string`</b><br/>Description of the transfer.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the transfer in.<br/><br/>To get the folder ID, make a<br/>[yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Transfer labels as 'key:value' pairs.<br/><br/>For details about the concept, see [documentation]({{ api-url-prefix<br/>}}/resource-manager/concepts/labels).|
|`--name`|<b>`string`</b><br/>The transfer name. Must be unique within the folder.|
|`--replication-runtime`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--replication-runtime`|<b>`runtime={yc-runtime={job-count=1,`</b><br/>upload-shard-params={job-count=1, process-count=1}}}<br/><br/>Shorthand Syntax:<br/>{runtime={yc-runtime={job-count=int, upload-shard-params={job-count=int, process-count=int}}}}<br/>Fields:<br/>runtime  oneof\<yc-runtime\>  — Oneof runtime field<br/>yc-runtime  struct  —<br/>job-count            int     —<br/>upload-shard-params  struct  —<br/>job-count      int  —<br/>process-count  int  —<br/>|
|`--runtime`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--runtime`|<b>`runtime={yc-runtime={job-count=1,`</b><br/>upload-shard-params={job-count=1, process-count=1}}}<br/><br/>Shorthand Syntax:<br/>{runtime={yc-runtime={job-count=int, upload-shard-params={job-count=int, process-count=int}}}}<br/>Fields:<br/>runtime  oneof\<yc-runtime\>  — Oneof runtime field<br/>yc-runtime  struct  —<br/>job-count            int     —<br/>upload-shard-params  struct  —<br/>job-count      int  —<br/>process-count  int  —<br/>|
|`--source-id`|<b>`string`</b><br/>Identifier of the source endpoint.|
|`--target-id`|<b>`string`</b><br/>Identifier of the target endpoint.|
|`--transformation`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--transformation`|<b>`transformers=[{transformer={convert-to-string={columns={exclude-columns=value,`</b><br/>include-columns=value}, tables={exclude-tables=value, include-tables=value}}}}]<br/><br/>Shorthand Syntax:<br/>{transformers=[{transformer={convert-to-string={columns={exclude-columns=str,..., include-columns=str,...}, tables={exclude-tables=str,..., include-tables=str,...}} \| filter-columns={columns={exclude-columns=str,..., include-columns=str,...}, tables={exclude-tables=str,..., include-tables=str,...}} \| filter-rows={filter=str, filters=str,..., tables={exclude-tables=str,..., include-tables=str,...}} \| mask-field={columns=str,..., function={mask-function={mask-function-hash={user-defined-salt=str}}}, tables={exclude-tables=str,..., include-tables=str,...}} \| rename-tables={rename-tables=[{new-name={name=str, name-space=str}, original-name={name=str, name-space=str}},...]} \| replace-primary-key={keys=str,..., tables={exclude-tables=str,..., include-tables=str,...}} \| sharder-transformer={sharder-transformer-type={columns={exclude-columns=str,..., include-columns=str,...} \| random={}}, shards-count=int, tables={exclude-tables=str,..., include-tables=str,...}} \| table-splitter-transformer={columns=str,..., splitter=str, tables={exclude-tables=str,..., include-tables=str,...}}}},...]}<br/>Fields:<br/>transformers  []struct  — Transformers are set as a list.<br/>When activating a transfer, a transformation plan is made for the tables that<br/>match the specified criteria.<br/>Transformers are applied to the tables in the sequence specified in the list.<br/>transformer  oneof<convert-to-string\|filter-columns\|filter-rows\|mask-field\|rename-tables\|replace-primary-key\|sharder-transformer\|table-splitter-transformer>  — Oneof transformer field<br/>mask-field                  struct  —<br/>columns   []string  — Specify the name of the column for data masking (a regular expression).<br/>function  struct    — Mask function<br/>mask-function  oneof\<mask-function-hash\>  — Oneof mask-function field<br/>mask-function-hash  struct  — Hash mask function<br/>user-defined-salt  string  — This string will be used in the HMAC(sha256, salt) function applied to the<br/>column data.<br/>tables    struct    — List of included and excluded tables<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>filter-columns              struct  —<br/>columns  struct  — List of the columns to transfer to the target tables using lists of included and<br/>excluded columns.<br/>exclude-columns  []string  — List of columns that will be excluded to transfer<br/>include-columns  []string  — List of columns that will be included to transfer<br/>tables   struct  — List of the tables to filter using lists of included and excluded tables.<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>rename-tables               struct  —<br/>rename-tables  []struct  — List of renaming rules<br/>new-name       struct  — Specify the new names for this table in the target<br/>name        string  —<br/>name-space  string  —<br/>original-name  struct  — Specify the current names of the table in the source<br/>name        string  —<br/>name-space  string  —<br/>replace-primary-key         struct  —<br/>keys    []string  — List of columns to be used as primary keys<br/>tables  struct    — List of included and excluded tables<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>convert-to-string           struct  —<br/>columns  struct  — List of included and excluded columns<br/>exclude-columns  []string  — List of columns that will be excluded to transfer<br/>include-columns  []string  — List of columns that will be included to transfer<br/>tables   struct  — List of included and excluded tables<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>sharder-transformer         struct  —<br/>shards-count              int                    — Number of shards<br/>tables                    struct                 — List of included and excluded tables<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>sharder-transformer-type  oneof<columns\|random>  — Oneof sharder-transformer-type field<br/>columns  struct  — List of included and excluded columns<br/>exclude-columns  []string  — List of columns that will be excluded to transfer<br/>include-columns  []string  — List of columns that will be included to transfer<br/>random   struct  —<br/>table-splitter-transformer  struct  —<br/>columns   []string  — Specify the columns in the tables to be partitioned.<br/>splitter  string    — Specify the split string to be used for merging components in a new table name.<br/>tables    struct    — List of included and excluded tables<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>filter-rows                 struct  —<br/>filter   string    — Filtering criterion. This can be comparison operators for numeric, string, and<br/>Boolean values,<br/>comparison to NULL, and checking whether a substring is part of a string.<br/>Details here:<br/>https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.<br/>Deprecated: Use filters instead.<br/>filters  []string  — Data is transported if it satisfies at least one of filters. Consider that there<br/>is OR statement between filters.<br/>Each filter can be comparison operators for numeric, string, and Boolean values,<br/>comparison to NULL, and<br/>checking whether a substring is part of a string.<br/>Details in docs:<br/>https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.<br/>tables   struct    — List of included and excluded tables.<br/>exclude-tables  []string  — List of tables that will be excluded to transfer<br/>include-tables  []string  — List of tables that will be included to transfer<br/>|
|`--type`|<b>`enum`</b><br/>Possible Values: 'snapshot-and-increment', 'snapshot-only', 'increment-only'|
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
