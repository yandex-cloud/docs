### Cloud Backup or scheduled snapshots are used {#compute-disks}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | backup.compute-disks ||
|#

#### Description

This rule lists virtual machines which do not have configured back up policy.

It is important to configure back ups since it is the only practical way to restore VM's operation after a data loss or a data corruption. Without back ups, any incident leads to non-recoverable loss and operational downtime.

In cloud, there are two options to back up VMs:

* Scheduled snapshots
* Cloud Backup

#### Guides and solutions to use

[Backups](https://yandex.cloud/en/docs/compute/concepts/backups) in Compute Cloud includes snapshots of disks connected to VMs and Yandex Cloud Backup usage.

Cloud Backup is a service for creating backups and restoring Yandex Cloud resources and their data.

You can connect to Cloud Backup either a new Yandex Compute Cloud VM as soon as its is created or an existing VM with active and configured apps, resources, data, etc.

For Cloud Backup to be able to back up and restore a VM, the VM must be associated with a [backup policy](https://yandex.cloud/en/docs/backup/concepts/policy).
