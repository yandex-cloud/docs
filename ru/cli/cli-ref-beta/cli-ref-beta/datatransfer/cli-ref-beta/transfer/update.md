---
editable: false
noIndex: true
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
  include-objects = string,...
}
```

JSON Syntax:

```json
{
  "include-objects": [
    "string", ...
  ]
}
```

Fields:

```
include-objects -> ([]string)
``` ||
|| `--description` | `string`

The new description for the transfer. ||
|| `--labels` | `map<string><string>`

Transfer labels as 'key:value' pairs. For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels). ||
|| `--name` | `string`

The new transfer name. Must be unique within the folder. ||
|| `--replication-runtime` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  runtime = yc-runtime={
    job-count = integer,
    upload-shard-params = {
      job-count = integer,
      process-count = integer
    }
  }
}
```

JSON Syntax:

```json
{
  "runtime": {
    "yc-runtime": {
      "job-count": "integer",
      "upload-shard-params": {
        "job-count": "integer",
        "process-count": "integer"
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
    job-count -> (integer)
      Number of workers in parallel replication.
    upload-shard-params -> (struct)
      Parallel snapshot parameters
      job-count -> (integer)
        Number of workers.
      process-count -> (integer)
        Number of threads.
``` ||
|| `--runtime` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  runtime = yc-runtime={
    job-count = integer,
    upload-shard-params = {
      job-count = integer,
      process-count = integer
    }
  }
}
```

JSON Syntax:

```json
{
  "runtime": {
    "yc-runtime": {
      "job-count": "integer",
      "upload-shard-params": {
        "job-count": "integer",
        "process-count": "integer"
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
    job-count -> (integer)
      Number of workers in parallel replication.
    upload-shard-params -> (struct)
      Parallel snapshot parameters
      job-count -> (integer)
        Number of workers.
      process-count -> (integer)
        Number of threads.
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
          exclude-columns = string,...,
          include-columns = string,...
        },
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
        }
      } | filter-columns={
        columns = {
          exclude-columns = string,...,
          include-columns = string,...
        },
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
        }
      } | filter-rows={
        filter = string,
        filters = string,...,
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
        }
      } | mask-field={
        columns = string,...,
        function = {
          mask-function = mask-function-hash={
            user-defined-salt = string
          }
        },
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
        }
      } | rename-tables={
        rename-tables = [
          {
            new-name = {
              name = string,
              name-space = string
            },
            original-name = {
              name = string,
              name-space = string
            }
          }, ...
        ]
      } | replace-primary-key={
        keys = string,...,
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
        }
      } | sharder-transformer={
        sharder-transformer-type = columns={
          exclude-columns = string,...,
          include-columns = string,...
        } | random={},
        shards-count = integer,
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
        }
      } | table-splitter-transformer={
        columns = string,...,
        splitter = string,
        tables = {
          exclude-tables = string,...,
          include-tables = string,...
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
              "string", ...
            ],
            "include-columns": [
              "string", ...
            ]
          },
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
            ]
          }
        },
        "filter-columns": {
          "columns": {
            "exclude-columns": [
              "string", ...
            ],
            "include-columns": [
              "string", ...
            ]
          },
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
            ]
          }
        },
        "filter-rows": {
          "filter": "string",
          "filters": [
            "string", ...
          ],
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
            ]
          }
        },
        "mask-field": {
          "columns": [
            "string", ...
          ],
          "function": {
            "mask-function": {
              "mask-function-hash": {
                "user-defined-salt": "string"
              }
            }
          },
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
            ]
          }
        },
        "rename-tables": {
          "rename-tables": [
            {
              "new-name": {
                "name": "string",
                "name-space": "string"
              },
              "original-name": {
                "name": "string",
                "name-space": "string"
              }
            }, ...
          ]
        },
        "replace-primary-key": {
          "keys": [
            "string", ...
          ],
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
            ]
          }
        },
        "sharder-transformer": {
          "sharder-transformer-type": {
            "columns": {
              "exclude-columns": [
                "string", ...
              ],
              "include-columns": [
                "string", ...
              ]
            },
            "random": {}
          },
          "shards-count": "integer",
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
            ]
          }
        },
        "table-splitter-transformer": {
          "columns": [
            "string", ...
          ],
          "splitter": "string",
          "tables": {
            "exclude-tables": [
              "string", ...
            ],
            "include-tables": [
              "string", ...
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
  A list of transformers. You can specify exactly 1 transformer in each element of list When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list.
  transformer -> (oneof<convert-to-string|filter-columns|filter-rows|mask-field|rename-tables|replace-primary-key|sharder-transformer|table-splitter-transformer>)
    Oneof transformer field
    mask-field -> (struct)
      Mask field transformer allows you to hash data
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
      Set up a list of table columns to transfer
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
      Set rules for renaming tables by specifying the current names of the tables in the source and new names for these tables in the target
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
      Override primary keys.
      keys -> ([]string)
        List of columns to be used as primary keys
      tables -> (struct)
        List of included and excluded tables
        exclude-tables -> ([]string)
          List of tables that will be excluded to transfer
        include-tables -> ([]string)
          List of tables that will be included to transfer
    convert-to-string -> (struct)
      Convert column values to strings
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
      Set the number of shards for particular tables and a list of columns whose values will be used for calculating a hash to determine a shard.
      shards-count -> (integer)
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
      Splits the X table into multiple tables (X_1, X_2, ..., X_n) based on data.
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
      This filter only applies to transfers with queues (Logbroker or Apache Kafka®) as a data source. When running a transfer, only the strings meeting the specified criteria remain in a changefeed.
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