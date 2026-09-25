---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/metadata-hub/cli-ref/connection-manager/connection/create/opensearch/
---

# yc metadata-hub connection-manager connection create opensearch

Create OpenSearch connection

#### Command Usage

Syntax:

`yc metadata-hub connection-manager connection create opensearch [<CONNECTION-NAME>] [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the connection. ||
|| `--description` | `string`

Description of the connection. ||
|| `--labels` | `key=value[,key=value...]`

A list of connection labels as key-value pairs. ||
|| `--secret-folder-id` | `string`

Folder where the LockBox secret associated with the connection will be created. Defaults to the connection folder ID ||
|| `--user` | `string`

Name of the user. ||
|| `--password` | `string`

Raw password. ||
|| `--password-gen-opts` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Password generations options. If you want to use default parameters, leave this field blank: ""

Possible property names:

- `length`: Lockbox password generation length.

- `include-uppercase`: Lockbox password generation include_uppercase parameter.

- `include-lowercase`: Lockbox password generation include_lowercase parameter.

- `include-digits`: Lockbox password generation include_digits parameter.

- `include-punctuation`: Lockbox password generation include_punctuation parameter.

- `included-punctuation`: Lockbox password generation included_punctuation parameter.

- `excluded-punctuation`: Lockbox password generation excluded_punctuation parameter.

- `cookie`: Password cookie. ||
|| `--managed-cluster-id` | `string`

Identifier of the cluster. ||
|| `--hosts` | `[]string`

List of OpenSearch hosts in format 'host:port'. ||
|| `--tls-disabled` | Disable TLS for OpenSearch connection. ||
|| `--ca-certificate` | `string`

CA certificate file for TLS connection. ||
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