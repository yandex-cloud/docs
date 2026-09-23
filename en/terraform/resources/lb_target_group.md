---
subcategory: Network Load Balancer
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

- `created_at` (*Read-Only*) (String). Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Description of the target group. 0-256 characters long.
- `folder_id` (String). ID of the folder that the target group belongs to.
- `id` (String). ID of the TargetGroup resource to return.
 To get the target group ID, use a [TargetGroupService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `labels` (Map Of String). Resource labels as `` key:value `` pairs. Maximum of 64 per resource.
- `name` (String). Name of the target group.
 The name is unique within the folder. 3-63 characters long.
- `region_id` (String). ID of the region where the target group resides.
- `target_group_id` (String). ID of the TargetGroup resource to return.
 To get the target group ID, use a [TargetGroupService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `target` [Block]. A list of targets in the target group.
  - `address` (String). IP address of the target.
  - `subnet_id` (String). ID of the subnet that targets are connected to.
 All targets in the target group must be connected to the same subnet within a single availability zone.
 The length must be less than or equal to 50.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_lb_target_group.<resource Name> <resource Id>
terraform import yandex_lb_target_group.my_tg ...
```
