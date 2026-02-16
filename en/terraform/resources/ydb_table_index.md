---
subcategory: Managed Service for YDB
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/ydb_table_index.md
---

# yandex_ydb_table_index (Resource)

Manage a YDB Table Index.

## Example usage

```terraform
//
// Create a new YDB Table Index.
//

// TBD
```

## Arguments & Attributes Reference

- `columns` (**Required**)(List Of String). 
- `connection_string` (String). 
- `cover` (List Of String). 
- `id` (String). 
- `name` (**Required**)(String). 
- `table_id` (String). 
- `table_path` (String). 
- `type` (**Required**)(String).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_ydb_table_index.<resource Name> <resource Id>
terraform import yandex_ydb_table_index.test_table_index ...
```
