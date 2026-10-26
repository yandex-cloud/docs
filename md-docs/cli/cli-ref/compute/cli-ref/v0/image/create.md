[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [compute](../../index.md) > [v0](../index.md) > [image](index.md) > create

# yc compute v0 image create

Create an image

#### Command Usage

Syntax:

`yc compute v0 image create <IMAGE-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the image. ||
|| `--description` | `string`

Specifies a textual description of the image. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--family` | `string`

The family of the image. ||
|| `--min-disk-size` | `byteSize`

Specify minimum size of the disk which will be created from this image. ||
|| `--product-ids` | `[]string`

A list of product license IDs. Used for billing purposes. ||
|| `--pooled` | Create image pool for this image. ||
|| `--os-type` | `string`

OS type (optional). Values: 'linux', 'windows' ||
|| `--os-nvidia-driver` | `string`

NVIDIA driver version for the image ||
|| `--source-image-name` | `string`

A source image used to create the image. ||
|| `--source-image-id` | `string`

An ID of the source image used to create the image. ||
|| `--source-family` | `string`

The family of the source image. ||
|| `--source-snapshot-name` | `string`

A source snapshot to create the image from. ||
|| `--source-snapshot-id` | `string`

An ID of the source snapshot to create the image from. ||
|| `--source-disk-name` | `string`

A source disk to create the image from. ||
|| `--source-disk-id` | `string`

An ID of the source disk to create the image from. ||
|| `--source-uri` | `string`

The full Yandex Object Storage URI where the disk image is stored. ||
|| `--source-image-folder-id` | `string`

The folder ID against which all image and image family references will be resolved. ||
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