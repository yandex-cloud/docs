---
subcategory: Serverless Cloud Functions
---

# yandex_function_scaling_policy (DataSource)

Get information about a Yandex Cloud Function Scaling Policy. For more information about Yandex Cloud Functions, see [Yandex Cloud Functions](https://yandex.cloud/docs/functions/).

This data source is used to define [Yandex Cloud Function Scaling Policy](https://yandex.cloud/docs/functions/) that can be used by other resources.

## Example usage

```terraform
//
// Get information about existing Cloud Function Scaling Policy.
//
data "yandex_function_scaling_policy" "my_scaling_policy" {
  function_id = "d4e45**********pqvd3"
}
```

## Arguments & Attributes Reference

- `function_id` (**Required**)(String). Yandex Cloud Function id used to define function.
- `id` (String). 
- `policy` [Block]. 
  - `tag` (*Read-Only*) (String). 
  - `zone_instances_limit` (Number). 
  - `zone_requests_limit` (Number).


