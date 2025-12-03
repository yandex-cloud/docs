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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--configurations`|<b>`shorthand/json`</b><br/>Test configuration associated with agents on which they will be executed.<br/>In case of multiple configurations, a multitest will be created.<br/><br/>Example:|
|`--configurations`|<b>`[{agent-selector={agent={agent-id=value}},`</b><br/>config-id=value, files={key={file-pointer={object-storage={bucket=value, name=value}}}}}]<br/><br/>Shorthand Syntax:<br/>[{agent-selector={agent={agent-id=str \| anonymous-agent=bool \| match-by-filter=str}}, config-id=str, files={key={file-pointer={object-storage={bucket=str, name=str}}}, key=...}},...]<br/>Fields:<br/>agent-selector  struct              — Agent selection criterion.<br/>agent  oneof<agent-id\|anonymous-agent\|match-by-filter>  — Oneof agent field<br/>agent-id         string  — Selection by agent ID.<br/>match-by-filter  string  — Selection by filter string.<br/>anonymous-agent  bool    — Select anonymoud (i.e. not registered) agents.<br/>config-id       string              — ID of the config.<br/>files           map[string,struct]  — Additional files to be used during test execution, represented as 'rel_path:file' pairs.<br/><br/>'rel_path' can be either a simple file name, a relative path, or absolute path. Files are<br/>downloaded by the agent to appropriate location.<br/><br/>Use cases include:<br/>- [Test Data files](https://yandex.cloud/ru/docs/load-testing/concepts/payload).<br/>- Custom Pandora executable.<br/>- JMeter executable or ".jmx" scenario.<br/>- etc.<br/>file-pointer  oneof\<object-storage\>  — Oneof file-pointer field<br/>object-storage  struct  — Reference to a file in Object Storage.<br/>bucket  string  — Bucket name.<br/>name    string  — File name.<br/>|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a test in.|
|`--test-details`|<b>`shorthand/json`</b><br/>Test details. Name, tags etc.<br/><br/>Example:|
|`--test-details`|<b>`artifact-settings={filter-exclude=value,`</b><br/>filter-include=value, is-archive=true, upload-to={object-storage-bucket=value}}, description=value, logging-log-group-id=value, name=value, tags=[{key=value, value=value}]<br/><br/>Shorthand Syntax:<br/>{artifact-settings={filter-exclude=str,..., filter-include=str,..., is-archive=bool, upload-to={object-storage-bucket=str}}, description=str, logging-log-group-id=str, name=str, tags=[{key=str, value=str},...]}<br/>Fields:<br/>artifact-settings     struct    — Settings which define where to upload test artifacts and which files should be included.<br/>filter-exclude  []string                      — Filter strings defining which files should be excluded from artifacts. GLOB format.<br/><br/>Example:<br/>- filter_include=['*'], filter_exclude=['phout.log'] - upload all '.log' files excluding 'phout.log'.<br/>filter-include  []string                      — Filter strings defining which files should be included to artifacts. GLOB format.<br/><br/>Example:<br/>- ['*'] - all files will be uploaded.<br/>- ['*.log', '*.yaml] - all '.log' and '.yaml' files will be uploaded.<br/>is-archive      bool                          — Setting which defines whether artifact files should be archived prior to uploading.<br/>upload-to       oneof\<object-storage-bucket\>  — Oneof upload-to field<br/>object-storage-bucket  string  — Name of output object storage bucket in test's folder.<br/>description           string    — Description of the test.<br/>logging-log-group-id  string    — ID of the logging group to which test artifacts are uploaded.<br/>name                  string    — Name of the test.<br/>tags                  []struct  — Tags assigned to the test.<br/>key    string  — Key of the tag.<br/>value  string  — Value of the tag.<br/>|
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
