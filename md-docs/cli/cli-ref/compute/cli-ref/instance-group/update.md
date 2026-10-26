[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [compute](../index.md) > [instance-group](index.md) > update

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
|| `--labels` | `key=value[,key=value...]`

Resource labels as key=value pairs. The existing set of labels is completely replaced by the provided set. ||
|| `--variables` | `key=value[,key=value...]`

Variables as key=value pairs. The existing set of variables is completely replaced by the provided set. ||
|| `--scale-policy-fixed-scale-size` | `int`

[Fixed scaling policy] The number of instances in the instance group. ||
|| `--scale-policy-auto-scale-min-zone-size` | `int`

[Automatic scaling policy] Lower limit for instance count in each zone. ||
|| `--scale-policy-auto-scale-max-size` | `int`

[Automatic scaling policy] Upper limit for total instance count (across all zones). ||
|| `--service-account-id` | `string`

Service account ID for all API calls made by the Instance Groups component. ||
|| `--service-account-name` | `string`

Service account name for all API calls made by the Instance Groups component. ||
|| `--template-name` | `string`

A name of the instance. ||
|| `--template-description` | `string`

Description of the instance template. ||
|| `--template-labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. The existing set is completely replaced. ||
|| `--template-metadata` | `key=value[,key=value...]`

The metadata key=value pairs assigned to this instance template. ||
|| `--template-metadata-files` | `key=value[,key=value...]`

Same as --template-metadata except that the value is read from a local file. ||
|| `--template-memory` | `int`

The amount of memory available to the instance, specified in bytes. ||
|| `--template-cores` | `int`

The number of cores available to the instance. ||
|| `--template-core-fraction` | `int`

Baseline performance for a core in percent. ||
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