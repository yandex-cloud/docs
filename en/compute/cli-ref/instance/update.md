---
editable: false
---

# yc compute instance update

Update the specified virtual machine instance

#### Command Usage

Syntax:

`yc compute instance update <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

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

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--metadata` | `key=value[,key=value...]`

Metadata to be made available to the guest operating system running on the instance.
See for details https://yandex.cloud/ru/docs/compute/concepts/vm-metadata ||
|| `--metadata-options` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Options set the access mode to instance's metadata.

Possible property names:

- `aws-v1-http-endpoint`: Enables access to AWS flavored metadata (IMDSv1). Values: enabled, disabled

- `aws-v1-http-token`: Enables access to IAM credentials with AWS flavored metadata (IMDSv1). Values: enabled, disabled

- `gce-http-endpoint`: Enables access to GCE flavored metadata. Values: enabled, disabled

- `gce-http-token`: Enables access to IAM credentials with GCE flavored metadata. Values: enabled, disabled ||
|| `--metadata-from-file` | `key=value[,key=value...]`

Same as --metadata except that the value for the entry will be read from a local file. ||
|| `--memory` | `byteSize`

Specifies how much memory instance should have in GB. You can also use M and T suffixes to specify smaller or greater size respectively. ||
|| `--cores` | `int`

Specifies how many CPU cores instance should have. ||
|| `--core-fraction` | `int`

If provided, specifies baseline performance for a core in percent. ||
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
|| `--preemptible` | Specifies whether instance preemptible or not ||
|| `--maintenance-policy` | `string`

Behaviour on maintenance events. Values: 'restart', 'migrate' ||
|| `--maintenance-grace-period` | `duration`

Time between notification via metadata service and maintenance. ||
|| `--placement-group-id` | `string`

Placement group to add the instance to (use an empty string to remove the instance from placement group). ||
|| `--placement-group-name` | `string`

Placement group to add the instance to (use an empty string to remove the instance from placement group). ||
|| `--placement-group-partition` | `int`

Specifies placement group partition for the instance. ||
|| `--host-group-id` | `string`

Host group to place the instance to (to clear affinity rules use --no-host-affinity-rules). ||
|| `--host-group-name` | `string`

Host group to place the instance to (to clear affinity rules use --no-host-affinity-rules). ||
|| `--host-id` | `string`

Host to place the instance to (to remove all affinity rules use --no-host-affinity-rules). ||
|| `--no-host-affinity-rules` | Clear host affinity rules ||
|| `--reserved-instance-pool-id` | `string`

Link instance to specified reserved instance pool. ||
|| `--reserved-instance-pool-name` | `string`

Link instance to specified reserved instance pool. ||
|| `--service-account-id` | `string`

Service account, which token can be obtained inside VM from metadata service. ||
|| `--service-account-name` | `string`

Service account, which token can be obtained inside VM from metadata service. ||
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