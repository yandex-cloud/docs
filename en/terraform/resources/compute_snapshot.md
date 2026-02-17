---
subcategory: Compute Cloud
---

# yandex_compute_snapshot (Resource)

Creates a new snapshot of a disk. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/snapshot).

## Example usage

```terraform
//
// Create a new Compute Snapshot.
//
resource "yandex_compute_snapshot" "default" {
  name           = "test-snapshot"
  source_disk_id = "test_disk_id"

  labels = {
    my-label = "my-label-value"
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `disk_size` (*Read-Only*) (Number). Size of the disk when the snapshot was created, specified in GB.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `source_disk_id` (**Required**)(String). ID of the disk to create a snapshot from.
- `storage_size` (*Read-Only*) (Number). Size of the snapshot, specified in GB.
- `hardware_generation` [Block]. Hardware generation and its features, which will be applied to the instance when this snapshot is used as a boot disk source. Provide this property if you wish to override this value, which otherwise is inherited from the source.
  - `generation2_features` [Block]. A newer hardware generation, which always uses `PCI_TOPOLOGY_V2` and UEFI boot.
  - `legacy_features` [Block]. Defines the first known hardware generation and its features.
    - `pci_topology` (String). A variant of PCI topology, one of `PCI_TOPOLOGY_V1` or `PCI_TOPOLOGY_V2`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_snapshot.<resource Name> <resource Id>
terraform import yandex_compute_snapshot.my_snapshot fd8hc**********o4qe2
```
