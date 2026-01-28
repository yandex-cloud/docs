---
editable: false
---

# yc metadata-hub connection-manager connection create mysql

Create MySQL connection

#### Command Usage

Syntax:

`yc metadata-hub connection-manager connection create mysql [<CONNECTION-NAME>] [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the connection. ||
|| `--description` | `string`

Description of the connection. ||
|| `--labels` | `key=value[,key=value...]`

A list of connection labels as key-value pairs. ||
|| `--databases` | `value[,value]`

Databases list. ||
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
|| `--hosts` | `value[,value]`

List of MySQL hosts in format 'host:port'. ||
|| `--tls-disabled` | Disable TLS for MySQL connection. ||
|| `--ca-certificate` | `string`

CA certificate file for TLS connection. ||
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