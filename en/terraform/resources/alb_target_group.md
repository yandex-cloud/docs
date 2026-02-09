---
subcategory: Application Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/alb_target_group.md
---

# yandex_alb_target_group (Resource)

Creates a target group in the specified folder and adds the specified targets to it. For more information, see [the official documentation](https://yandex.cloud/docs/application-load-balancer/concepts/target-group).

## Example usage

```terraform
//
// Create a new ALB Target Group
//
resource "yandex_alb_target_group" "foo" {
  name = "my-target-group"

  target {
    subnet_id  = yandex_vpc_subnet.my-subnet.id
    ip_address = yandex_compute_instance.my-instance-1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.my-subnet.id
    ip_address = yandex_compute_instance.my-instance-2.network_interface.0.ip_address
  }
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_alb_target_group.<resource Name> <resource Id>
terraform import yandex_alb_target_group.my_target_group ds77d**********g4pqc
```
