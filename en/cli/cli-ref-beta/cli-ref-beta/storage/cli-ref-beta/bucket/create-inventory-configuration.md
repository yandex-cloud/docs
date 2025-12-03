---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/bucket/create-inventory-configuration.md
---

# yc beta storage bucket create-inventory-configuration

Create/Update an inventory configuration with the corresponding ID

#### Command Usage

Syntax: 

`yc beta storage bucket create-inventory-configuration <ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket`|<b>`string`</b><br/>Name of the bucket to update the inventory configuration for.|
|`--configuration`|<b>`shorthand/json`</b><br/>Inventory configuration.<br/><br/>Example:|
|`--configuration`|<b>`destination={bucket-destination={bucket=value,`</b><br/>format=CSV, prefix=example}}, filter={prefix=value}, id=value, included-object-versions=ALL, is-enabled=true, optional-fields=SIZE, schedule={frequency=DAILY}<br/><br/>Shorthand Syntax:<br/>{destination={bucket-destination={bucket=str, format=CSV, prefix=str}}, filter={prefix=str}, id=str, included-object-versions=ALL\|CURRENT, is-enabled=bool, optional-fields=SIZE\|LAST_MODIFIED_DATE\|STORAGE_CLASS\|ETAG\|IS_MULTIPART_UPLOADED\|ENCRYPTION_STATUS\|OBJECT_LOCK_RETAIN_UNTIL_DATE\|OBJECT_LOCK_MODE\|OBJECT_LOCK_LEGAL_HOLD_STATUS\|CHECKSUM_ALGORITHM\|OBJECT_ACCESS_CONTROL_LIST\|OBJECT_OWNER,..., schedule={frequency=DAILY\|WEEKLY}}<br/>Fields:<br/>destination               struct             required  — Contains information about where to publish the inventory results.<br/>bucket-destination  struct  required  — Destination bucket settings<br/>bucket  string     required  — Bucket where inventory results will be published.<br/>format  enum\<CSV\>  required  — Specifies the output format of the inventory results.<br/>prefix  str                  — The prefix that is prepended to all inventory results.<br/>filter                    struct                       — Specifies the filter for objects to include in the inventory.<br/>prefix  string  required  — The prefix that an object must have to be included in the inventory results.<br/>id                        string             required  — The ID used to identify the inventory configuration.<br/>included-object-versions  enum<ALL\|CURRENT>  required  — Object versions to include in the inventory list.<br/>is-enabled                bool                         — Specifies whether the inventory is enabled.<br/>optional-fields           []int                        — Contains the optional fields that are included in the inventory results.<br/>schedule                  struct             required  — Specifies the schedule for generating inventory results.<br/>frequency  enum<DAILY\|WEEKLY>  required  — Specifies how frequently inventory results are produced.<br/>|
|`--id`|<b>`string`</b><br/>ID of the inventory configuration to set.|
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
