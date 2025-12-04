---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/storage/cli-ref-beta/presign/create.md
---

# yc beta storage presign create

Create generates presigned URLs for the specified objects

#### Command Usage

Syntax: 

`yc beta storage presign create`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--bucket-name`|<b>`string`</b><br/>Bucket name|
|`--objects`|<b>`shorthand/json`</b><br/>List of objects to presign<br/><br/>Example:|
|`--objects`|<b>`[{as-attachment=true,`</b><br/>expires=1, headers={key=value}, method=value, name=value, version-id=value}]<br/><br/>Shorthand Syntax:<br/>[{as-attachment=bool, expires=int, headers={key=str, key=...}, method=str, name=str, version-id=str},...]<br/>Fields:<br/>as-attachment  bool                — Whether to force download as attachment<br/>expires        int                 — Expiration time in seconds<br/>headers        map[string,string]  — Additional HTTP headers<br/>method         string              — HTTP method (GET, PUT, HEAD)<br/>name           string              — Object name/key<br/>version-id     string              — Object version ID (optional)<br/>|
|`--presign-host`|<b>`string`</b><br/>Custom presign host (optional)|

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
