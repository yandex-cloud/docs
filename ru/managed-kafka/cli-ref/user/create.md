---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kafka/cli-ref/user/create.md
---

# yc managed-kafka user create

Create a Kafka user.

#### Command Usage

Syntax:

`yc managed-kafka user create <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Kafka cluster id. ||
|| `--cluster-name` | `string`

Kafka cluster name. ||
|| `--password` | `string`

Password of the Kafka user. ||
|| `--permission` | `;`

Topic and access role to grant to the user. Can be specified multiple times.

Possible property names:

- `topic`: Name of the topic that the permission grants access to. In case of roles for schema_registry(schema_reader, schema_writer): list of allowed schema subjects, separated by ;. (required)

- `role`: Role in the topic. Possible values are: producer, consumer, admin, topic_admin. To grant multiple roles specify this property multiple times. (required)

- `allow_host`: Host allowed to access from. Only ip-addresses allowed as value of single host. To grant access for multiple hosts specify this property multiple times. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#