---
subcategory: Serverless Cloud Functions
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/function_scaling_policy.md
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
- `policy` [Block]. List definition for Yandex Cloud Function scaling policies.
  - `tag` (**Required**)(String). Yandex Cloud Function version tag for Yandex Cloud Function scaling policy.
  - `zone_instances_limit` (Number). Max number of instances in one zone for Yandex Cloud Function with tag.
  - `zone_requests_limit` (Number). Max number of requests in one zone for Yandex Cloud Function with tag.


