---
subcategory: Data Transfer
---

# yandex_datatransfer_transfer (Resource)

Transfer core entity

## Example usage

```terraform
//
// Create a new pair of Data Transfer Endpoints Source & Target and Data Transfer.
//

// Create Data Transfer Endpoint "Source"
resource "yandex_datatransfer_endpoint" "pg_source" {
  name = "pg-test-source"
  settings {
    postgres_source {
      connection {
        on_premise {
          hosts = [
            "example.org"
          ]
          port = 5432
        }
      }
      slot_gigabyte_lag_limit = 100
      database                = "db1"
      user                    = "user1"
      password {
        raw = "123"
      }
    }
  }
}

// Create Data Transfer Endpoint "Target"
resource "yandex_datatransfer_endpoint" "pg_target" {
  folder_id = "some_folder_id"
  name      = "pg-test-target2"
  settings {
    postgres_target {
      connection {
        mdb_cluster_id = "some_cluster_id"
      }
      database = "db2"
      user     = "user2"
      password {
        raw = "321"
      }
    }
  }
}

// Create Data Transfer from "Source" to "Target"
resource "yandex_datatransfer_transfer" "pgpg_transfer" {
  folder_id = "some_folder_id"
  name      = "pgpg"
  source_id = yandex_datatransfer_endpoint.pg_source.id
  target_id = yandex_datatransfer_endpoint.pg_target.id
  type      = "SNAPSHOT_AND_INCREMENT"
  runtime {
    yc_runtime {
      job_count = 1
      upload_shard_params {
        job_count     = 4
        process_count = 1
      }
    }
  }
  transformation {
    transformers {
      # one of transformer
    }
    transformers {
      # one of transformer
    }
    # ...
  }
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
- `source_id` (String). Identifier of the source endpoint.
- `target_id` (String). Identifier of the target endpoint.
- `transfer_id` (String). Identifier of the transfer to be returned.
 
 To get the list of all available transfers, make a [List] request.
- `type` (String). Type of the transfer. One of SNAPSHOT_ONLY, INCREMENT_ONLY,
 SNAPSHOT_AND_INCREMENT
- `warning` (*Read-Only*) (String). Error description if transfer has any errors.
- `data_objects` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

  - `include_objects` (List Of String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

- `regular_snapshot` [Block]. Regular snapshots for the transfer, applicable only if transfer type is
 SNAPSHOT_ONLY
  - `disabled` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

  - `settings` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `cron_expression` (String). Use a cron expression to schedule transfer regular snapshots in UTC time. 
 The used cron expression format is 5 columns specifying the execution time
 (minute, hour, day, month, day of the week), 
 they can contain a numeric list separated by commas, a range of numbers
 separated by a hyphen, symbols * or /.
 only one of schedule or cron_expression should be set
    - `increment_delay_seconds` (Number). Wait for transaction completion time, in seconds
 Set load delay time to insure that current transactions on source are completed
 and thus full data is visible for snapshot. 
 This may be useful if source cannot guarantee that cursor values grows
 monotonically - 
 due to transaction race or well-known problem that serial id sequence does not
 actually guarantee the order
    - `schedule` (String). User predefined periods to schedule regular snapshots:
 REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_15MIN,
 REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_HOUR, etc.
 only one of schedule or cron_expression should be set
    - `retry_config` [Block]. Regular snapshot retries, only for cloud installation
      - `max_attempts` (Number). Number of attempts to retry regular snapshot in case of failure. Applicable only
 for cloud installation.
    - `tables` [Block]. Incremental tables configuration for regular snapshot. 
 If not empty, each snapshot will copy only data changed since last snapshot
 based on cursor column value.
      - `cursor_column` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

      - `initial_state` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

      - `table_name` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

      - `table_namespace` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

- `replication_runtime` [Block]. Replication runtime parameters for the transfer
  - `yc_runtime` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `flavor` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `job_count` (Number). Number of workers in parallel replication.
    - `upload_shard_params` [Block]. Parallel snapshot parameters
      - `job_count` (Number). Number of workers.
      - `process_count` (Number). Number of threads.
- `runtime` [Block]. Runtime parameters for the transfer
  - `yc_runtime` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `flavor` (String). package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

    - `job_count` (Number). Number of workers in parallel replication.
    - `upload_shard_params` [Block]. Parallel snapshot parameters
      - `job_count` (Number). Number of workers.
      - `process_count` (Number). Number of threads.
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
      - `shards_count` (Number). Number of shards
      - `columns` [Block]. List of included and excluded columns
        - `exclude_columns` (List Of String). List of columns that will be excluded to transfer
        - `include_columns` (List Of String). List of columns that will be included to transfer
      - `random` [Block]. package: yandex.cloud.datatransfer.v1
filename: yandex/cloud/datatransfer/v1/transfer.proto

      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer
    - `table_splitter_transformer` [Block]. Splits the X table into multiple tables (X_1, X_2, ..., X_n) based on data.
      - `columns` (List Of String). Specify the columns in the tables to be partitioned.
      - `splitter` (String). Specify the split string to be used for merging components in a new table name.
      - `tables` [Block]. List of included and excluded tables
        - `exclude_tables` (List Of String). List of tables that will be excluded to transfer
        - `include_tables` (List Of String). List of tables that will be included to transfer

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_datatransfer_transfer.<resource Name> <resource Id>
terraform import yandex_datatransfer_endpoint.my_dt_transfer dttnc**********r3bkg
```
