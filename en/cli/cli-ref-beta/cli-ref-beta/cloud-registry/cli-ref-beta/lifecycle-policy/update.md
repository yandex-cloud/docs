---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cloud-registry/cli-ref-beta/lifecycle-policy/update.md
---

# yc beta cloud-registry lifecycle-policy update

Updates the specified lifecycle policy.

#### Command Usage

Syntax: 

`yc beta cloud-registry lifecycle-policy update <POLICY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the lifecycle policy. 0-1024 characters long.|
|`--name`|<b>`string`</b><br/>Name of the lifecycle policy.|
|`--policy-id`|<b>`string`</b><br/>ID of the lifecycle policy to update.|
|`--rules`|<b>`shorthand/json`</b><br/>List of lifecycle rules.<br/>Shorthand Syntax:<br/>[<br/>{<br/>filter = docker-filters={<br/>tag-status = TAG_STATUS_ANY\|TAGGED\|UNTAGGED<br/>} \| maven-filters={<br/>version-type = VERSION_TYPE_ANY\|RELEASE\|SNAPSHOT<br/>},<br/>kind = delete={<br/>condition = always=bool \| older-than-days=int \| version-condition={<br/>versions-count-greater-than = int<br/>},<br/>cooldown-period-days = int,<br/>type = HARD_DELETE\|SOFT_DELETE<br/>} \| keep-by-age={<br/>younger-than-days = int<br/>} \| keep-by-version={<br/>keep-versions-count = int<br/>},<br/>path-prefix = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"filter": {<br/>"docker-filters": {<br/>"tag-status": "TAG_STATUS_ANY\|TAGGED\|UNTAGGED"<br/>},<br/>"maven-filters": {<br/>"version-type": "VERSION_TYPE_ANY\|RELEASE\|SNAPSHOT"<br/>}<br/>},<br/>"kind": {<br/>"delete": {<br/>"condition": {<br/>"always": "bool",<br/>"older-than-days": "int",<br/>"version-condition": {<br/>"versions-count-greater-than": "int"<br/>}<br/>},<br/>"cooldown-period-days": "int",<br/>"type": "HARD_DELETE\|SOFT_DELETE"<br/>},<br/>"keep-by-age": {<br/>"younger-than-days": "int"<br/>},<br/>"keep-by-version": {<br/>"keep-versions-count": "int"<br/>}<br/>},<br/>"path-prefix": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>path-prefix -> (string)<br/>Path prefix to which the rule applies.<br/>filter -> (oneof<docker-filters\|maven-filters>)<br/>Oneof filter field<br/>docker-filters -> (struct)<br/>Docker-specific filters.<br/>tag-status -> (enum<TAGGED\|TAG_STATUS_ANY\|UNTAGGED>)<br/>Filter by tag status.<br/>maven-filters -> (struct)<br/>Maven-specific filters.<br/>version-type -> (enum<RELEASE\|SNAPSHOT\|VERSION_TYPE_ANY>)<br/>Filter by version type.<br/>kind -> (oneof<delete\|keep-by-age\|keep-by-version>)<br/>Oneof kind field<br/>keep-by-age -> (struct)<br/>Rule that keeps artifacts by age.<br/>younger-than-days -> (int)<br/>Keep artifacts younger than this number of days.<br/>keep-by-version -> (struct)<br/>Rule that keeps artifacts by version count.<br/>keep-versions-count -> (int)<br/>Number of versions to keep.<br/>delete -> (struct)<br/>Rule that deletes artifacts.<br/>cooldown-period-days -> (int)<br/>Cooldown period in days before deletion.<br/>type -> (enum<HARD_DELETE\|SOFT_DELETE>)<br/>Type of deletion.<br/>condition -> (oneof<always\|older-than-days\|version-condition>)<br/>Oneof condition field<br/>older-than-days -> (int)<br/>Delete artifacts older than specified days.<br/>version-condition -> (struct)<br/>Delete artifacts by version count condition.<br/>versions-count-greater-than -> (int)<br/>Delete when version count exceeds this number.<br/>always -> (bool)<br/>Always delete (use with caution).|
|`--state`|<b>`enum`</b><br/>State of the lifecycle policy. Possible Values: 'disabled', 'enabled'|
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
