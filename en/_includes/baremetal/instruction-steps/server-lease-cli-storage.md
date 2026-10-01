`storages` : [Disk](../../../baremetal/concepts/disks/disk-types.md) partitioning settings in the `--os-settings-spec` parameter. This is an optional setting. The possible values are:

* `partitions`: Disk partitions:
  
  * `type`: File system. The possible values are `EXT3`, `EXT4`, `SWAP`, or `XFS`.
  * `size-gib`: Partition size in GB.
  * `mount-point`: Mount point.

* `storage-type`: Storage type:

  * `disk`: Individual disk:

    * `id`: Disk number.
    * `size-gib`: Disk size in GB.
    * `type`: Disk type.
  * `raid`: RAID array:

    * `type`: [RAID array level](../../../baremetal/concepts/disks/raid.md#levels).
    * `disks`: List of RAID array disks.
