---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kafka/cli-ref-beta/user/revoke-permission.md
---

# yc beta managed-kafka user revoke-permission

Revokes permission from the specified Kafka user.

#### Command Usage

Syntax: 

`yc beta managed-kafka user revoke-permission <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the Apache Kafka® cluster the user belongs to.<br/><br/>To get the cluster ID, make a [ClusterService.List] request.|
|`--permission`|<b>`shorthand/json`</b><br/>Permission that should be revoked from the specified user.<br/><br/>Example:|
|`--permission`|<b>`allow-hosts=value,`</b><br/>role=ACCESS_ROLE_PRODUCER, topic-name=value<br/><br/>Shorthand Syntax:<br/>{allow-hosts=str,..., role=ACCESS_ROLE_PRODUCER\|ACCESS_ROLE_CONSUMER\|ACCESS_ROLE_ADMIN\|ACCESS_ROLE_TOPIC_ADMIN\|ACCESS_ROLE_TOPIC_PRODUCER\|ACCESS_ROLE_TOPIC_CONSUMER\|ACCESS_ROLE_SCHEMA_READER\|ACCESS_ROLE_SCHEMA_WRITER, topic-name=str}<br/>Fields:<br/>allow-hosts  []string                                                                                                                                                                                             — Lists hosts allowed for this permission.<br/>Only ip-addresses allowed as value of single host.<br/>When not defined, access from any host is allowed.<br/><br/>Bare in mind that the same host might appear in multiple permissions at the same time,<br/>hence removing individual permission doesn't automatically restricts access from the [allow_hosts] of the permission.<br/>If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.<br/>role         enum<ACCESS_ROLE_ADMIN\|ACCESS_ROLE_CONSUMER\|ACCESS_ROLE_PRODUCER\|ACCESS_ROLE_SCHEMA_READER\|ACCESS_ROLE_SCHEMA_WRITER\|ACCESS_ROLE_TOPIC_ADMIN\|ACCESS_ROLE_TOPIC_CONSUMER\|ACCESS_ROLE_TOPIC_PRODUCER>  — Access role type to grant to the user.<br/>topic-name   string                                                                                                                                                                                               — Name or prefix-pattern with wildcard for the topic that the permission grants access to.<br/>With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'.<br/><br/>To get the topic name, make a [TopicService.List] request.<br/>|
|`--user-name`|<b>`string`</b><br/>Name of the user to revoke a permission from.<br/><br/>To get the name of the user, make a [UserService.List] request.|
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
