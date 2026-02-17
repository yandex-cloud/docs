---
editable: false
---

# yc compute snapshot create

Create a snapshot of the specified disk

#### Command Usage

Syntax:

`yc compute snapshot create <SNAPSHOT-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the snapshot. ||
|| `--disk-id` | `string`

An ID of the source disk used to create the snapshot. ||
|| `--disk-name` | `string`

A source disk used to create the snapshot. ||
|| `--description` | `string`

Specifies a textual description of the snapshot. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
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