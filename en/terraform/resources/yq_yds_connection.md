---
subcategory: Yandex Query
---

# yandex_yq_yds_connection (Resource)

Manages Yandex DataStreams connection in Yandex Query service. For more information, see [the official documentation](https://yandex.cloud/docs/query/concepts/glossary#connection).

## Example usage

```terraform
//
// Create a new YDS connection.
//

resource "yandex_yq_yds_connection" "my_yds_connection" {
  name               = "tf-test-yds-connection"
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
- `shared_reading` (Bool). Whether to enable shared reading by different queries from the same connection.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_yq_yds_connection.<resource Name> <resource Id>
terraform import yandex_yq_yds_connection.my_yds_connection ...
```
