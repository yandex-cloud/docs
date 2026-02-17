---
subcategory: Yandex Query
---

# yandex_yq_object_storage_binding (Resource)

Manages Object Storage binding in Yandex Query service. For more information, see [the official documentation](https://yandex.cloud/docs/query/concepts/glossary#Binding).

## Example usage

```terraform
//
// Create a new Object Storage binding.
//

resource "yandex_yq_object_storage_binding" "my_os_binding1" {
  name          = "tf-test-os-binding1"
  description   = "Binding has been created from Terraform"
  connection_id = yandex_yq_object_storage_connection.my_os_connection.id
  compression   = "gzip"
  format        = "json_each_row"

  path_pattern = "my_logs/"
  column {
    name = "ts"
    type = "Timestamp"
  }
  column {
    name = "message"
    type = "Utf8"
  }
}
```
```terraform
//
// Create a new Object Storage binding with Hive partitioning.
//

resource "yandex_yq_object_storage_binding" "my_os_binding2" {
  name          = "tf-test-os-binding2"
  description   = "Binding has been created from Terraform"
  connection_id = yandex_yq_object_storage_connection.my_os_connection.id
  format        = "csv_with_names"
  path_pattern  = "my_logs/"
  format_setting = {
    "file_pattern" = "*.csv"
  }
  column {
    name     = "year"
    type     = "Int32"
    not_null = true
  }
  column {
    name     = "month"
    type     = "Int32"
    not_null = true
  }
  column {
    name     = "day"
    type     = "Int32"
    not_null = true
  }

  partitioned_by = ["year", "month", "day"]
  column {
    name = "ts"
    type = "Timestamp"
  }
  column {
    name = "message"
    type = "Utf8"
  }
}
```
```terraform
//
// Create a new Object Storage binding with extended partitioning.
//

resource "yandex_yq_object_storage_binding" "my_os_binding3" {
  name          = "tf-test-os-binding3"
  description   = "Binding has been created from Terraform"
  connection_id = yandex_yq_object_storage_connection.my_os_connection.id
  compression   = "gzip"
  format        = "json_each_row"

  partitioned_by = [
    "date",
    "severity",
  ]
  path_pattern = "/cold"
  projection = {
    "projection.date.format"     = "/year=%Y/month=%m/day=%d"
    "projection.date.interval"   = "1"
    "projection.date.max"        = "NOW"
    "projection.date.min"        = "2022-12-01"
    "projection.date.type"       = "date"
    "projection.date.unit"       = "DAYS"
    "projection.enabled"         = "true"
    "projection.severity.type"   = "enum"
    "projection.severity.values" = "error,info,fatal"
    "storage.location.template"  = "/$${date}/$${severity}"
  }

  column {
    name     = "timestamp"
    not_null = false
    type     = "String"
  }
  column {
    name     = "message"
    not_null = false
    type     = "String"
  }
  column {
    name     = "date"
    not_null = true
    type     = "Date"
  }
  column {
    name     = "severity"
    not_null = true
    type     = "String"
  }
}
```

## Arguments & Attributes Reference

- `compression` (String). The data compression algorithm, e.g. brotli, bzip2, gzip, lz4, xz, zstd.
- `connection_id` (**Required**)(String). The connection identifier.
- `description` (String). The resource description.
- `format` (**Required**)(String). The data format, e.g. csv_with_names, json_as_string, json_each_row, json_list, parquet, raw, tsv_with_names.
- `format_setting` (Map Of String). Special format setting.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The resource name.
- `partitioned_by` (List Of String). The list of partitioning column names.
- `path_pattern` (**Required**)(String). The path pattern within Object Storage's bucket.
- `projection` (Map Of String). Projection rules.
- `column` [Block]. 
  - `name` (**Required**)(String). Column name.
  - `not_null` (Bool). A column cannot have the NULL data type. Default: `false`.
  - `type` (String). Column data type. YQL data types are used.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_yq_object_storage_binding.<resource Name> <resource Id>
terraform import yandex_yq_object_storage_binding.my_os_binding ...
```
