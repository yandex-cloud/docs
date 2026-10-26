[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [compute](../../index.md) > [v0](../index.md) > [instance](index.md) > update

# yc compute v0 instance update

Update the specified virtual machine instance

#### Command Usage

Syntax:

`yc compute v0 instance update <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the instance. ||
|| `--description` | `string`

Specifies a textual description of the instance. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. ||
|| `--metadata` | `key=value[,key=value...]`

Metadata to be made available to the guest operating system. ||
|| `--metadata-options` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Options set the access mode to instance's metadata.

Possible property names:

- `aws-v1-http-endpoint`: Enables access to AWS flavored metadata (IMDSv1). Values: enabled, disabled

- `aws-v1-http-token`: Enables access to IAM credentials with AWS flavored metadata (IMDSv1). Values: enabled, disabled

- `aws-v2-http-endpoint`: Enables access to AWS flavored metadata (IMDSv2). Values: enabled, disabled

- `aws-v2-http-token`: Enables access to STS credentials with AWS flavored metadata (IMDSv2). Values: enabled, disabled

- `gce-http-endpoint`: Enables access to GCE flavored metadata. Values: enabled, disabled

- `gce-http-token`: Enables access to IAM credentials with GCE flavored metadata. Values: enabled, disabled ||
|| `--metadata-from-file` | `key=value[,key=value...]`

Same as --metadata except that the value is read from a local file. ||
|| `--memory` | `byteSize`

Specifies how much memory instance should have in GB. ||
|| `--cores` | `int`

Specifies how many CPU cores instance should have. ||
|| `--core-fraction` | `int`

Specifies baseline performance for a core in percent. ||
|| `--gpus` | `int`

Specifies how many GPUs instance should have. ||
|| `--platform` | `string`

Specifies platform for the instance. ||
|| `--network-settings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Network settings for the instance.

Possible property names:

- `type`: Type of a network for virtual machine instance. Values: standard, software-accelerated ||
|| `--serial-port-settings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Serial port settings for the instance.

Possible property names:

- `ssh-authorization`: Authorization mode in interactive serial port console via SSH. Values: instance_metadata, os_login ||
|| `--preemptible` | Specifies whether instance is preemptible. ||
|| `--maintenance-policy` | `string`

Behaviour on maintenance events. Values: 'restart', 'migrate' ||
|| `--maintenance-grace-period` | `duration`

Time between notification via metadata service and maintenance. ||
|| `--placement-group-id` | `string`

Placement group ID to add the instance to. ||
|| `--placement-group-name` | `string`

Placement group name to add the instance to. ||
|| `--placement-group-partition` | `int`

Specifies placement group partition for the instance. ||
|| `--host-group-id` | `string`

Host group ID to place the instance to. ||
|| `--host-group-name` | `string`

Host group name to place the instance to. ||
|| `--host-id` | `string`

Host to place the instance to. ||
|| `--no-host-affinity-rules` | Clear host affinity rules ||
|| `--reserved-instance-pool-id` | `string`

Link instance to specified reserved instance pool. ||
|| `--reserved-instance-pool-name` | `string`

Link instance to specified reserved instance pool. ||
|| `--service-account-id` | `string`

Service account ID whose token can be obtained inside VM. ||
|| `--service-account-name` | `string`

Service account name whose token can be obtained inside VM. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#