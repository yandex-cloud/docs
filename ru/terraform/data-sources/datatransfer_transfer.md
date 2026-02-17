---
subcategory: Data Transfer
---

# yandex_datatransfer_transfer (DataSource)

Transfer core entity

## Example usage

```terraform
//
// Get information about existing Datatransfer Endpoint
//
data "yandex_datatransfer_transfer" "pgpg_transfer_ds" {
  transfer_id = yandex_datatransfer_transfer.pgpg_transfer.id
}
```

## Arguments & Attributes Reference

- `description` (String). Description of the transfer.
- `folder_id` (String). ID of the folder to create the transfer in.
 
 To get the folder ID, make a
 [yandex.cloud.resourcemanager.v1.FolderService.List] request.
- `id` (String). Identifier of the transfer to be returned.
 
 To get the list of all available transfers, make a [List] request.
- `labels` (Map Of String). Transfer labels as `key:value` pairs.
 
 For details about the concept, see [documentation]( api-url-prefix
 /resource-manager/concepts/labels).
- `name` (String). The transfer name. Must be unique within the folder.
- `on_create_activate_mode` (String). Activation action on create a new incremental transfer. It is not part of the transfer parameter and is used only on create. One of `sync_activate`, `async_activate`, `dont_activate`. The default is `async_activate`.
- `replication_runtime` [Block]. Replication runtime parameters for the transfer
  - `yc_runtime` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `job_count` (Number). Number of workers in parallel replication.
    - `upload_shard_params` [Block]. Parallel snapshot parameters
      - `job_count` (Number). Number of workers.
      - `process_count` (Number). Number of threads.
- `runtime` [Block]. Runtime parameters for the transfer
  - `yc_runtime` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `job_count` (Number). Number of workers in parallel replication.
    - `upload_shard_params` [Block]. Parallel snapshot parameters
      - `job_count` (Number). Number of workers.
      - `process_count` (Number). Number of threads.
- `transfer_id` (String). Identifier of the transfer to be returned.
 
 To get the list of all available transfers, make a [List] request.
- `transformation` [Block]. Transformation for the transfer.
  - `transformers` [Block]. A list of transformers. You can specify exactly 1 transformer in each element of
 list
 When activating a transfer, a transformation plan is made for the tables that
 match the specified criteria.
 Transformers are applied to the tables in the sequence specified in the list.
    - `convert_to_string` [Block]. Convert column values to strings
      - `columns` [Block]. List of included and excluded columns
        - `exclude_columns` (List Of String). List of columns that will be excluded to transfer
        - `include_columns` (List Of String). List of columns that will be included to transfer
      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `filter_columns` [Block]. Set up a list of table columns to transfer
      - `columns` [Block]. List of the columns to transfer to the target tables using lists of included and
 excluded columns.
        - `exclude_columns` (List Of String). List of columns that will be excluded to transfer
        - `include_columns` (List Of String). List of columns that will be included to transfer
      - `tables` [Block]. List of the tables to filter using lists of included and excluded tables.
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `filter_rows` [Block]. This filter only applies to transfers with queues (Logbroker or Apache Kafka®)
 as a data source. When running a transfer, only the strings meeting the
 specified criteria remain in a changefeed.
      - `filter` (String). Filtering criterion. This can be comparison operators for numeric, string, and
 Boolean values,
 comparison to NULL, and checking whether a substring is part of a string.
 Details here:
 https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.
 Deprecated: Use filters instead.
      - `filters` (List Of String). Data is transported if it satisfies at least one of filters. Consider that there
 is OR statement between filters.
 Each filter can be comparison operators for numeric, string, and Boolean values,
 comparison to NULL, and
 checking whether a substring is part of a string.
 Details in docs:
 https://yandex.cloud/en-ru/docs/data-transfer/concepts/data-transformation#append-only-sources.
      - `tables` [Block]. List of included and excluded tables.
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `mask_field` [Block]. Mask field transformer allows you to hash data
      - `columns` (List Of String). Specify the name of the column for data masking (a regular expression).
      - `function` [Block]. Mask function
        - `mask_function_hash` [Block]. Hash mask function
          - `user_defined_salt` (String). This string will be used in the HMAC(sha256, salt) function applied to the
 column data.
      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `rename_tables` [Block]. Set rules for renaming tables by specifying the current names of the tables in
 the source and new names for these tables in the target
      - `rename_tables` [Block]. List of renaming rules
        - `new_name` [Block]. Specify the new names for this table in the target
          - `name` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

          - `name_space` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

        - `original_name` [Block]. Specify the current names of the table in the source
          - `name` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

          - `name_space` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `replace_primary_key` [Block]. Override primary keys.
      - `keys` (List Of String). List of columns to be used as primary keys
      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `sharder_transformer` [Block]. Set the number of shards for particular tables and a list of columns whose
 values will be used for calculating a hash to determine a shard.
      - `columns` [Block]. List of included and excluded columns
        - `exclude_columns` (List Of String). List of columns that will be excluded to transfer
        - `include_columns` (List Of String). List of columns that will be included to transfer
      - `random` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

      - `shards_count` (Number). Number of shards
      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `table_splitter_transformer` [Block]. Splits the X table into multiple tables (X_1, X_2, ..., X_n) based on data.
      - `columns` (List Of String). Specify the columns in the tables to be partitioned.
      - `splitter` (String). Specify the split string to be used for merging components in a new table name.
      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
- `type` (String). Type of the transfer. One of SNAPSHOT_ONLY, INCREMENT_ONLY,
 SNAPSHOT_AND_INCREMENT
- `warning` (*Read-Only*) (String). Error description if transfer has any errors.


