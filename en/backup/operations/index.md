---
title: Step-by-step guides for {{ backup-full-name }}
description: This page provides a list of step-by-step guides for {{ backup-name }}.
---

# Step-by-step guides for {{ backup-name }}

## Managing VMs in {{ backup-name }} {#connect-vm}

* [Creating a Linux VM with a connection to {{ backup-name }}](create-vm.md)
* [Creating a Windows Server VM with a connection to {{ backup-name }}](create-vm-windows.md)
* [Connecting a Linux VM to {{ backup-name }}](connect-vm-linux.md)
* [Connecting a Linux VM with OS Login to {{ backup-name }}](connect-vm-oslogin-linux.md)
* [Connecting a Windows Server VM to {{ backup-name }}](connect-vm-windows.md)
* [Updating a VM connection to {{ backup-name }}](refresh-connection.md)
* [Updating a {{ backup-name }} agent on a VM](update-backup-agent.md)
* [Updating a connection of a Linux VM with OS Login to {{ backup-name }}](refresh-connection-oslogin-linux.md)
* [Deleting a VM from {{ backup-name }}](delete-vm.md)

## Managing {{ baremetal-name }} servers in {{ backup-name }} {#connect-baremetal}

* [{#T}](backup-baremetal/backup-baremetal.md)
* [{#T}](backup-baremetal/refresh-connection.md)

## Managing backup policies {#policy-vm}

* [Creating a backup policy](./policy-vm/create.md)
* [Updating a backup policy](./policy-vm/update.md)
* [Linking a VM to a backup policy](./policy-vm/attach-and-detach-vm.md)
* [Getting information about a backup policy](./policy-vm/get-info.md)
* [Unlinking a VM from a backup policy](./policy-vm/detach-vm.md)
* [Deleting a backup policy](./policy-vm/delete.md)

## Managing backups {#backup-vm}

* [Creating a VM backup](./backup-vm/create.md)
* [Restoring a VM from a backup](./backup-vm/recover.md)
* [Restoring a VM from a backup of another VM](./backup-vm/non-native-recovery.md)
* [Restoring individual directories and files on a VM](./backup-vm/recover-file-by-file.md)
* [Viewing the parameters of disks and partitions in a backup](./backup-vm/view-disk-layout.md)
* [Deleting a backup](./backup-vm/delete.md)

## Service operations {#service-operations}

* [Activating the service](activate-service.md)
* [Viewing operations with the service's resources](operation-logs.md)
* [Viewing backup statistics](get-stats.md)
