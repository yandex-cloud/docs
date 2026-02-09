---
subcategory: Network Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/lb_target_group.md
---

# yandex_lb_target_group (DataSource)

Get information about a Yandex Load Balancer target group. For more information, see [the official documentation](https://yandex.cloud/docs/load-balancer/quickstart).
This data source is used to define [Load Balancer Target Groups](https://yandex.cloud/docs/load-balancer/concepts/target-resources) that can be used by other resources.

{% note warning %}

One of `target_group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing NLB Target Group.
//
data "yandex_lb_target_group" "my_tg" {
  target_group_id = "my-target-group-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `target` (*Read-Only*) (Set Of Object). 
  - `address` . 
  - `subnet_id` . 
- `target_group_id` (String). Target Group ID.


