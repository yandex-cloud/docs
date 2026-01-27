---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/datatransfer/cli-ref-beta/transfer/update.md
---

# yc beta datatransfer transfer update

Updates the specified transfer.

#### Command Usage

Syntax:

`yc beta datatransfer transfer update <TRANSFER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--data-objects` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  include-objects = str,...
}
```

JSON Syntax:

```json
{
  "include-objects": [
    "str", ...
  ]
}
```

Fields:

```
include-objects -> ([]string)
``` ||
|| `--description` | `string`

The new description for the transfer. ||
|| `--labels` | `stringToString`

Transfer labels as 'key:value' pairs. For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels). ||
|| `--name` | `string`

The new transfer name. Must be unique within the folder. ||
|| `--replication-runtime` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  runtime = yc-runtime={
    job-count = int,
    upload-shard-params = {
      job-count = int,
      process-count = int
    }
  }
}
```

JSON Syntax:

```json
{
  "runtime": {
    "yc-runtime": {
      "job-count": "int",
      "upload-shard-params": {
        "job-count": "int",
        "process-count": "int"
      }
    }
  }
}
```

Fields:

```
runtime -> (oneof<yc-runtime>)
  Oneof runtime field
  yc-runtime -> (struct)
    job-count -> (int)
    upload-shard-params -> (struct)
      job-count -> (int)
      process-count -> (int)
``` ||
|| `--runtime` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  runtime = yc-runtime={
    job-count = int,
    upload-shard-params = {
      job-count = int,
      process-count = int
    }
  }
}
```

JSON Syntax:

```json
{
  "runtime": {
    "yc-runtime": {
      "job-count": "int",
      "upload-shard-params": {
        "job-count": "int",
        "process-count": "int"
      }
    }
  }
}
```

Fields:

```
runtime -> (oneof<yc-runtime>)
  Oneof runtime field
  yc-runtime -> (struct)
    job-count -> (int)
    upload-shard-params -> (struct)
      job-count -> (int)
      process-count -> (int)
``` ||
|| `--transfer-id` | `string`

Identifier of the transfer to be updated. ||
|| `--transformation` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  transformers = [
    {
      transformer = convert-to-string={
        columns = {
          exclude-columns = str,...,
          include-columns = str,...
        },
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      } | filter-columns={
        columns = {
          exclude-columns = str,...,
          include-columns = str,...
        },
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      } | filter-rows={
        filter = str,
        filters = str,...,
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      } | mask-field={
        columns = str,...,
        function = {
          mask-function = mask-function-hash={
            user-defined-salt = str
          }
        },
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      } | rename-tables={
        rename-tables = [
          {
            new-name = {
              name = str,
              name-space = str
            },
            original-name = {
              name = str,
              name-space = str
            }
          }, ...
        ]
      } | replace-primary-key={
        keys = str,...,
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      } | sharder-transformer={
        sharder-transformer-type = columns={
          exclude-columns = str,...,
          include-columns = str,...
        } | random={},
        shards-count = int,
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      } | table-splitter-transformer={
        columns = str,...,
        splitter = str,
        tables = {
          exclude-tables = str,...,
          include-tables = str,...
        }
      }
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "transformers": [
    {
      "transformer": {
        "convert-to-string": {
          "columns": {
            "exclude-columns": [
              "str", ...
            ],
            "include-columns": [
              "str", ...
            ]
          },
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        },
        "filter-columns": {
          "columns": {
            "exclude-columns": [
              "str", ...
            ],
            "include-columns": [
              "str", ...
            ]
          },
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        },
        "filter-rows": {
          "filter": "str",
          "filters": [
            "str", ...
          ],
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        },
        "mask-field": {
          "columns": [
            "str", ...
          ],
          "function": {
            "mask-function": {
              "mask-function-hash": {
                "user-defined-salt": "str"
              }
            }
          },
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        },
        "rename-tables": {
          "rename-tables": [
            {
              "new-name": {
                "name": "str",
                "name-space": "str"
              },
              "original-name": {
                "name": "str",
                "name-space": "str"
              }
            }, ...
          ]
        },
        "replace-primary-key": {
          "keys": [
            "str", ...
          ],
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        },
        "sharder-transformer": {
          "sharder-transformer-type": {
            "columns": {
              "exclude-columns": [
                "str", ...
              ],
              "include-columns": [
                "str", ...
              ]
            },
            "random": {}
          },
          "shards-count": "int",
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        },
        "table-splitter-transformer": {
          "columns": [
            "str", ...
          ],
          "splitter": "str",
          "tables": {
            "exclude-tables": [
              "str", ...
            ],
            "include-tables": [
              "str", ...
            ]
          }
        }
      }
    }, ...
  ]
}
```

Fields:

```
transformers -> ([]struct)
  Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list.
  transformer -> (oneof<convert-to-string|filter-columns|filter-rows|mask-field|rename-tables|replace-primary-key|sharder-transformer|table-splitter-transformer>)
    Oneof transformer field
    mask-field -> (struct)
      columns -> ([]string)
        Specify the name of the column for data masking (a regular expression).
      function -> (struct)
        Mask function
        mask-function -> (oneof<mask-function-hash>)
          Oneof mask-function field
          mask-function-hash -> (struct)
            Hash mask function
            user-defined-salt -> (string)
              This string will be used in the HMAC(sha256, salt) function applied to the column data.
      tables -> (struct)
        List of included and excluded tables
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
    filter-columns -> (struct)
      columns -> (struct)
        List of the columns to transfer to the target tables using lists of included and excluded columns.
        exclude-columns -> ([]string)
          List of columns that will be excluded to transfer
        include-columns -> ([]string)
          List of columns that will be included to transfer
      tables -> (struct)
        List of the tables to filter using lists of included and excluded tables.
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
    rename-tables -> (struct)
      rename-tables -> ([]struct)
        List of renaming rules
        new-name -> (struct)
          Specify the new names for this table in the target
          name -> (string)
          name-space -> (string)
        original-name -> (struct)
          Specify the current names of the table in the source
          name -> (string)
          name-space -> (string)
    replace-primary-key -> (struct)
      keys -> ([]string)
        List of columns to be used as primary keys
      tables -> (struct)
        List of included and excluded tables
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
    convert-to-string -> (struct)
      columns -> (struct)
        List of included and excluded columns
        exclude-columns -> ([]string)
          List of columns that will be excluded to transfer
        include-columns -> ([]string)
          List of columns that will be included to transfer
      tables -> (struct)
        List of included and excluded tables
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
    sharder-transformer -> (struct)
      shards-count -> (int)
        Number of shards
      tables -> (struct)
        List of included and excluded tables
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
      sharder-transformer-type -> (oneof<columns|random>)
        Oneof sharder-transformer-type field
        columns -> (struct)
          List of included and excluded columns
          exclude-columns -> ([]string)
            List of columns that will be excluded to transfer
          include-columns -> ([]string)
            List of columns that will be included to transfer
        random -> (struct)
    table-splitter-transformer -> (struct)
      columns -> ([]string)
        Specify the columns in the tables to be partitioned.
      splitter -> (string)
        Specify the split string to be used for merging components in a new table name.
      tables -> (struct)
        List of included and excluded tables
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
    filter-rows -> (struct)
      filter -> (string)
        Filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. Details here: https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources. Deprecated: Use filters instead.
      filters -> ([]string)
        Data is transported if it satisfies at least one of filters. Consider that there is OR statement between filters. Each filter can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. Details in docs: https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.
      tables -> (struct)
        List of included and excluded tables.
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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