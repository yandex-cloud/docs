---
editable: false
---

# yc managed-kubernetes marketplace helm-release install

Install a Helm Release from Yandex Cloud Marketplace on the cluster.
Use --value to pass scalar values in KEY=VALUE format.
For complex types such as lists or objects, provide a YAML-encoded string as the value.
Use --value-from-file to read the value from a file — especially convenient for multi-line YAML.

#### Command Usage

Syntax:

`yc managed-kubernetes marketplace helm-release install --cluster-id <CLUSTER-ID> --product-version-id <PRODUCT-VERSION-ID> [--name <NAME>] [--namespace <NAMESPACE>] [--value <KEY>=<VALUE>]... [--value-from-file <KEY>=<FILE>]... [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the cluster. ||
|| `--cluster-name` | `string`

 ||
|| `--product-version-id` | `string`

ID of the Marketplace Product Version. ||
|| `--name` | `string`

Name of the Helm Release. Sets the 'applicationName' user value. ||
|| `--namespace` | `string`

Kubernetes namespace for the Helm Release. Sets the 'namespace' user value. ||
|| `--value` | `value[,value]`

Value to pass to the Helm Release in KEY=VALUE format. Can be specified multiple times. For complex types (lists, objects) provide a YAML-encoded string as the value. ||
|| `--value-from-file` | `value[,value]`

Value to pass to the Helm Release in KEY=FILE format, where FILE content is used as the value. Can be specified multiple times. ||
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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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