---
editable: false
noIndex: true
---

# yc beta cdn raw-logs activate



#### Command Usage

Syntax:

`yc beta cdn raw-logs activate <RESOURCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--resource-id` | `string`

ID of CDN resource to switch logs storage for.. ||
|| `--settings` | `shorthand/json`

Raw logs settings.

Shorthand Syntax:

```hcl
{
  bucket-name = string,
  bucket-region = string,
  file-prefix = string
}
```

JSON Syntax:

```json
{
  "bucket-name": "string",
  "bucket-region": "string",
  "file-prefix": "string"
}
```

Fields:

```
bucket-name -> (string)
  Destination S3 bucket name, note that the suer should be owner of the bucket.
bucket-region -> (string)
  Bucket region, unused for now, could be blank.
file-prefix -> (string)
  file_prefix: prefix each log object name with specified prefix. The prefix makes it simpler for you to locate the log objects. For example, if you specify the prefix value logs/, each log object that S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders could be setup.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#