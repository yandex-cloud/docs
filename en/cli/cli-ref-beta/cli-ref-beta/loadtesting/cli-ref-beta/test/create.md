---
editable: false
noIndex: true
---

# yc beta loadtesting test create

Creates (runs) a test in the specified folder.

#### Command Usage

Syntax:

`yc beta loadtesting test create <FOLDER-ID>`

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
|| `--configurations` | `shorthand/json`

Test configuration associated with agents on which they will be executed. In case of multiple configurations, a multitest will be created.

Shorthand Syntax:

```hcl
[
  {
    agent-selector = {
      agent = agent-id=string | anonymous-agent=boolean | match-by-filter=string
    },
    config-id = string,
    files = {key={
      file-pointer = object-storage={
        bucket = string,
        name = string
      }
    }, key=...}
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "agent-selector": {
      "agent": {
        "agent-id": "string",
        "anonymous-agent": "boolean",
        "match-by-filter": "string"
      }
    },
    "config-id": "string",
    "files": {
      "<key>": {
        "file-pointer": {
          "object-storage": {
            "bucket": "string",
            "name": "string"
          }
        }
      }, ...
    }
  }, ...
]
```

Fields:

```
agent-selector -> (struct)
  Agent selection criterion.
  agent -> (oneof<agent-id|anonymous-agent|match-by-filter>)
    Oneof agent field
    agent-id -> (string)
      Selection by agent ID.
    match-by-filter -> (string)
      Selection by filter string.
    anonymous-agent -> (boolean)
      Select anonymoud (i.e. not registered) agents.
config-id -> (string)
  ID of the config.
files -> (map[string,struct])
  Additional files to be used during test execution, represented as 'rel_path:file' pairs. 'rel_path' can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. Use cases include: - documentation. - Custom Pandora executable. - JMeter executable or ".jmx" scenario. - etc.
  file-pointer -> (oneof<object-storage>)
    Oneof file-pointer field
    object-storage -> (struct)
      Reference to a file in Object Storage.
      bucket -> (string)
        Bucket name.
      name -> (string)
        File name.
``` ||
|| `--folder-id` | `string`

ID of the folder to create a test in. ||
|| `--test-details` | `shorthand/json`

Test details. Name, tags etc.

Shorthand Syntax:

```hcl
{
  artifact-settings = {
    filter-exclude = string,...,
    filter-include = string,...,
    is-archive = boolean,
    upload-to = object-storage-bucket=string
  },
  description = string,
  logging-log-group-id = string,
  name = string,
  tags = [
    {
      key = string,
      value = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "artifact-settings": {
    "filter-exclude": [
      "string", ...
    ],
    "filter-include": [
      "string", ...
    ],
    "is-archive": "boolean",
    "upload-to": {
      "object-storage-bucket": "string"
    }
  },
  "description": "string",
  "logging-log-group-id": "string",
  "name": "string",
  "tags": [
    {
      "key": "string",
      "value": "string"
    }, ...
  ]
}
```

Fields:

```
artifact-settings -> (struct)
  Settings which define where to upload test artifacts and which files should be included.
  filter-exclude -> ([]string)
    Filter strings defining which files should be excluded from artifacts. GLOB format. Example: - filter_include=['*'], filter_exclude=['phout.log'] - upload all '.log' files excluding 'phout.log'.
  filter-include -> ([]string)
    Filter strings defining which files should be included to artifacts. GLOB format. Example: - ['*'] - all files will be uploaded. - ['*.log', '*.yaml] - all '.log' and '.yaml' files will be uploaded.
  is-archive -> (boolean)
    Setting which defines whether artifact files should be archived prior to uploading.
  upload-to -> (oneof<object-storage-bucket>)
    Oneof upload-to field
    object-storage-bucket -> (string)
      Name of output object storage bucket in test's folder.
description -> (string)
  Description of the test.
logging-log-group-id -> (string)
  ID of the logging group to which test artifacts are uploaded.
name -> (string)
  Name of the test.
tags -> ([]struct)
  Tags assigned to the test.
  key -> (string)
    Key of the tag.
  value -> (string)
    Value of the tag.
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