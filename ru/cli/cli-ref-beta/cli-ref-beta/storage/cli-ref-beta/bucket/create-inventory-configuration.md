---
editable: false
noIndex: true
---

# yc beta storage bucket create-inventory-configuration

Create/Update an inventory configuration with the corresponding ID

#### Command Usage

Syntax:

`yc beta storage bucket create-inventory-configuration <ID>`

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
|| `--bucket` | `string`

Name of the bucket to update the inventory configuration for. ||
|| `--configuration` | `shorthand/json`

Inventory configuration.

Shorthand Syntax:

```hcl
{
  destination = {
    bucket-destination = {
      bucket = string,
      format = CSV,
      prefix = string
    }
  },
  filter = {
    prefix = string
  },
  id = string,
  included-object-versions = ALL|CURRENT,
  is-enabled = boolean,
  optional-fields = [
    SIZE|LAST_MODIFIED_DATE|STORAGE_CLASS|ETAG|IS_MULTIPART_UPLOADED|ENCRYPTION_STATUS|OBJECT_LOCK_RETAIN_UNTIL_DATE|OBJECT_LOCK_MODE|OBJECT_LOCK_LEGAL_HOLD_STATUS|CHECKSUM_ALGORITHM|OBJECT_ACCESS_CONTROL_LIST|OBJECT_OWNER, ...
  ],
  schedule = {
    frequency = DAILY|WEEKLY
  }
}
```

JSON Syntax:

```json
{
  "destination": {
    "bucket-destination": {
      "bucket": "string",
      "format": "CSV",
      "prefix": "string"
    }
  },
  "filter": {
    "prefix": "string"
  },
  "id": "string",
  "included-object-versions": "ALL|CURRENT",
  "is-enabled": "boolean",
  "optional-fields": [
    "SIZE|LAST_MODIFIED_DATE|STORAGE_CLASS|ETAG|IS_MULTIPART_UPLOADED|ENCRYPTION_STATUS|OBJECT_LOCK_RETAIN_UNTIL_DATE|OBJECT_LOCK_MODE|OBJECT_LOCK_LEGAL_HOLD_STATUS|CHECKSUM_ALGORITHM|OBJECT_ACCESS_CONTROL_LIST|OBJECT_OWNER", ...
  ],
  "schedule": {
    "frequency": "DAILY|WEEKLY"
  }
}
```

Fields:

```
destination -> (struct)
  Contains information about where to publish the inventory results.
  bucket-destination -> (struct)
    Destination bucket settings
    bucket -> (string)
      Bucket where inventory results will be published.
    format -> (struct)
      Specifies the output format of the inventory results.
    prefix -> (string)
      The prefix that is prepended to all inventory results.
filter -> (struct)
  Specifies the filter for objects to include in the inventory.
  prefix -> (string)
    The prefix that an object must have to be included in the inventory results.
id -> (string)
  The ID used to identify the inventory configuration.
included-object-versions -> (struct)
  Object versions to include in the inventory list.
is-enabled -> (boolean)
  Specifies whether the inventory is enabled.
optional-fields -> ([]struct)
  Contains the optional fields that are included in the inventory results.
schedule -> (struct)
  Specifies the schedule for generating inventory results.
  frequency -> (struct)
    Specifies how frequently inventory results are produced.
``` ||
|| `--id` | `string`

ID of the inventory configuration to set. ||
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