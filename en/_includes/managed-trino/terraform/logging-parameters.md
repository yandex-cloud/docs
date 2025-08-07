```hcl
resource "yandex_trino_cluster" "<cluster_name>" {
  ...
  logging = {
    enabled   = <enable_logging>
    folder_id = <folder_ID>
    min_level = "<logging_level>"
  }
  ...
}
```

Where:

* `enabled`: Enables logging, `true` or `false`.
* `folder_id`: Folder ID. Logs will be written to the default [log group](../../../logging/concepts/log-group.md) for this folder.
* `log_group_id`: Custom log group ID. Logs will be written to this group.

    You can specify only one of the parameters: `folder_id` or `log_group_id`.

* `min_level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.
