---
subcategory: DataSphere
---

# yandex_datasphere_community (Resource)

Allows management of Yandex Cloud Datasphere Communities.

## Example usage

```terraform
//
// Create a new Datasphere Community.
//
resource "yandex_datasphere_community" "my-community" {
  name               = "example-datasphere-community"
  description        = "Description of community"
  billing_account_id = "example-organization-id"
  labels = {
    "foo" : "bar"
  }
  organization_id = "example-organization-id"
}
```

## Arguments & Attributes Reference

- `billing_account_id` (String). Billing account ID to associated with community
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `created_by` (*Read-Only*) (String). Creator account ID of the Datasphere Community
- `description` (String). 
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). 
- `name` (**Required**)(String). The resource name.
- `organization_id` (String). Organization ID where community would be created

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_datasphere_community.<resource Name> <resource Id>
terraform import yandex_datasphere_community.my-community ...
```
