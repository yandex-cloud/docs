---
title: '{{ backup-full-name }} agent'
description: The {{ backup-name }} agent interfaces the resources with {{ backup-name }} and the backup provider.
---

# {{ backup-name }} agent


Installed on [target resources](./index.md#protected-resources), the {{ backup-name }} agent enables them to interface with {{ backup-name }} and the backup provider.

Learn more about the backup provider and data sent to it in [{#T}](index.md#providers).

The {{ backup-name }} agent performs the following actions on the resource:

* Registers the resource in {{ backup-name }}.
* Reports the resource's connection status to {{ backup-name }}.
* Backs up the resource according to the [backup policy](./policy.md).
* Recovers the resource from a backup.
* Disconnects the resource from {{ backup-name }}.

{% note info %}

To perform operations in {{ backup-name }}, including deleting backups, your [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) must have at least one active resource with the {{ backup-name }} agent installed. If there are no such resources, [create](../operations/create-vm.md) a temporary new {{ compute-full-name }} VM connected to {{ backup-name }} to perform the required tasks.

{% endnote %}

Depending on the type of your target resource, you can install the {{ backup-name }} agent either automatically or manually.

You can automatically install the agent when creating a new {{ compute-name }} VM or {{ baremetal-name }} server, provided its OS image supports automatic agent installation. You can manually install the {{ backup-name }} agent on all types of target resources.

For more on installing the agent on target resources, see [{#T}](./vm-connection/index.md).

## Use cases {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)

#### Useful links {#see-also}

* [{#T}](./vm-connection/compute.md)
* [{#T}](./vm-connection/baremetal.md)
* [{#T}](./vm-connection/external-resources.md)
* [{#T}](../operations/connect-vm-linux.md)
* [{#T}](../operations/connect-vm-oslogin-linux.md)
* [{#T}](../operations/connect-vm-windows.md)
* [{#T}](../operations/refresh-connection.md)
* [{#T}](../operations/update-backup-agent.md)
* [{#T}](../operations/refresh-connection-oslogin-linux.md)
* [{#T}](../operations/backup-baremetal/backup-baremetal.md)
* [{#T}](../operations/backup-baremetal/refresh-connection.md)
* [{#T}](../operations/limit-agent-memory-usage.md)
