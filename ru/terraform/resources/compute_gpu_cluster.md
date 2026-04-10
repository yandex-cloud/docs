---
subcategory: Compute Cloud
---

# yandex_compute_gpu_cluster (Resource)

A GPU cluster. For details about the concept, see [documentation](/docs/compute/concepts/gpus#gpu-clusters).

## Example usage

```terraform
//
// Create a new GPU Cluster.
//
resource "yandex_compute_gpu_cluster" "default" {
  name              = "gpu-cluster-name"
  interconnect_type = "INFINIBAND"
  zone              = "ru-central1-a"

  labels = {
    environment = "test"
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `gpu_cluster_id` (String). ID of the GPU cluster.
- `id` (String). 
- `interconnect_type` (*Read-Only*) (String). Type of interconnect between nodes to use in GPU cluster. Type `INFINIBAND` is set by default, and it is the only one available at the moment.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `status` (*Read-Only*) (String). The status of the GPU cluster.
- `zone` (*Read-Only*) (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_gpu_cluster.<resource Name> <resource Id>
terraform import yandex_compute_gpu_cluster.my_gpu_cluster fv4h4**********u4dpa
```
