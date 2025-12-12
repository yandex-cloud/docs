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
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket`|<b>`string`</b><br/>Name of the bucket to update the inventory configuration for.|
|`--configuration`|<b>`shorthand/json`</b><br/>Inventory configuration.<br/>Shorthand Syntax:<br/>{<br/>destination = {<br/>bucket-destination = {<br/>bucket = str,<br/>format = CSV,<br/>prefix = str<br/>}<br/>},<br/>filter = {<br/>prefix = str<br/>},<br/>id = str,<br/>included-object-versions = ALL\|CURRENT,<br/>is-enabled = bool,<br/>optional-fields = SIZE\|LAST_MODIFIED_DATE\|STORAGE_CLASS\|ETAG\|IS_MULTIPART_UPLOADED\|ENCRYPTION_STATUS\|OBJECT_LOCK_RETAIN_UNTIL_DATE\|OBJECT_LOCK_MODE\|OBJECT_LOCK_LEGAL_HOLD_STATUS\|CHECKSUM_ALGORITHM\|OBJECT_ACCESS_CONTROL_LIST\|OBJECT_OWNER,...,<br/>schedule = {<br/>frequency = DAILY\|WEEKLY<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"bucket-destination": {<br/>"bucket": "str",<br/>"format": "CSV",<br/>"prefix": "str"<br/>}<br/>},<br/>"filter": {<br/>"prefix": "str"<br/>},<br/>"id": "str",<br/>"included-object-versions": "ALL\|CURRENT",<br/>"is-enabled": "bool",<br/>"optional-fields": [<br/>"SIZE\|LAST_MODIFIED_DATE\|STORAGE_CLASS\|ETAG\|IS_MULTIPART_UPLOADED\|ENCRYPTION_STATUS\|OBJECT_LOCK_RETAIN_UNTIL_DATE\|OBJECT_LOCK_MODE\|OBJECT_LOCK_LEGAL_HOLD_STATUS\|CHECKSUM_ALGORITHM\|OBJECT_ACCESS_CONTROL_LIST\|OBJECT_OWNER", ...<br/>],<br/>"schedule": {<br/>"frequency": "DAILY\|WEEKLY"<br/>}<br/>}"<br/>Fields:<br/>destination -> (struct)<br/>Contains information about where to publish the inventory results.<br/>bucket-destination -> (struct)<br/>Destination bucket settings<br/>bucket -> (string)<br/>Bucket where inventory results will be published.<br/>format -> (enum\<CSV\>)<br/>Specifies the output format of the inventory results.<br/>prefix -> (str)<br/>The prefix that is prepended to all inventory results.<br/>filter -> (struct)<br/>Specifies the filter for objects to include in the inventory.<br/>prefix -> (string)<br/>The prefix that an object must have to be included in the inventory results.<br/>id -> (string)<br/>The ID used to identify the inventory configuration.<br/>included-object-versions -> (enum<ALL\|CURRENT>)<br/>Object versions to include in the inventory list.<br/>is-enabled -> (bool)<br/>Specifies whether the inventory is enabled.<br/>optional-fields -> ([]int)<br/>Contains the optional fields that are included in the inventory results.<br/>schedule -> (struct)<br/>Specifies the schedule for generating inventory results.<br/>frequency -> (enum<DAILY\|WEEKLY>)<br/>Specifies how frequently inventory results are produced.|
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
