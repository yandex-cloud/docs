---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/iot/cli-ref-beta/device/create.md
---

# yc beta iot device create

Creates a device in the specified registry.

#### Command Usage

Syntax: 

`yc beta iot device create <REGISTRY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--certificates`|<b>`shorthand/json`</b><br/>Device certificate.<br/>Shorthand Syntax:<br/>[<br/>{<br/>certificate-data = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"certificate-data": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>certificate-data -> (string)<br/>Public part of the device certificate.|
|`--description`|<b>`string`</b><br/>Description of the device.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the device. The name must be unique within the registry.|
|`--password`|<b>`string`</b><br/>Device password. The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols.|
|`--registry-id`|<b>`string`</b><br/>ID of the registry to create a device in. To get a registry ID, make a [yandex.cloud.iot.devices.v1.RegistryService.List] request.|
|`--topic-aliases`|<b>`stringToString`</b><br/>Alias of a device topic. Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. 'my/custom/alias' match to '\$device/{id}/events'.|
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
