---
editable: false
---

# yc compute disk create

Create a disk

#### Command Usage

Syntax:

`yc compute disk create <DISK-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the disk. ||
|| `--description` | `string`

Specifies a textual description of the disk. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--zone` | `string`

The zone of the disk to create. ||
|| `--type` | `string`

Specifies the type of the disk to create. ||
|| `--size` | `byteSize`

Specifies the size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively. ||
|| `--block-size` | `byteSize`

Specifies the block size of the disk in bytes. You can also use K and M suffixes. ||
|| `--source-image-name` | `string`

A source image used to create the disk. ||
|| `--source-image-id` | `string`

An ID of the source image used to create the disk. ||
|| `--source-image-family` | `string`

An image family that is used to create the disk. ||
|| `--source-snapshot-name` | `string`

A source snapshot used to create the disk. ||
|| `--source-snapshot-id` | `string`

An ID of the source snapshot used to create the disk. ||
|| `--source-image-folder-id` | `string`

The folder ID against which all image and image family references will be resolved. ||
|| `--disk-placement-group-id` | `string`

Placement group to create the disk in. ||
|| `--disk-placement-group-name` | `string`

Placement group to create the disk in. ||
|| `--disk-placement-group-partition` | `int`

Placement group partition. Used when a placement group is created with the partition strategy. ||
|| `--kms-key-name` | `string`

KMS key used to encrypt the disk. ||
|| `--kms-key-id` | `string`

An ID of the KMS key used to encrypt the disk. ||
|| `--hardware-generation-id` | `string`

Specify an instance hardware generation ID to override the inherited or default one. ||
|| `--hardware-features` | `key=value[,key=value...]`

Specify features of the instance hardware generation to override. Use together with --hardware-generation-id. This is a list of KEY=VALUE pairs, for example '--hardware-features pci_topology=v2,other_feature=some-id'. ||
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