---
editable: false
sourcePath: en/_api-ref-grpc/datatransfer/v1/api-ref/grpc/Transfer/update.md
---

# Data Transfer API, gRPC: TransferService.Update

Updates the specified transfer.

## gRPC request

**rpc Update ([UpdateTransferRequest](#yandex.cloud.datatransfer.v1.UpdateTransferRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateTransferRequest {#yandex.cloud.datatransfer.v1.UpdateTransferRequest}

```json
{
  "transfer_id": "string",
  "description": "string",
  "runtime": {
    // Includes only one of the fields `yc_runtime`
    "yc_runtime": {
      "job_count": "int64",
      "upload_shard_params": {
        "job_count": "int64",
        "process_count": "int64"
      }
    }
    // end of the list of possible fields
  },
  "name": "string",
  "update_mask": "google.protobuf.FieldMask",
  "labels": "map<string, string>",
  "transformation": {
    "transformers": [
      {
        // Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`
        "mask_field": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "columns": [
            "string"
          ],
          "function": {
            // Includes only one of the fields `mask_function_hash`
            "mask_function_hash": {
              "user_defined_salt": "string"
            }
            // end of the list of possible fields
          }
        },
        "filter_columns": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "columns": {
            "include_columns": [
              "string"
            ],
            "exclude_columns": [
              "string"
            ]
          }
        },
        "rename_tables": {
          "rename_tables": [
            {
              "original_name": {
                "name_space": "string",
                "name": "string"
              },
              "new_name": {
                "name_space": "string",
                "name": "string"
              }
            }
          ]
        },
        "replace_primary_key": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "keys": [
            "string"
          ]
        },
        "convert_to_string": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "columns": {
            "include_columns": [
              "string"
            ],
            "exclude_columns": [
              "string"
            ]
          }
        },
        "sharder_transformer": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "columns": {
            "include_columns": [
              "string"
            ],
            "exclude_columns": [
              "string"
            ]
          },
          "shards_count": "int64"
        },
        "table_splitter_transformer": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "columns": [
            "string"
          ],
          "splitter": "string"
        },
        "filter_rows": {
          "tables": {
            "include_tables": [
              "string"
            ],
            "exclude_tables": [
              "string"
            ]
          },
          "filter": "string",
          "filters": [
            "string"
          ]
        }
        // end of the list of possible fields
      }
    ]
  },
  "data_objects": {
    "include_objects": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| transfer_id | **string**

Identifier of the transfer to be updated. ||
|| description | **string**

The new description for the transfer. ||
|| runtime | **[Runtime](#yandex.cloud.datatransfer.v1.Runtime)** ||
|| name | **string**

The new transfer name. Must be unique within the folder. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask specifying transfer fields to be updated. Semantics for this field is
described here:
<https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask>
The only exception: if the repeated field is specified in the mask, then
the new value replaces the old one instead of being appended to the old one. ||
|| labels | **object** (map<**string**, **string**>)

Transfer labels as `key:value` pairs.

For details about the concept, see [documentation]({{ api-url-prefix
}}/resource-manager/concepts/labels). ||
|| transformation | **[Transformation](#yandex.cloud.datatransfer.v1.Transformation)** ||
|| data_objects | **[DataObjects](#yandex.cloud.datatransfer.v1.DataObjects)** ||
|#

## Runtime {#yandex.cloud.datatransfer.v1.Runtime}

#|
||Field | Description ||
|| yc_runtime | **[YcRuntime](#yandex.cloud.datatransfer.v1.YcRuntime)**

Includes only one of the fields `yc_runtime`. ||
|#

## YcRuntime {#yandex.cloud.datatransfer.v1.YcRuntime}

#|
||Field | Description ||
|| job_count | **int64** ||
|| upload_shard_params | **[ShardingUploadParams](#yandex.cloud.datatransfer.v1.ShardingUploadParams)** ||
|#

## ShardingUploadParams {#yandex.cloud.datatransfer.v1.ShardingUploadParams}

#|
||Field | Description ||
|| job_count | **int64** ||
|| process_count | **int64** ||
|#

## Transformation {#yandex.cloud.datatransfer.v1.Transformation}

Transformation is converting data using special transformer functions.
These functions are executed on a data stream, applied to each data change item,
and transform them.
A transformer can be run at both the metadata and data levels.
Data can only be transformed if the source and target are of different types.

#|
||Field | Description ||
|| transformers[] | **[Transformer](#yandex.cloud.datatransfer.v1.Transformer)**

Transformers are set as a list.
When activating a transfer, a transformation plan is made for the tables that
match the specified criteria.
Transformers are applied to the tables in the sequence specified in the list. ||
|#

## Transformer {#yandex.cloud.datatransfer.v1.Transformer}

Some transformers may have limitations and only apply to some source-target
pairs.

#|
||Field | Description ||
|| mask_field | **[MaskFieldTransformer](#yandex.cloud.datatransfer.v1.MaskFieldTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| filter_columns | **[FilterColumnsTransformer](#yandex.cloud.datatransfer.v1.FilterColumnsTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| rename_tables | **[RenameTablesTransformer](#yandex.cloud.datatransfer.v1.RenameTablesTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| replace_primary_key | **[ReplacePrimaryKeyTransformer](#yandex.cloud.datatransfer.v1.ReplacePrimaryKeyTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| convert_to_string | **[ToStringTransformer](#yandex.cloud.datatransfer.v1.ToStringTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| sharder_transformer | **[SharderTransformer](#yandex.cloud.datatransfer.v1.SharderTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| table_splitter_transformer | **[TableSplitterTransformer](#yandex.cloud.datatransfer.v1.TableSplitterTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|| filter_rows | **[FilterRowsTransformer](#yandex.cloud.datatransfer.v1.FilterRowsTransformer)**

Includes only one of the fields `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer`, `filter_rows`. ||
|#

## MaskFieldTransformer {#yandex.cloud.datatransfer.v1.MaskFieldTransformer}

Mask field transformer allows you to hash data

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of included and excluded tables ||
|| columns[] | **string**

Specify the name of the column for data masking (a regular expression). ||
|| function | **[MaskFunction](#yandex.cloud.datatransfer.v1.MaskFunction)**

Mask function ||
|#

## TablesFilter {#yandex.cloud.datatransfer.v1.TablesFilter}

Filter tables using lists of included and excluded tables.

#|
||Field | Description ||
|| include_tables[] | **string**

List of tables that will be included to transfer ||
|| exclude_tables[] | **string**

List of tables that will be excluded to transfer ||
|#

## MaskFunction {#yandex.cloud.datatransfer.v1.MaskFunction}

Mask function

#|
||Field | Description ||
|| mask_function_hash | **[MaskFunctionHash](#yandex.cloud.datatransfer.v1.MaskFunctionHash)**

Hash mask function

Includes only one of the fields `mask_function_hash`. ||
|#

## MaskFunctionHash {#yandex.cloud.datatransfer.v1.MaskFunctionHash}

Hash data using HMAC

#|
||Field | Description ||
|| user_defined_salt | **string**

This string will be used in the HMAC(sha256, salt) function applied to the
column data. ||
|#

## FilterColumnsTransformer {#yandex.cloud.datatransfer.v1.FilterColumnsTransformer}

Set up a list of table columns to transfer

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of the tables to filter using lists of included and excluded tables. ||
|| columns | **[ColumnsFilter](#yandex.cloud.datatransfer.v1.ColumnsFilter)**

List of the columns to transfer to the target tables using lists of included and
excluded columns. ||
|#

## ColumnsFilter {#yandex.cloud.datatransfer.v1.ColumnsFilter}

Filter columns using lists of included and excluded columns.

#|
||Field | Description ||
|| include_columns[] | **string**

List of columns that will be included to transfer ||
|| exclude_columns[] | **string**

List of columns that will be excluded to transfer ||
|#

## RenameTablesTransformer {#yandex.cloud.datatransfer.v1.RenameTablesTransformer}

Set rules for renaming tables by specifying the current names of the tables in
the source and new names for these tables in the target.

#|
||Field | Description ||
|| rename_tables[] | **[RenameTable](#yandex.cloud.datatransfer.v1.RenameTable)**

List of renaming rules ||
|#

## RenameTable {#yandex.cloud.datatransfer.v1.RenameTable}

Specify rule for renaming table

#|
||Field | Description ||
|| original_name | **[Table](#yandex.cloud.datatransfer.v1.Table)**

Specify the current names of the table in the source ||
|| new_name | **[Table](#yandex.cloud.datatransfer.v1.Table)**

Specify the new names for this table in the target ||
|#

## Table {#yandex.cloud.datatransfer.v1.Table}

#|
||Field | Description ||
|| name_space | **string** ||
|| name | **string** ||
|#

## ReplacePrimaryKeyTransformer {#yandex.cloud.datatransfer.v1.ReplacePrimaryKeyTransformer}

Override primary keys

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of included and excluded tables ||
|| keys[] | **string**

List of columns to be used as primary keys ||
|#

## ToStringTransformer {#yandex.cloud.datatransfer.v1.ToStringTransformer}

Convert column values to strings
The values will be converted depending on the source type
Conversion rules are described here:
https://cloud.yandex.com/en/docs/data-transfer/concepts/data-transformation#convert-to-string

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of included and excluded tables ||
|| columns | **[ColumnsFilter](#yandex.cloud.datatransfer.v1.ColumnsFilter)**

List of included and excluded columns ||
|#

## SharderTransformer {#yandex.cloud.datatransfer.v1.SharderTransformer}

Set the number of shards for particular tables and a list of columns whose
values will be used for calculating a hash to determine a shard.

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of included and excluded tables ||
|| columns | **[ColumnsFilter](#yandex.cloud.datatransfer.v1.ColumnsFilter)**

List of included and excluded columns ||
|| shards_count | **int64**

Number of shards ||
|#

## TableSplitterTransformer {#yandex.cloud.datatransfer.v1.TableSplitterTransformer}

A transfer splits the X table into multiple tables (X_1, X_2, ..., X_n) based on
data.
If a row was located in the X table before it was split, it is now in the X_i
table,
where i is determined by the column list and split string parameters.
Example:
If the column list has two columns, month of birth and gender, specified and the
split string states @,
information about an employee whose name is John and who was born on February
11, 1984,
from the Employees table will get to a new table named Employees@February@male.

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of included and excluded tables ||
|| columns[] | **string**

Specify the columns in the tables to be partitioned. ||
|| splitter | **string**

Specify the split string to be used for merging components in a new table name. ||
|#

## FilterRowsTransformer {#yandex.cloud.datatransfer.v1.FilterRowsTransformer}

This filter only applies to transfers with queues (Logbroker or Apache Kafka®)
as a data source.
When running a transfer, only the strings meeting the specified criteria remain
in a changefeed.

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)**

List of included and excluded tables. ||
|| filter | **string**

Filtering criterion. This can be comparison operators for numeric, string, and
Boolean values,
comparison to NULL, and checking whether a substring is part of a string.
Details here:
https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.
Deprecated: Use filters instead. ||
|| filters[] | **string**

Data is transported if it satisfies at least one of filters. Consider that there
is OR statement between filters.
Each filter can be comparison operators for numeric, string, and Boolean values,
comparison to NULL, and
checking whether a substring is part of a string.
Details in docs:
https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources. ||
|#

## DataObjects {#yandex.cloud.datatransfer.v1.DataObjects}

#|
||Field | Description ||
|| include_objects[] | **string** ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#