---
subcategory: Yandex Query
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/yq_object_storage_connection.md
---

# yandex_yq_object_storage_connection (Resource)

Manages Object Storage connection in Yandex Query service. For more information, see [the official documentation](https://yandex.cloud/docs/query/concepts/glossary#connection).

## Example usage

```terraform
//
// Create a new Object Storage connection.
//

resource "yandex_yq_object_storage_connection" "my_os_connection" {
  name               = "tf-test-os-connection"
  description        = "Connection has been created from Terraform"
  bucket             = "some-public-bucket"
  service_account_id = yandex_iam_service_account.for-yq.id
}
```

## Arguments & Attributes Reference

- `bucket` (**Required**)(String). The bucket name from ObjectStorage.
- `description` (String). The resource description.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The resource name.
- `service_account_id` (String). The service account ID to access resources on behalf of.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_yq_object_storage_connection.<resource Name> <resource Id>
terraform import yandex_yq_object_storage_connection.my_os_connection ...
```
