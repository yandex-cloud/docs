---
subcategory: Compute Cloud
---

# yandex_compute_reserved_instance_pool (Resource)

A Reserved Instance Pool resource.

## Example usage

```terraform
//
// Create a new Compute Reserved Instance Pool
//
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-1804-lts"
}

resource "yandex_compute_reserved_instance_pool" "pool" {
  name        = "reserved-instance-pool"
  zone        = "ru-central1-a"
  platform_id = "standard-v2"

  resources_spec = {
    cores         = 4
    core_fraction = 100
    memory        = 4294967296
  }

  boot_disk_spec = {
    image_id = "${data.yandex_compute_image.ubuntu.id}"
  }

  size = 1
}
```

## Arguments & Attributes Reference

- `allow_oversubscription` (Bool). Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).
 While running instances are still limited by available slots, stopped instances can exceed this limit.
 Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error.
- `boot_disk_spec` [Block]. Spec is used to determine which License IDs should be allowed for instances created in the pool.
  - `disk_id` (String). Disk ID.
  - `image_id` (String). Image ID.
  - `product_ids` [Block]. Product IDs.
    - `product_ids` (List Of String). License IDs that indicate which licenses are attached to resource.
 License IDs are used to calculate additional charges for the use of the virtual machine.
  - `snapshot_id` (String). Snapshot ID.
- `cloud_id` (String). ID of the cloud that the pool belongs to.
- `committed_size` (*Read-Only*) (Number). Equals to the size field except when updates occur with allow_pending=true. In those cases, committed_size equals only the number of non-pending slots.
- `created_at` (*Read-Only*) (String). package: yandex.cloud.compute.v1
filename: yandex/cloud/compute/v1/reserved_instance_pool.proto

- `description` (String). Description of the pool. 0-256 characters long.
- `folder_id` (String). ID of the folder that the pool belongs to.
- `gpu_settings` [Block]. GPU settings.
  - `gpu_cluster_id` (String). Attach instance to specified GPU cluster.
- `id` (String). ID of the reserved instance pool resource to return.
 To get the reserved instance pool ID, use a [ReservedInstancePoolService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `instance_stats` [Block]. Stats for instances of the pool
  - `total` (*Read-Only*) (Number). Total number of instances linked to the pool
- `labels` (Map Of String). Resource labels as `key:value` pairs. Maximum of 64 per resource.
- `name` (String). Name of the pool. 1-63 characters long.
- `network_settings` [Block]. Network Settings.
  - `type` (String). Network Type
- `platform_id` (String). ID of the hardware platform configuration for pool instances.
- `product_ids` (*Read-Only*) (List Of String). License IDs that indicate which licenses are attached to resource.
 License IDs are used to calculate additional charges for the use of the virtual machine.
- `reserved_instance_pool_id` (String). ID of the reserved instance pool resource to return.
 To get the reserved instance pool ID, use a [ReservedInstancePoolService.List] request.
 The length must be less than or equal to 50.
 This field is required.
- `resources_spec` [Block]. Computing resources of pool instances, such as the amount of memory and number of cores.
  - `core_fraction` (Number). Baseline level of CPU performance with the ability to burst performance above that baseline level.
 This field sets baseline performance for each core.
 For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
 For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels).
 The value must satisfy: 0,5,20,50,100.
  - `cores` (Number). The number of cores available to the instance.
 The value must satisfy: 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
 This field is required.
  - `gpus` (Number). The number of GPUs available to the instance.
 The value must satisfy: 0,1,2,4.
  - `memory` (Number). The amount of memory available to the instance, specified in bytes.
 The value must be less than or equal to 274877906944.
 This field is required.
- `size` (Number). Desired size of the pool (number of slots for instances in this pool).
- `slot_stats` [Block]. Statuses of the pool slots
  - `available` (*Read-Only*) (Number). Number of slots available for instances (but not currently used)
  - `pending` (*Read-Only*) (Number). Number of slots requested for async update, but still waiting for resources and not yet available for usage
  - `total` (*Read-Only*) (Number). Equals to pool size (and equals to the sum of the following fields)
  - `unavailable` (*Read-Only*) (Number). Number of slots unavailable for some reason (for example because of underlying host failure)
  - `used` (*Read-Only*) (Number). Number of slots used by running instances
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `zone` (String). ID of the availability zone where the pool resides.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_reserved_instance_pool.<resource Name> <resource Id>
terraform import yandex_compute_reserved_instance_pool.pool fhml6**********oiheq
```
