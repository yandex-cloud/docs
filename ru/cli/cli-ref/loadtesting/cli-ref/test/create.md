---
editable: false
sourcePath: en/_cli-ref/cli-ref/loadtesting/cli-ref/test/create.md
---

# yc loadtesting test create

Create a test

#### Command Usage

Syntax:

`yc loadtesting test create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the load test. ||
|| `--description` | `string`

A descriptions of the test. ||
|| `--labels` | `key1=value1[,key2=value2][,"key3=val3a,val3b"]`

Labels of the test. ||
|| `--configuration` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Load test configuration.

Possible property names:

- `id`: Specifies the id of test config to use in test.

- `agent-id`: Specifies the ID of the load testing agent to run configuration.

- `agent-by-filter`: Execute test on first available agent that matches filter string. As example:

- `--filter='id IN ("1", "2", "3")'`: 
- `--filter='name contains agent AND labels.key=value1 AND labels.another-key=value2'`: 
- `anonymous-agent`: Specifies that test will run on anonymous agent.

- `test-data`: Test data to use in configuration in format test-data=name1[,test-data=name2...] ||
|| `--test-data` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Test data sources in format name=&lt;name&gt;,s3file=&lt;s3file-name&gt;,s3bucket=&lt;s3bucket-name&gt;

Possible property names:

- `name`: The name of test data object.

- `s3bucket`: Specifies the object storage bucket name where test data is stored.

- `s3file`: Specifies the file name in object storage bucket. ||
|| `--artifacts-output-bucket` | `string`

Object Storage bucket into which test artifacts will be uploaded. ||
|| `--artifacts-make-archive` | Upload all artifacts as a single archive. ||
|| `--artifacts` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Rules defining which files should be uploaded as artifacts. Example: 'include=*,exclude=token.json,exclude=phout.log'.

Default: 'include=*.log,include=*.yaml,exclude=phout*.log'.

Possible property names:

- `include`: Filename mask specifying which files should be uploaded as artifacts.

- `exclude`: Filename mask to make exceptions from 'include' filters. ||
|| `--wait-idle-timeout` | `duration`

The timeout to interrupt the command if test is stuck. Works only if --wait flag is set. ||
|| `--wait` | Wait until test is finished ||
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