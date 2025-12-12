---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cdn/cli-ref-beta/origin-group/update.md
---

# yc beta cdn origin-group update

Updates the specified origin group.

#### Command Usage

Syntax: 

`yc beta cdn origin-group update <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--folder-id`|<b>`string`</b><br/>ID of the folder that the origin group belongs to.|
|`--group-name`|<b>`string`</b><br/>Name of the origin group.|
|`--origin-group-id`|<b>`int`</b><br/>ID of the origin group.|
|`--origins`|<b>`shorthand/json`</b><br/>List of origins: IP addresses or Domain names of your origins and the port (if custom).<br/>Shorthand Syntax:<br/>[<br/>{<br/>backup = bool,<br/>enabled = bool,<br/>meta = {<br/>origin-meta-variant = balancer={<br/>id = str<br/>} \| bucket={<br/>name = str<br/>} \| common={<br/>name = str<br/>} \| website={<br/>name = str<br/>}<br/>},<br/>source = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"backup": "bool",<br/>"enabled": "bool",<br/>"meta": {<br/>"origin-meta-variant": {<br/>"balancer": {<br/>"id": "str"<br/>},<br/>"bucket": {<br/>"name": "str"<br/>},<br/>"common": {<br/>"name": "str"<br/>},<br/>"website": {<br/>"name": "str"<br/>}<br/>}<br/>},<br/>"source": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>backup -> (bool)<br/>backup option has two possible values: True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled.<br/>enabled -> (bool)<br/>The setting allows to enable or disable an Origin source in the Origins group. It has two possible values: True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content.<br/>meta -> (struct)<br/>Set up origin of the content.<br/>origin-meta-variant -> (oneof<balancer\|bucket\|common\|website>)<br/>Oneof origin-meta-variant field<br/>common -> (struct)<br/>A server with a domain name linked to it<br/>name -> (string)<br/>Name of the origin.<br/>bucket -> (struct)<br/>An Object Storage bucket not configured as a static site hosting.<br/>name -> (string)<br/>Name of the origin.<br/>website -> (struct)<br/>An Object Storage bucket configured as a static site hosting.<br/>name -> (string)<br/>Name of the origin.<br/>balancer -> (struct)<br/>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.<br/>id -> (string)<br/>ID of the origin.<br/>source -> (string)<br/>Source: IP address or Domain name of your origin and the port (if custom).|
|`--use-next`|This option have two possible values: True - The option is active. In case the origin responds with 4XX or 5XX codes, use the next origin from the list. False - The option is disabled.|
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
