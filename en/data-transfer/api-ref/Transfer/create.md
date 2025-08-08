---
editable: false
apiPlayground:
  - url: https://{{ api-host-data-transfer }}/v1/transfer
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        sourceId:
          description: |-
            **string**
            Identifier of the source endpoint.
          type: string
        targetId:
          description: |-
            **string**
            Identifier of the target endpoint.
          type: string
        description:
          description: |-
            **string**
            Description of the transfer.
          type: string
        folderId:
          description: |-
            **string**
            ID of the folder to create the transfer in.
            To get the folder ID, make a
            [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        runtime:
          description: '**[Runtime](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.Runtime)**'
          oneOf:
            - type: object
              properties:
                ycRuntime:
                  description: |-
                    **[YcRuntime](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.YcRuntime)**
                    Includes only one of the fields `ycRuntime`.
                  $ref: '#/definitions/YcRuntime'
        type:
          description: |-
            **enum** (TransferType)
            - `TRANSFER_TYPE_UNSPECIFIED`
            - `SNAPSHOT_AND_INCREMENT`: Snapshot and increment
            - `SNAPSHOT_ONLY`: Snapshot
            - `INCREMENT_ONLY`: Increment
          type: string
          enum:
            - TRANSFER_TYPE_UNSPECIFIED
            - SNAPSHOT_AND_INCREMENT
            - SNAPSHOT_ONLY
            - INCREMENT_ONLY
        name:
          description: |-
            **string**
            The transfer name. Must be unique within the folder.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Transfer labels as `key:value` pairs.
            For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels).
          type: string
        transformation:
          description: '**[Transformation](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.Transformation)**'
          $ref: '#/definitions/Transformation'
        dataObjects:
          description: '**[DataObjects](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.DataObjects)**'
          $ref: '#/definitions/DataObjects'
      additionalProperties: false
    definitions:
      ShardingUploadParams:
        type: object
        properties:
          jobCount:
            description: '**string** (int64)'
            type: string
            format: int64
          processCount:
            description: '**string** (int64)'
            type: string
            format: int64
      YcRuntime:
        type: object
        properties:
          jobCount:
            description: '**string** (int64)'
            type: string
            format: int64
          uploadShardParams:
            description: '**[ShardingUploadParams](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.ShardingUploadParams)**'
            $ref: '#/definitions/ShardingUploadParams'
      TablesFilter:
        type: object
        properties:
          includeTables:
            description: |-
              **string**
              List of tables that will be included to transfer
            type: array
            items:
              type: string
          excludeTables:
            description: |-
              **string**
              List of tables that will be excluded to transfer
            type: array
            items:
              type: string
      MaskFunctionHash:
        type: object
        properties:
          userDefinedSalt:
            description: |-
              **string**
              This string will be used in the HMAC(sha256, salt) function applied to the
              column data.
            type: string
      MaskFieldTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of included and excluded tables
            $ref: '#/definitions/TablesFilter'
          columns:
            description: |-
              **string**
              Specify the name of the column for data masking (a regular expression).
            type: array
            items:
              type: string
          function:
            description: |-
              **[MaskFunction](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.MaskFunction)**
              Mask function
            oneOf:
              - type: object
                properties:
                  maskFunctionHash:
                    description: |-
                      **[MaskFunctionHash](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.MaskFunctionHash)**
                      Hash mask function
                      Includes only one of the fields `maskFunctionHash`.
                    $ref: '#/definitions/MaskFunctionHash'
      ColumnsFilter:
        type: object
        properties:
          includeColumns:
            description: |-
              **string**
              List of columns that will be included to transfer
            type: array
            items:
              type: string
          excludeColumns:
            description: |-
              **string**
              List of columns that will be excluded to transfer
            type: array
            items:
              type: string
      FilterColumnsTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of the tables to filter using lists of included and excluded tables.
            $ref: '#/definitions/TablesFilter'
          columns:
            description: |-
              **[ColumnsFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.ColumnsFilter)**
              List of the columns to transfer to the target tables using lists of included and
              excluded columns.
            $ref: '#/definitions/ColumnsFilter'
      Table:
        type: object
        properties:
          nameSpace:
            description: '**string**'
            type: string
          name:
            description: '**string**'
            type: string
      RenameTable:
        type: object
        properties:
          originalName:
            description: |-
              **[Table](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.Table)**
              Specify the current names of the table in the source
            $ref: '#/definitions/Table'
          newName:
            description: |-
              **[Table](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.Table)**
              Specify the new names for this table in the target
            $ref: '#/definitions/Table'
      RenameTablesTransformer:
        type: object
        properties:
          renameTables:
            description: |-
              **[RenameTable](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.RenameTable)**
              List of renaming rules
            type: array
            items:
              $ref: '#/definitions/RenameTable'
      ReplacePrimaryKeyTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of included and excluded tables
            $ref: '#/definitions/TablesFilter'
          keys:
            description: |-
              **string**
              List of columns to be used as primary keys
            type: array
            items:
              type: string
      ToStringTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of included and excluded tables
            $ref: '#/definitions/TablesFilter'
          columns:
            description: |-
              **[ColumnsFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.ColumnsFilter)**
              List of included and excluded columns
            $ref: '#/definitions/ColumnsFilter'
      SharderTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of included and excluded tables
            $ref: '#/definitions/TablesFilter'
          columns:
            description: |-
              **[ColumnsFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.ColumnsFilter)**
              List of included and excluded columns
            $ref: '#/definitions/ColumnsFilter'
          shardsCount:
            description: |-
              **string** (int64)
              Number of shards
            type: string
            format: int64
      TableSplitterTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of included and excluded tables
            $ref: '#/definitions/TablesFilter'
          columns:
            description: |-
              **string**
              Specify the columns in the tables to be partitioned.
            type: array
            items:
              type: string
          splitter:
            description: |-
              **string**
              Specify the split string to be used for merging components in a new table name.
            type: string
      FilterRowsTransformer:
        type: object
        properties:
          tables:
            description: |-
              **[TablesFilter](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TablesFilter)**
              List of included and excluded tables.
            $ref: '#/definitions/TablesFilter'
          filter:
            description: |-
              **string**
              Filtering criterion. This can be comparison operators for numeric, string, and
              Boolean values,
              comparison to NULL, and checking whether a substring is part of a string.
              Details here:
              https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.
              Deprecated: Use filters instead.
            deprecated: true
            type: string
          filters:
            description: |-
              **string**
              Data is transported if it satisfies at least one of filters. Consider that there
              is OR statement between filters.
              Each filter can be comparison operators for numeric, string, and Boolean values,
              comparison to NULL, and
              checking whether a substring is part of a string.
              Details in docs:
              https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.
            type: array
            items:
              type: string
      Transformation:
        type: object
        properties:
          transformers:
            description: |-
              **[Transformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.Transformer)**
              Transformers are set as a list.
              When activating a transfer, a transformation plan is made for the tables that
              match the specified criteria.
              Transformers are applied to the tables in the sequence specified in the list.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    maskField:
                      description: |-
                        **[MaskFieldTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.MaskFieldTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/MaskFieldTransformer'
                    filterColumns:
                      description: |-
                        **[FilterColumnsTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.FilterColumnsTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/FilterColumnsTransformer'
                    renameTables:
                      description: |-
                        **[RenameTablesTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.RenameTablesTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/RenameTablesTransformer'
                    replacePrimaryKey:
                      description: |-
                        **[ReplacePrimaryKeyTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.ReplacePrimaryKeyTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/ReplacePrimaryKeyTransformer'
                    convertToString:
                      description: |-
                        **[ToStringTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.ToStringTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/ToStringTransformer'
                    sharderTransformer:
                      description: |-
                        **[SharderTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.SharderTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/SharderTransformer'
                    tableSplitterTransformer:
                      description: |-
                        **[TableSplitterTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.TableSplitterTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/TableSplitterTransformer'
                    filterRows:
                      description: |-
                        **[FilterRowsTransformer](/docs/data-transfer/api-ref/Transfer/create#yandex.cloud.datatransfer.v1.FilterRowsTransformer)**
                        Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`.
                      $ref: '#/definitions/FilterRowsTransformer'
      DataObjects:
        type: object
        properties:
          includeObjects:
            description: '**string**'
            type: array
            items:
              type: string
sourcePath: en/_api-ref/datatransfer/v1/api-ref/Transfer/create.md
---

# Data Transfer API, REST: Transfer.Create

Creates a transfer in the specified folder.

## HTTP request

```
POST https://{{ api-host-data-transfer }}/v1/transfer
```

## Body parameters {#yandex.cloud.datatransfer.v1.CreateTransferRequest}

```json
{
  "sourceId": "string",
  "targetId": "string",
  "description": "string",
  "folderId": "string",
  "runtime": {
    // Includes only one of the fields `ycRuntime`
    "ycRuntime": {
      "jobCount": "string",
      "uploadShardParams": {
        "jobCount": "string",
        "processCount": "string"
      }
    }
    // end of the list of possible fields
  },
  "type": "string",
  "name": "string",
  "labels": "object",
  "transformation": {
    "transformers": [
      {
        // Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`
        "maskField": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
              "string"
            ]
          },
          "columns": [
            "string"
          ],
          "function": {
            // Includes only one of the fields `maskFunctionHash`
            "maskFunctionHash": {
              "userDefinedSalt": "string"
            }
            // end of the list of possible fields
          }
        },
        "filterColumns": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
              "string"
            ]
          },
          "columns": {
            "includeColumns": [
              "string"
            ],
            "excludeColumns": [
              "string"
            ]
          }
        },
        "renameTables": {
          "renameTables": [
            {
              "originalName": {
                "nameSpace": "string",
                "name": "string"
              },
              "newName": {
                "nameSpace": "string",
                "name": "string"
              }
            }
          ]
        },
        "replacePrimaryKey": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
              "string"
            ]
          },
          "keys": [
            "string"
          ]
        },
        "convertToString": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
              "string"
            ]
          },
          "columns": {
            "includeColumns": [
              "string"
            ],
            "excludeColumns": [
              "string"
            ]
          }
        },
        "sharderTransformer": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
              "string"
            ]
          },
          "columns": {
            "includeColumns": [
              "string"
            ],
            "excludeColumns": [
              "string"
            ]
          },
          "shardsCount": "string"
        },
        "tableSplitterTransformer": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
              "string"
            ]
          },
          "columns": [
            "string"
          ],
          "splitter": "string"
        },
        "filterRows": {
          "tables": {
            "includeTables": [
              "string"
            ],
            "excludeTables": [
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
  "dataObjects": {
    "includeObjects": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| sourceId | **string**

Identifier of the source endpoint. ||
|| targetId | **string**

Identifier of the target endpoint. ||
|| description | **string**

Description of the transfer. ||
|| folderId | **string**

ID of the folder to create the transfer in.

To get the folder ID, make a
[yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| runtime | **[Runtime](#yandex.cloud.datatransfer.v1.Runtime)** ||
|| type | **enum** (TransferType)

- `TRANSFER_TYPE_UNSPECIFIED`
- `SNAPSHOT_AND_INCREMENT`: Snapshot and increment
- `SNAPSHOT_ONLY`: Snapshot
- `INCREMENT_ONLY`: Increment ||
|| name | **string**

The transfer name. Must be unique within the folder. ||
|| labels | **object** (map<**string**, **string**>)

Transfer labels as `key:value` pairs.

For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels). ||
|| transformation | **[Transformation](#yandex.cloud.datatransfer.v1.Transformation)** ||
|| dataObjects | **[DataObjects](#yandex.cloud.datatransfer.v1.DataObjects)** ||
|#

## Runtime {#yandex.cloud.datatransfer.v1.Runtime}

#|
||Field | Description ||
|| ycRuntime | **[YcRuntime](#yandex.cloud.datatransfer.v1.YcRuntime)**

Includes only one of the fields `ycRuntime`. ||
|#

## YcRuntime {#yandex.cloud.datatransfer.v1.YcRuntime}

#|
||Field | Description ||
|| jobCount | **string** (int64) ||
|| uploadShardParams | **[ShardingUploadParams](#yandex.cloud.datatransfer.v1.ShardingUploadParams)** ||
|#

## ShardingUploadParams {#yandex.cloud.datatransfer.v1.ShardingUploadParams}

#|
||Field | Description ||
|| jobCount | **string** (int64) ||
|| processCount | **string** (int64) ||
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
|| maskField | **[MaskFieldTransformer](#yandex.cloud.datatransfer.v1.MaskFieldTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| filterColumns | **[FilterColumnsTransformer](#yandex.cloud.datatransfer.v1.FilterColumnsTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| renameTables | **[RenameTablesTransformer](#yandex.cloud.datatransfer.v1.RenameTablesTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| replacePrimaryKey | **[ReplacePrimaryKeyTransformer](#yandex.cloud.datatransfer.v1.ReplacePrimaryKeyTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| convertToString | **[ToStringTransformer](#yandex.cloud.datatransfer.v1.ToStringTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| sharderTransformer | **[SharderTransformer](#yandex.cloud.datatransfer.v1.SharderTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| tableSplitterTransformer | **[TableSplitterTransformer](#yandex.cloud.datatransfer.v1.TableSplitterTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| filterRows | **[FilterRowsTransformer](#yandex.cloud.datatransfer.v1.FilterRowsTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
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
|| includeTables[] | **string**

List of tables that will be included to transfer ||
|| excludeTables[] | **string**

List of tables that will be excluded to transfer ||
|#

## MaskFunction {#yandex.cloud.datatransfer.v1.MaskFunction}

Mask function

#|
||Field | Description ||
|| maskFunctionHash | **[MaskFunctionHash](#yandex.cloud.datatransfer.v1.MaskFunctionHash)**

Hash mask function

Includes only one of the fields `maskFunctionHash`. ||
|#

## MaskFunctionHash {#yandex.cloud.datatransfer.v1.MaskFunctionHash}

Hash data using HMAC

#|
||Field | Description ||
|| userDefinedSalt | **string**

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
|| includeColumns[] | **string**

List of columns that will be included to transfer ||
|| excludeColumns[] | **string**

List of columns that will be excluded to transfer ||
|#

## RenameTablesTransformer {#yandex.cloud.datatransfer.v1.RenameTablesTransformer}

Set rules for renaming tables by specifying the current names of the tables in
the source and new names for these tables in the target.

#|
||Field | Description ||
|| renameTables[] | **[RenameTable](#yandex.cloud.datatransfer.v1.RenameTable)**

List of renaming rules ||
|#

## RenameTable {#yandex.cloud.datatransfer.v1.RenameTable}

Specify rule for renaming table

#|
||Field | Description ||
|| originalName | **[Table](#yandex.cloud.datatransfer.v1.Table)**

Specify the current names of the table in the source ||
|| newName | **[Table](#yandex.cloud.datatransfer.v1.Table)**

Specify the new names for this table in the target ||
|#

## Table {#yandex.cloud.datatransfer.v1.Table}

#|
||Field | Description ||
|| nameSpace | **string** ||
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
|| shardsCount | **string** (int64)

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
|| includeObjects[] | **string** ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#