---
title: '{{ backup-full-name }} overview'
description: '{{ backup-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data.'
---

# {{ backup-full-name }} overview


{{ backup-full-name }} is a service for creating backups and restoring [resources](#protected-resources) and their data. 

## Resources {#protected-resources}

With {{ backup-name }}, you can create backups for the following types of resources:

* [{{ compute-full-name }} VM instances](../../compute/concepts/vm.md).
* [{{ baremetal-full-name }} servers](../../baremetal/concepts/servers.md).
* VMs and servers in the third-party provider infrastructure.
* VMs and servers in the user on-premise infrastructure.

{% note info %}

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% endnote %}

## Resource backups {#backup-copies}

Resource backups are `application-consistent`: they save not only the data on disks but also the data already submitted but not yet fully written to the disk. This allows you to resume applications that were running at the time of the backup directly after recovering a resource from the backup. This is important for VMs and servers forming a part of data storage systems, such as when a DBMS is running on the resource.

{{ backup-name }} can create [full and incremental backups](backup.md#types). A _full backup_ stores the whole resource data: the recovery is faster than from an incremental backup, yet such backups take up more storage space and take longer to create. An _incremental backup_ only stores data that is different from the previous backup. It is faster to create and takes up less space. However, recovery from an incremental backup takes longer than from a full one. If you know your resource has changed a lot since the previous backup, it is better to take a full backup.

{% include [av-note](../../_includes/backup/av-note.md) %}

With {{ backup-name }}, you can also restore individual files and directories from a backup to any {{ compute-name }} VM or {{ baremetal-name }} server connected to the service. For more information, see [File-by-file recovery](backup.md#file-by-file). File-by-file recovery to [resources](#protected-resources) residing in your on-premise or third-party infrastructure is currently not available.

To enable backups for a resource, you first need to have it connected and configured. For more information, see [{#T}](./vm-connection/index.md).

{% include [vm-running](../../_includes/backup/vm-running.md) %}

Once you have connected your resource to {{ backup-name }} and configured it, you also need to link the resource to a [backup policy](policy.md), i.e., a {{ backup-name }} resource. The policy includes settings for creating and storing backups. You can link your resources to default policies or create custom policies.

{{ backup-name }} automatically supplies the [metrics](../metrics.md) on the number of backed up resources and storage space used for backups to [{{ monitoring-full-name }}](../../monitoring/index.yaml).

The service has two types of restrictions: [quotas and limits](limits.md).

## Comparison with VM disk snapshots in {{ compute-name }} {#snapshot-comparison}

{% include [backup-image-snapshot-comparison](../../_includes/backup-image-snapshot-comparison.md) %}

## Service activation and backup provider {#providers}

{{ backup-name }} is enabled by a _backup provider_. Currently, the service only has one provider available: Cyberprotect.

For correct operation, the [{{ backup-name }} agent](agent.md) installed on a [resource](#protected-resources) sends the following service metadata on the resource configuration to the provider's servers:

* VM or server name.
* OS name and version.
* OS kernel version.
* VM or server internal IP address.
* MAC address of each server network adapter or VM network interface.
* Amount of RAM.
* CPU model and frequency.
* CPU type, physical or virtual.
* Type of virtualization: hardware or software VM virtualization.
* Names of mount points and [disks](../../compute/concepts/disk.md) connected to the VM or server.

{% note warning %}

The data stored on the user's {{ compute-name }} VMs or {{ baremetal-name }} servers, same as its backups, never leave {{ yandex-cloud }}.

{% endnote %}

To get started, you need to activate the service, i.e., to connect to a backup provider. You can [activate](../operations/activate-service.md) the service directly or [connect](./vm-connection/index.md) your first resource to {{ backup-name }}, which activates the service automatically.

{% include [activate-provider-roles](../../_includes/backup/activate-provider-roles.md) %}

{% include [default-policies](../../_includes/backup/default-policies.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)
