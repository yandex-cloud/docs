---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-spark/cli-ref-beta/job/list-log.md
---

# yc beta managed-spark job list-log

Returns a log for Spark job.

#### Command Usage

Syntax: 

`yc beta managed-spark job list-log <JOB-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the Spark cluster.|
|`--job-id`|<b>`string`</b><br/>ID of the Spark job to return.|
|`--page-size`|<b>`int`</b><br/>The maximum length of job output per papge that should be returned. If the number of available output is larger tha 'page_size', the service returns a 'next_page_token' that can be used to get the next page of job output in subsequent ListLog requests. Acceptable values are 0 to 1048576. Default value: 1048576.|
|`--page-token`|<b>`string`</b><br/>Page token. Set 'page_token' to the 'next_page_token' returned by a previous ListLog request to get the next page of results.|

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
