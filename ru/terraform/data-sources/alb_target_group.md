---
subcategory: Application Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/alb_target_group.md
---

# yandex_alb_target_group (DataSource)

Get information about a Yandex Application Load Balancer target group. For more information, see [Yandex Cloud Application Load Balancer](https://yandex.cloud/docs/application-load-balancer/quickstart).

This data source is used to define [Application Load Balancer Target Groups](https://yandex.cloud/docs/application-load-balancer/concepts/target-group) that can be used by other resources.

{% note warning %}

One of `target_group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing ALB Target Group
//
data "yandex_alb_target_group" "foo" {
  target_group_id = "my-target-group-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The resource name.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `target` [Block]. A Target resource.
  - `ip_address` (**Required**)(String). IP address of the target.
  - `private_ipv4_address` (Bool). 
  - `subnet_id` (String). ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone.
- `target_group_id` (String). Target Group ID.


