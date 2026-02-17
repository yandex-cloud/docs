---
subcategory: Serverless Cloud Functions
---

# yandex_function_scaling_policy (Resource)

Allows management of [Yandex Cloud Function Scaling Policies](https://yandex.cloud/docs/functions/).

## Example usage

```terraform
//
// Create a new Cloud Function Scaling Policy.
//
resource "yandex_function_scaling_policy" "my_scaling_policy" {
  function_id = "d4e45**********pqvd3"
  policy {
    tag                  = "$latest"
    zone_instances_limit = 3
    zone_requests_limit  = 100
  }
  policy {
    tag                  = "my_tag"
    zone_instances_limit = 4
    zone_requests_limit  = 150
  }
}
```

## Arguments & Attributes Reference

- `function_id` (**Required**)(String). Yandex Cloud Function id used to define function.
- `id` (String). 
- `policy` [Block]. List definition for Yandex Cloud Function scaling policies.
  - `tag` (**Required**)(String). Yandex Cloud Function version tag for Yandex Cloud Function scaling policy.
  - `zone_instances_limit` (Number). Max number of instances in one zone for Yandex Cloud Function with tag.
  - `zone_requests_limit` (Number). Max number of requests in one zone for Yandex Cloud Function with tag.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_function_scaling_policy.<resource Name> <resource Id>
terraform import yandex_function_scaling_policy.my_policy ...
```
