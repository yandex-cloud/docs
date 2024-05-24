---
editable: false
sourcePath: en/_api-ref/datatransfer/v1/api-ref/Transfer/update.md
---

# Data Transfer API, REST: Transfer.update

 

 
## HTTP request {#https-request}
```
PATCH https://{{ api-host-data-transfer }}/v1/transfer/{transferId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
transferId | <p>Identifier of the transfer to be updated.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "description": "string",
  "runtime": {
    "ycRuntime": {
      "jobCount": "string",
      "uploadShardParams": {
        "jobCount": "string",
        "processCount": "string"
      }
    }
  },
  "name": "string",
  "updateMask": "string",
  "labels": "object",
  "transformation": {
    "transformers": [
      {

        // `transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`
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
            "maskFunctionHash": {
              "userDefinedSalt": "string"
            }
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
          "filter": "string"
        },
        // end of the list of possible fields`transformation.transformers[]`

      }
    ]
  }
}
```

 
Field | Description
--- | ---
description | **string**<br><p>The new description for the transfer.</p> 
runtime | **object**
runtime.<br>ycRuntime | **object**
runtime.<br>ycRuntime.<br>jobCount | **string** (int64)
runtime.<br>ycRuntime.<br>uploadShardParams | **object**
runtime.<br>ycRuntime.<br>uploadShardParams.<br>jobCount | **string** (int64)
runtime.<br>ycRuntime.<br>uploadShardParams.<br>processCount | **string** (int64)
name | **string**<br><p>The new transfer name. Must be unique within the folder.</p> 
updateMask | **string**<br><p>Field mask specifying transfer fields to be updated. Semantics for this field is described here: <a href="https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask">https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask</a> The only exception: if the repeated field is specified in the mask, then the new value replaces the old one instead of being appended to the old one.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
labels | **object**
transformation | **object**<br><p>Transformation is converting data using special transformer functions. These functions are executed on a data stream, applied to each data change item, and transform them. A transformer can be run at both the metadata and data levels. Data can only be transformed if the source and target are of different types.</p> 
transformation.<br>transformers[] | **object**<br><p>Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list.</p> 
transformation.<br>transformers[].<br>maskField | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>Mask field transformer allows you to hash data</p> 
transformation.<br>transformers[].<br>maskField.<br>tables | **object**<br><p>List of included and excluded tables</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>maskField.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>maskField.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>maskField.<br>columns[] | **string**<br><p>Specify the name of the column for data masking (a regular expression).</p> 
transformation.<br>transformers[].<br>maskField.<br>function | **object**<br><p>Mask function</p> <p>Mask function</p> 
transformation.<br>transformers[].<br>maskField.<br>function.<br>maskFunctionHash | **object**<br>Hash mask function
transformation.<br>transformers[].<br>maskField.<br>function.<br>maskFunctionHash.<br>userDefinedSalt | **string**<br><p>This string will be used in the HMAC(sha256, salt) function applied to the column data.</p> 
transformation.<br>transformers[].<br>filterColumns | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>Set up a list of table columns to transfer</p> 
transformation.<br>transformers[].<br>filterColumns.<br>tables | **object**<br><p>List of the tables to filter using lists of included and excluded tables.</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>filterColumns.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>filterColumns.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>filterColumns.<br>columns | **object**<br><p>List of the columns to transfer to the target tables using lists of included and excluded columns.</p> <p>Filter columns using lists of included and excluded columns.</p> 
transformation.<br>transformers[].<br>filterColumns.<br>columns.<br>includeColumns[] | **string**<br><p>List of columns that will be included to transfer</p> 
transformation.<br>transformers[].<br>filterColumns.<br>columns.<br>excludeColumns[] | **string**<br><p>List of columns that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>renameTables | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>Set rules for renaming tables by specifying the current names of the tables in the source and new names for these tables in the target.</p> 
transformation.<br>transformers[].<br>renameTables.<br>renameTables[] | **object**<br><p>List of renaming rules</p> 
transformation.<br>transformers[].<br>renameTables.<br>renameTables[].<br>originalName | **object**<br><p>Specify the current names of the table in the source</p> 
transformation.<br>transformers[].<br>renameTables.<br>renameTables[].<br>originalName.<br>nameSpace | **string**
transformation.<br>transformers[].<br>renameTables.<br>renameTables[].<br>originalName.<br>name | **string**
transformation.<br>transformers[].<br>renameTables.<br>renameTables[].<br>newName | **object**<br><p>Specify the new names for this table in the target</p> 
transformation.<br>transformers[].<br>renameTables.<br>renameTables[].<br>newName.<br>nameSpace | **string**
transformation.<br>transformers[].<br>renameTables.<br>renameTables[].<br>newName.<br>name | **string**
transformation.<br>transformers[].<br>replacePrimaryKey | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>Override primary keys</p> 
transformation.<br>transformers[].<br>replacePrimaryKey.<br>tables | **object**<br><p>List of included and excluded tables</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>replacePrimaryKey.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>replacePrimaryKey.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>replacePrimaryKey.<br>keys[] | **string**<br><p>List of columns to be used as primary keys</p> 
transformation.<br>transformers[].<br>convertToString | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>Convert column values to strings. The values will be converted depending on the source type. Conversion rules are described in <a href="/docs/data-transfer/concepts/data-transformation#convert-to-string">documentation</a>.</p> 
transformation.<br>transformers[].<br>convertToString.<br>tables | **object**<br><p>List of included and excluded tables</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>convertToString.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>convertToString.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>convertToString.<br>columns | **object**<br><p>List of included and excluded columns</p> <p>Filter columns using lists of included and excluded columns.</p> 
transformation.<br>transformers[].<br>convertToString.<br>columns.<br>includeColumns[] | **string**<br><p>List of columns that will be included to transfer</p> 
transformation.<br>transformers[].<br>convertToString.<br>columns.<br>excludeColumns[] | **string**<br><p>List of columns that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>sharderTransformer | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>Set the number of shards for particular tables and a list of columns whose values will be used for calculating a hash to determine a shard.</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>tables | **object**<br><p>List of included and excluded tables</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>columns | **object**<br><p>List of included and excluded columns</p> <p>Filter columns using lists of included and excluded columns.</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>columns.<br>includeColumns[] | **string**<br><p>List of columns that will be included to transfer</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>columns.<br>excludeColumns[] | **string**<br><p>List of columns that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>sharderTransformer.<br>shardsCount | **string** (int64)<br><p>Number of shards</p> 
transformation.<br>transformers[].<br>tableSplitterTransformer | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>A transfer splits the X table into multiple tables (X_1, X_2, ..., X_n) based on data. If a row was located in the X table before it was split, it is now in the X_i table, where i is determined by the column list and split string parameters. Example: If the column list has two columns, month of birth and gender, specified and the split string states @, information about an employee whose name is John and who was born on February 11, 1984, from the Employees table will get to a new table named Employees@February@male.</p> 
transformation.<br>transformers[].<br>tableSplitterTransformer.<br>tables | **object**<br><p>List of included and excluded tables</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>tableSplitterTransformer.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>tableSplitterTransformer.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>tableSplitterTransformer.<br>columns[] | **string**<br><p>Specify the columns in the tables to be partitioned.</p> 
transformation.<br>transformers[].<br>tableSplitterTransformer.<br>splitter | **string**<br><p>Specify the split string to be used for merging components in a new table name.</p> 
transformation.<br>transformers[].<br>filterRows | **object** <br>`transformation.transformers[]` includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`<br><br><p>This filter only applies to transfers with queues (Logbroker or Apache Kafka®) as a data source. When running a transfer, only the strings meeting the specified criteria remain in a changefeed.</p> 
transformation.<br>transformers[].<br>filterRows.<br>tables | **object**<br><p>List of included and excluded tables</p> <p>Filter tables using lists of included and excluded tables.</p> 
transformation.<br>transformers[].<br>filterRows.<br>tables.<br>includeTables[] | **string**<br><p>List of tables that will be included to transfer</p> 
transformation.<br>transformers[].<br>filterRows.<br>tables.<br>excludeTables[] | **string**<br><p>List of tables that will be excluded to transfer</p> 
transformation.<br>transformers[].<br>filterRows.<br>filter | **string**<br><p>Filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. For more details see <a href="/docs/data-transfer/concepts/data-transformation#append-only-sources">documentation</a>.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 