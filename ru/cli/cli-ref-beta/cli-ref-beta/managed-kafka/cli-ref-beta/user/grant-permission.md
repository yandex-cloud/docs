---
editable: false
noIndex: true
---

# yc beta managed-kafka user grant-permission

Grants permission to the specified Kafka user.

#### Command Usage

Syntax:

`yc beta managed-kafka user grant-permission <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the Apache Kafka® cluster the user belongs to. To get the cluster ID, make a [ClusterService.List] request. ||
|| `--permission` | `shorthand/json`

Permission that should be granted to the specified user.

Shorthand Syntax:

```hcl
{
  allow-hosts = string,...,
  role = ACCESS_ROLE_PRODUCER|ACCESS_ROLE_CONSUMER|ACCESS_ROLE_ADMIN|ACCESS_ROLE_TOPIC_ADMIN|ACCESS_ROLE_TOPIC_PRODUCER|ACCESS_ROLE_TOPIC_CONSUMER|ACCESS_ROLE_SCHEMA_READER|ACCESS_ROLE_SCHEMA_WRITER,
  topic-name = string
}
```

JSON Syntax:

```json
{
  "allow-hosts": [
    "string", ...
  ],
  "role": "ACCESS_ROLE_PRODUCER|ACCESS_ROLE_CONSUMER|ACCESS_ROLE_ADMIN|ACCESS_ROLE_TOPIC_ADMIN|ACCESS_ROLE_TOPIC_PRODUCER|ACCESS_ROLE_TOPIC_CONSUMER|ACCESS_ROLE_SCHEMA_READER|ACCESS_ROLE_SCHEMA_WRITER",
  "topic-name": "string"
}
```

Fields:

```
allow-hosts -> ([]string)
  Lists hosts allowed for this permission. Only ip-addresses allowed as value of single host. When not defined, access from any host is allowed. Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the [allow_hosts] of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.
role -> (struct)
  Access role type to grant to the user.
topic-name -> (string)
  Name or prefix-pattern with wildcard for the topic that the permission grants access to. With roles SCHEMA_READER and SCHEMA_WRITER: string that contains set of schema registry subjects, separated by ';'. To get the topic name, make a [TopicService.List] request.
``` ||
|| `--user-name` | `string`

Name of the user to grant the permission to. To get the name of the user, make a [UserService.List] request. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#