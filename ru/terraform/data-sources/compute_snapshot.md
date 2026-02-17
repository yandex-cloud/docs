---
subcategory: Compute Cloud
---

# yandex_compute_snapshot (DataSource)

Get information about a Yandex Compute snapshot. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/snapshot).

{% note warning %}

One of `snapshot_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Snapshot
//
data "yandex_compute_snapshot" "my_snapshot" {
  snapshot_id = "some_snapshot_id"
}

// You can use "data.yandex_compute_snapshot.my_snapshot.id" identifier 
// as reference to existing resource.
resource "yandex_compute_instance" "default" {
  # ...

  boot_disk {
    initialize_params {
      snapshot_id = data.yandex_compute_snapshot.my_snapshot.id
    }
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `disk_size` (*Read-Only*) (Number). Size of the disk when the snapshot was created, specified in GB.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hardware_generation` [Block]. Hardware generation and its features, which will be applied to the instance when this snapshot is used as a boot disk source. Provide this property if you wish to override this value, which otherwise is inherited from the source.
  - `generation2_features` [Block]. A newer hardware generation, which always uses `PCI_TOPOLOGY_V2` and UEFI boot.
  - `legacy_features` [Block]. Defines the first known hardware generation and its features.
    - `pci_topology` (String). A variant of PCI topology, one of `PCI_TOPOLOGY_V1` or `PCI_TOPOLOGY_V2`.
- `id` (String). 
- `kms_key_id` (*Read-Only*) (String). ID of KMS symmetric key used to encrypt snapshot.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `product_ids` (*Read-Only*) (List Of String). License IDs that indicate which licenses are attached to this snapshot.
- `snapshot_id` (String). The ID of a specific snapshot.
- `source_disk_id` (**Required**)(String). ID of the disk to create a snapshot from.
- `status` (*Read-Only*) (String). The status of the snapshot.
- `storage_size` (*Read-Only*) (Number). Size of the snapshot, specified in GB.


