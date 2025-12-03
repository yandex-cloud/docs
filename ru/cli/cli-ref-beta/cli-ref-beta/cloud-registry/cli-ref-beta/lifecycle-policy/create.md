---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cloud-registry/cli-ref-beta/lifecycle-policy/create.md
---

# yc beta cloud-registry lifecycle-policy create

Creates a lifecycle policy in the specified registry.

#### Command Usage

Syntax: 

`yc beta cloud-registry lifecycle-policy create <REGISTRY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the lifecycle policy. 0-1024 characters long.|
|`--name`|<b>`string`</b><br/>Name of the lifecycle policy.|
|`--registry-id`|<b>`string`</b><br/>ID of the registry to create a lifecycle policy in.|
|`--rules`|<b>`shorthand/json`</b><br/>List of lifecycle rules.<br/><br/>Example:|
|`--rules`|<b>`[{filter={docker-filters={tag-status=TAG_STATUS_ANY}},`</b><br/>kind={delete={condition={always=true}, cooldown-period-days=1, type=HARD_DELETE}}, path-prefix=value}]<br/><br/>Shorthand Syntax:<br/>[{filter={docker-filters={tag-status=TAG_STATUS_ANY\|TAGGED\|UNTAGGED} \| maven-filters={version-type=VERSION_TYPE_ANY\|RELEASE\|SNAPSHOT}}, kind={delete={condition={always=bool \| older-than-days=int \| version-condition={versions-count-greater-than=int}}, cooldown-period-days=int, type=HARD_DELETE\|SOFT_DELETE} \| keep-by-age={younger-than-days=int} \| keep-by-version={keep-versions-count=int}}, path-prefix=str},...]<br/>Fields:<br/>path-prefix  string                                     — Path prefix to which the rule applies.<br/>filter       oneof<docker-filters\|maven-filters>        — Oneof filter field<br/>docker-filters  struct  — Docker-specific filters.<br/>tag-status  enum<TAGGED\|TAG_STATUS_ANY\|UNTAGGED>  — Filter by tag status.<br/>maven-filters   struct  — Maven-specific filters.<br/>version-type  enum<RELEASE\|SNAPSHOT\|VERSION_TYPE_ANY>  — Filter by version type.<br/>kind         oneof<delete\|keep-by-age\|keep-by-version>  — Oneof kind field<br/>keep-by-age      struct  — Rule that keeps artifacts by age.<br/>younger-than-days  int  — Keep artifacts younger than this number of days.<br/>keep-by-version  struct  — Rule that keeps artifacts by version count.<br/>keep-versions-count  int  — Number of versions to keep.<br/>delete           struct  — Rule that deletes artifacts.<br/>cooldown-period-days  int                                              — Cooldown period in days before deletion.<br/>type                  enum<HARD_DELETE\|SOFT_DELETE>                    — Type of deletion.<br/>condition             oneof<always\|older-than-days\|version-condition>  — Oneof condition field<br/>older-than-days    int     — Delete artifacts older than specified days.<br/>version-condition  struct  — Delete artifacts by version count condition.<br/>versions-count-greater-than  int  — Delete when version count exceeds this number.<br/>always             bool    — Always delete (use with caution).<br/>|
|`--state`|<b>`enum`</b><br/>Initial state of the lifecycle policy. Possible Values: 'disabled', 'enabled'|
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
