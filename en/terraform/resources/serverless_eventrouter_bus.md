---
subcategory: Serverless Event Router
---

# yandex_serverless_eventrouter_bus (Resource)



## Example usage

```terraform
//
// TBD
//
```

## Arguments & Attributes Reference

- `bus_id` (String). ID of the bus
- `cloud_id` (*Read-Only*) (String). ID of the cloud that the bus resides in
- `created_at` (*Read-Only*) (String). Creation timestamp
- `deletion_protection` (*Read-Only*) (Bool). Deletion protection
- `description` (*Read-Only*) (String). Description of the bus
- `folder_id` (*Read-Only*) (String). ID of the folder that the bus belongs to
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). Bus labels
- `name` (String). Name of the bus
- `status` (*Read-Only*) (String). Status of the bus.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_serverless_eventrouter_bus.<resource Name> <resource Id>
terraform import yandex_serverless_eventrouter_bus.evr_bus ...
```
