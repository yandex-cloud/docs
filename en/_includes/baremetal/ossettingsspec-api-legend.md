* `osSettingsSpec`: OS settings. To lease a server without an operating system, skip this parameter.
Possible settings:
  * `imageId`: ID of an available {{ marketplace-full-name }} public OS [image](../../baremetal/concepts/images.md#marketplace-images).
  * `storages[]`: Disk partitioning settings. This is an optional parameter. Possible settings:
    * `partitions[]`: Disk partition:
      * `type`: File system. The possible values are `EXT4`, `EXT3`, `SWAP`, or `XFS`.
      * `sizeGib`: Partition size in GB.
      * `mountPoint`: Mount point.
    * `disk`: Disk settings:
      * `id`: Disk ID.
      * `type`: Disk type. The possible values are `HDD`, `SSD`, and `NVME`.
      * `sizeGib`: Disk size in GB.
    * `raid`: RAID array settings:
      * `type`: RAID type. The possible values are `RAID0`, `RAID1`, and `RAID10`.
      * `disks[]`: Disk array in a RAID configuration. Each disk contains the following fields: `id`, `type`, and `sizeGib`.
  * `sshPublicKey`: Public SSH key contents. You will need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) your own SSH key pair to establish a secure server connection.
  * `userSshId`: SSH key user ID. This is an optional parameter.
  * `passwordPlainText`: Root user's password. This is an optional parameter.

    {% include [server-lease-access-password-warning](server-lease-access-password-warning.md) %}

  * `passwordLockboxSecret`: {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md):
    * `secretId`: Secret ID.
    * `versionId`: Secret version.
    * `key`: Secret key.
