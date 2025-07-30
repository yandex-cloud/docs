`--storage`: Disk partitioning settings. This is an optional parameter. Possible settings:

* `partition`: Disk partition:
  
  * `type`: File system. The possible values are `Ext3`, `Ext4`, `Swap`, or `Xfs`.
  * `size-gib`: Partition size in GB.
  * `mount-point`: Mount point.

* `disk`: Disk:
  
  * `id`: Disk number.
  * `size-gib`: Disk size in GB.
  * `type`: Disk type.
* `raid-type`: RAID array level.