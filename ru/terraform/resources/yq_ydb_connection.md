---
subcategory: Yandex Query
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/yq_ydb_connection.md
---

# yandex_yq_ydb_connection (Resource)

Manages YDB connection in Yandex Query service. For more information, see [the official documentation](https://yandex.cloud/docs/query/concepts/glossary#connection).

## Example usage

```terraform
//
// Create a new YDB connection.
//

resource "yandex_yq_ydb_connection" "my_ydb_connection" {
  name               = "tf-test-ydb-connection"
  description        = "Connection has been created from Terraform"
  database_id        = "db_id"
  service_account_id = yandex_iam_service_account.for-yq.id
}
```

## Arguments & Attributes Reference

- `database_id` (**Required**)(String). The database identifier.
- `description` (String). The resource description.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The resource name.
- `service_account_id` (String). The service account ID to access resources on behalf of.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_yq_ydb_connection.<resource Name> <resource Id>
terraform import yandex_yq_ydb_connection.my_ydb_connection ...
```
