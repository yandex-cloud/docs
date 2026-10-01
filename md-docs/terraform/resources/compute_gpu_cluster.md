[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Compute Cloud > Resources > compute_gpu_cluster

# yandex_compute_gpu_cluster (Resource)

A GPU cluster. For details about the concept, see [documentation](../../compute/concepts/gpus.md#gpu-clusters).

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

- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the GPU cluster.
- `folder_id` (String). ID of the folder that the GPU cluster belongs to.
- `gpu_cluster_id` (String). ID of the GPU cluster to return.
 To get a GPU cluster ID, make a [GpuClusterService.List] request.
- `id` (String). ID of the GPU cluster to return.
 To get a GPU cluster ID, make a [GpuClusterService.List] request.
- `interconnect_type` (String). Type of interconnect used for this GPU cluster.
- `labels` (Map Of String). GPU cluster labels as `key:value` pairs.
- `name` (String). Name of the GPU cluster.
 The name is unique within the folder.
- `status` (*Read-Only*) (String). Status of the GPU cluster.
- `subnets` (Number). Number of subnets in the GPU cluster.
- `zone` (String). ID of the availability zone where the GPU cluster resides.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_compute_gpu_cluster.<resource Name> <resource Id>
terraform import yandex_compute_gpu_cluster.my_gpu_cluster fv4h4**********u4dpa
```