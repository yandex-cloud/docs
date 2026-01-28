---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/instance-group/update.md
---

# yc compute instance-group update

Update the specified instance group

#### Command Usage

Syntax:

`yc compute instance-group update <INSTANCE-GROUP-NAME>|<INSTANCE-GROUP-ID> [Global Flags...]`

Aliases:

- `apply`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

instance group id. ||
|| `--name` | `string`

instance group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--file` | `string`

A specification will be loaded from specified file in yaml format ||
|| `--new-name` | `string`

A new name of the instance group. ||
|| `--description` | `string`

A new description of the instance group. ||
|| `--labels` | `key=value`

Resource labels as key=value pairs. The existing set of `labels` is completely replaced by the provided set. ||
|| `--variables` | `key=value`

Variables as key=value pairs. The existing set of `variables` is completely replaced by the provided set. ||
|| `--scale-policy-fixed-scale-size` | `int`

[Fixed scaling policy] The number of instances in the instance group. ||
|| `--scale-policy-auto-scale-min-zone-size` | `int`

[Automatic scaling policy] Lower limit for instance count in each zone. ||
|| `--scale-policy-auto-scale-max-size` | `int`

[Automatic scaling policy] Upper limit for total instance count (across all zones). ||
|| `--service-account-id` | `string`

The service account will be used for all API calls, made by the Instance Groups component on behalf of the user. ||
|| `--service-account-name` | `string`

The service account will be used for all API calls, made by the Instance Groups component on behalf of the user. ||
|| `--template-name` | `string`

A name of the instance. ||
|| `--template-description` | `string`

Description of the instance template. ||
|| `--template-labels` | `instance_template.labels`

A list of label KEY=VALUE pairs to add. The existing set of instance_template.labels is completely replaced by the provided set. ||
|| `--template-metadata` | `key=value`

The metadata key=value pairs assigned to this instance template. This includes custom metadata and predefined keys. The existing set of `instance_template.metadata` is completely replaced by the provided set. ||
|| `--template-metadata-files` | `instance_template.metadata`

Same as --template-metadata except that the value for the entry will be read from a local file. The existing set of instance_template.metadata is completely replaced by the provided set. ||
|| `--template-memory` | `int`

The amount of memory available to the instance, specified in bytes. ||
|| `--template-cores` | `int`

The number of cores available to the instance. ||
|| `--template-core-fraction` | `int`

If provided, specifies baseline performance for a core in percent. ||
|| `--template-gpus` | `int`

The number of GPUs available to the instance. ||
|| `--template-platform` | `string`

ID of the hardware platform configuration for the instance. ||
|| `--template-placement-group` | `string`

Identifier of placement group ||
|| `--template-service-account-id` | `string`

Service account ID for the instance. ||
|| `--template-service-account-name` | `string`

Service account NAME for the instance. ||
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