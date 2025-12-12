---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/loadtesting/cli-ref-beta/test/create.md
---

# yc beta loadtesting test create

Creates (runs) a test in the specified folder.

#### Command Usage

Syntax: 

`yc beta loadtesting test create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--configurations`|<b>`shorthand/json`</b><br/>Test configuration associated with agents on which they will be executed. In case of multiple configurations, a multitest will be created.<br/>Shorthand Syntax:<br/>[<br/>{<br/>agent-selector = {<br/>agent = agent-id=str \| anonymous-agent=bool \| match-by-filter=str<br/>},<br/>config-id = str,<br/>files = {key={<br/>file-pointer = object-storage={<br/>bucket = str,<br/>name = str<br/>}<br/>}, key=...}<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"agent-selector": {<br/>"agent": {<br/>"agent-id": "str",<br/>"anonymous-agent": "bool",<br/>"match-by-filter": "str"<br/>}<br/>},<br/>"config-id": "str",<br/>"files": {<br/>"\<key\>": {<br/>"file-pointer": {<br/>"object-storage": {<br/>"bucket": "str",<br/>"name": "str"<br/>}<br/>}<br/>}, ...<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>agent-selector -> (struct)<br/>Agent selection criterion.<br/>agent -> (oneof<agent-id\|anonymous-agent\|match-by-filter>)<br/>Oneof agent field<br/>agent-id -> (string)<br/>Selection by agent ID.<br/>match-by-filter -> (string)<br/>Selection by filter string.<br/>anonymous-agent -> (bool)<br/>Select anonymoud (i.e. not registered) agents.<br/>config-id -> (string)<br/>ID of the config.<br/>files -> (map[string,struct])<br/>Additional files to be used during test execution, represented as 'rel_path:file' pairs. 'rel_path' can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. Use cases include: - documentation. - Custom Pandora executable. - JMeter executable or ".jmx" scenario. - etc.<br/>file-pointer -> (oneof\<object-storage\>)<br/>Oneof file-pointer field<br/>object-storage -> (struct)<br/>Reference to a file in Object Storage.<br/>bucket -> (string)<br/>Bucket name.<br/>name -> (string)<br/>File name.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a test in.|
|`--test-details`|<b>`shorthand/json`</b><br/>Test details. Name, tags etc.<br/>Shorthand Syntax:<br/>{<br/>artifact-settings = {<br/>filter-exclude = str,...,<br/>filter-include = str,...,<br/>is-archive = bool,<br/>upload-to = object-storage-bucket=str<br/>},<br/>description = str,<br/>logging-log-group-id = str,<br/>name = str,<br/>tags = [<br/>{<br/>key = str,<br/>value = str<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"artifact-settings": {<br/>"filter-exclude": [<br/>"str", ...<br/>],<br/>"filter-include": [<br/>"str", ...<br/>],<br/>"is-archive": "bool",<br/>"upload-to": {<br/>"object-storage-bucket": "str"<br/>}<br/>},<br/>"description": "str",<br/>"logging-log-group-id": "str",<br/>"name": "str",<br/>"tags": [<br/>{<br/>"key": "str",<br/>"value": "str"<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>artifact-settings -> (struct)<br/>Settings which define where to upload test artifacts and which files should be included.<br/>filter-exclude -> ([]string)<br/>Filter strings defining which files should be excluded from artifacts. GLOB format. Example: - filter_include=['*'], filter_exclude=['phout.log'] - upload all '.log' files excluding 'phout.log'.<br/>filter-include -> ([]string)<br/>Filter strings defining which files should be included to artifacts. GLOB format. Example: - ['*'] - all files will be uploaded. - ['*.log', '*.yaml] - all '.log' and '.yaml' files will be uploaded.<br/>is-archive -> (bool)<br/>Setting which defines whether artifact files should be archived prior to uploading.<br/>upload-to -> (oneof\<object-storage-bucket\>)<br/>Oneof upload-to field<br/>object-storage-bucket -> (string)<br/>Name of output object storage bucket in test's folder.<br/>description -> (string)<br/>Description of the test.<br/>logging-log-group-id -> (string)<br/>ID of the logging group to which test artifacts are uploaded.<br/>name -> (string)<br/>Name of the test.<br/>tags -> ([]struct)<br/>Tags assigned to the test.<br/>key -> (string)<br/>Key of the tag.<br/>value -> (string)<br/>Value of the tag.|
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
