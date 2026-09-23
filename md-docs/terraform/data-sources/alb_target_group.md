[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Application Load Balancer > Data Sources > alb_target_group

# yandex_alb_target_group (DataSource)

Get information about a Yandex Application Load Balancer target group. For more information, see [Yandex Cloud Application Load Balancer](../../application-load-balancer/quickstart.md).

This data source is used to define [Application Load Balancer Target Groups](../../application-load-balancer/concepts/target-group.md) that can be used by other resources.

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

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `target` (*Read-Only*) (List Of Object). Targets of the target group.
  - `external_address` . 
  - `ip_address` . 
  - `private_ipv4_address` . 
  - `subnet_id` . 
- `target_group_id` (String). Target Group ID.