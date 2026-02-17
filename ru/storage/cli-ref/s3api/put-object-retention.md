---
editable: false
---

# yc storage s3api put-object-retention

Puts retention on the object version or enables/disables a previously set lock

#### Command Usage

Syntax:

`yc storage s3api put-object-retention [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bucket` | `string`

[REQUIRED] Bucket name ||
|| `--key` | `string`

[REQUIRED] Object key ||
|| `--retention` | `string`

Retention settings. Shorthand Syntax: Mode=string,RetainUntilDate=timestamp JSON Syntax: {"Mode": "string", "RetainUntilDate": timestamp} If you want to disable object lock, you can pass {} as the value. Example of usage: 1) --retention Mode=GOVERNANCE,RetainUntilDate=2054-11-11T15:04:05Z 2) --retention '{"Mode":"GOVERNANCE","RetainUntilDate":"2054-11-11T15:04:05Z"}' 3) --retention {} ||
|| `--version-id` | `string`

Version ID used to reference a specific version of the object. ||
|| `--bypass-governance-retention` | Indicates whether S3 Object Lock should bypass Governance-mode restrictions to process this operation. ||
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