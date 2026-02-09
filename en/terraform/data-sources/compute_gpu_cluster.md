---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/compute_gpu_cluster.md
---

# yandex_compute_gpu_cluster (DataSource)

Get information about a Yandex Compute GPU cluster. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/gpu-cluster).

{% note warning %}

One of `gpu_cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing GPU Cluster.
//
data "yandex_compute_gpu_cluster" "my_gpu_cluster" {
  gpu_cluster_id = "some_gpu_cluster_id"
}

// You can use "data.yandex_compute_gpu_cluster.my_gpu_cluster.id" identifier 
// as reference to the existing resource.
resource "yandex_compute_instance" "default" {
  # ...

  gpu_cluster_id = data.yandex_compute_gpu_cluster.my_gpu_cluster.id

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


