---
subcategory: Yandex Query
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/yq_yds_binding.md
---

# yandex_yq_yds_binding (Resource)

Manages Yandex DataStreams binding in Yandex Query service. For more information, see [the official documentation](https://yandex.cloud/docs/query/concepts/glossary#Binding).

## Example usage

```terraform
//
// Create a new YDS binding.
//

resource "yandex_yq_yds_binding" "my_yds_binding" {
  name          = "tf-test-os-binding"
  description   = "Binding has been created from Terraform"
  connection_id = yandex_yq_yds_connection.my_yds_connection.id
  format        = "csv_with_names"
  stream        = "my_stream"
  format_setting = {
    "data.datetime.format_name" = "POSIX"
  }
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

## Arguments & Attributes Reference

- `compression` (String). The data compression algorithm, e.g. brotli, bzip2, gzip, lz4, xz, zstd.
- `connection_id` (**Required**)(String). The connection identifier.
- `description` (String). The resource description.
- `format` (**Required**)(String). The data format, e.g. csv_with_names, json_as_string, json_each_row, json_list, parquet, raw, tsv_with_names.
- `format_setting` (Map Of String). Special format setting.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The resource name.
- `stream` (**Required**)(String). The stream name.
- `column` [Block]. 
  - `name` (**Required**)(String). Column name.
  - `not_null` (Bool). A column cannot have the NULL data type. Default: `false`.
  - `type` (String). Column data type. YQL data types are used.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_yq_yds_binding.<resource Name> <resource Id>
terraform import yandex_yq_yds_binding.my_yds_binding ...
```
