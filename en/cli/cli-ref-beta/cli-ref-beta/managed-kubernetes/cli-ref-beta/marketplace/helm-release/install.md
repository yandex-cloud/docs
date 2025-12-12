---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kubernetes/cli-ref-beta/marketplace/helm-release/install.md
---

# yc beta managed-kubernetes marketplace helm-release install

Installs helm release into specified Kubernetes Cluster.

#### Command Usage

Syntax: 

`yc beta managed-kubernetes marketplace helm-release install <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>The ID of the Kubernetes cluster where the Helm release is to be installed.|
|`--product-version-id`|<b>`string`</b><br/>The product version ID to install.|
|`--user-values`|<b>`shorthand/json`</b><br/>User-defined values for the Helm chart during installation.<br/>Shorthand Syntax:<br/>[<br/>{<br/>key = str,<br/>value = {<br/>value = typed-value=str<br/>}<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"key": "str",<br/>"value": {<br/>"value": {<br/>"typed-value": "str"<br/>}<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>key -> (string)<br/>The key associated with the value.<br/>value -> (struct)<br/>The value associated with the key.<br/>value -> (oneof\<typed-value\>)<br/>Oneof value field<br/>typed-value -> (string)<br/>The typed string value.|
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
