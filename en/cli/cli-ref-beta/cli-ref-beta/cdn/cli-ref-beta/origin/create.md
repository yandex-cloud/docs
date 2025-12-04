---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cdn/cli-ref-beta/origin/create.md
---

# yc beta cdn origin create

Creates origin inside origin group.

#### Command Usage

Syntax: 

`yc beta cdn origin create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--backup`|Specifies whether the origin is used in its origin group as backup.<br/>A backup origin is used when one of active origins becomes unavailable.<br/><br/>Default value: False.|
|`--enabled`|The setting allows to enable or disable an Origin source in the Origins group.<br/><br/>It has two possible values:<br/><br/>True - The origin is enabled and used as a source for the CDN. An origins<br/>group must contain at least one enabled origin. Default value.<br/>False - The origin is disabled and the CDN is not using it to pull content.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder that the origin belongs to.|
|`--meta`|<b>`shorthand/json`</b><br/>Set up origin of the content.<br/><br/>Example:<br/>--meta origin-meta-variant={balancer={id=value}}<br/><br/>Shorthand Syntax:<br/>{origin-meta-variant={balancer={id=str} \| bucket={name=str} \| common={name=str} \| website={name=str}}}<br/>Fields:<br/>origin-meta-variant  oneof<balancer\|bucket\|common\|website>  — Oneof origin-meta-variant field<br/>common    struct  — A server with a domain name linked to it<br/>name  string  — Name of the origin.<br/>bucket    struct  — An Object Storage bucket not configured as a static site hosting.<br/>name  string  — Name of the origin.<br/>website   struct  — An Object Storage bucket configured as a static site hosting.<br/>name  string  — Name of the origin.<br/>balancer  struct  — An L7 load balancer from Application Load Balancer.<br/>CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.<br/>id  string  — ID of the origin.<br/>|
|`--origin-group-id`|<b>`int`</b><br/>[origin_group_id] group ID to request origins from.|
|`--provider-type`|<b>`string`</b><br/>Set up origin provider<br/><br/>It has two possible values:<br/><br/>ourcdn - Based on Yandex technologies<br/>gcore - Based on an external partner infrastructure<br/><br/>Default value: ourcdn|
|`--source`|<b>`string`</b><br/>IP address or Domain name of your origin and the port (if custom).<br/>Used if [meta] variant is 'common'.|
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
