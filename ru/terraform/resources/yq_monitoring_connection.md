---
subcategory: Resource Manager
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/yq_monitoring_connection.md
---

# yandex_yq_monitoring_connection (Resource)

Manages Monitoring connection in Yandex Query service. For more information, see [the official documentation](https://yandex.cloud/docs/query/concepts/glossary#connection).

## Example usage

```terraform
//
// Create a new Monitoring connection.
//

resource "yandex_yq_monitoring_connection" "my_mon_connection" {
  name               = "tf-test-mon-connection"
  description        = "Connection has been created from Terraform"
  folder_id          = "my_folder"
  service_account_id = yandex_iam_service_account.for-yq.id
}
```

## Arguments & Attributes Reference

- `cloud_id` (*Read-Only*) (String). The cloud identifier.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The resource name.
- `service_account_id` (String). The service account ID to access resources on behalf of.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_yq_monitoring_connection.<resource Name> <resource Id>
terraform import yandex_yq_monitoring_connection.my_mon_connection ...
```
