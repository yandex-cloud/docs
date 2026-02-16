---
subcategory: Network Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/lb_target_group.md
---

# yandex_lb_target_group (Resource)

A TargetGroup resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

## Example usage

```terraform
//
// Create a new NLB Target Group.
//
resource "yandex_lb_target_group" "my_tg" {
  name      = "my-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.my-subnet.id
    address   = yandex_compute_instance.my-instance-1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.my-subnet.id
    address   = yandex_compute_instance.my-instance-2.network_interface.0.ip_address
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `region_id` (String). ID of the region where the target group resides.
- `target_group_id` (String). Target Group ID.
- `target` [Block]. 
  - `address` . 
  - `subnet_id` .

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_lb_target_group.<resource Name> <resource Id>
terraform import yandex_lb_target_group.my_tg ...
```
