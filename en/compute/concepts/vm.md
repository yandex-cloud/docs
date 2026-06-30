---
title: A VM is similar to a server
description: A VM is similar to a server in the cloud infrastructure. A VM is created in one of the folders and inherits its access permissions. When creating a VM, you can choose the availability zone where it will be located.
---

# VMs in {{ compute-name }}

A _virtual machine_ is similar to a server in cloud infrastructures.

## VMs as a {{ yandex-cloud }} resource {#project}

A VM is created in one of the [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) within your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and inherits its access permissions. You can read more about the {{ yandex-cloud }} resource hierarchy [here](../../resource-manager/concepts/resources-hierarchy.md).

Each VM has a unique ID and name. The name is unique within the folder. The naming requirements are as follows:

{% include [name-format](../../_includes/name-format.md) %}

{% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

The ID is generated automatically when the VM is being created and is unique within {{ yandex-cloud }}.

You can move a VM to another folder within a single cloud.

## Availability zone {#az}


{% include [instance-az](../_includes_service/instance-az.md) %}

## Service account {#sa}

To make it easier to [authenticate in {{ yandex-cloud }} from within a VM](../operations/vm-connect/auth-inside-vm.md), associate a [service account](../../iam/concepts/users/service-accounts.md) with that VM.

All cloud resource operations performed from within the VM, whether via the [CLI](../../cli/quickstart.md), [{{ TF }}](../../terraform/quickstart.md), or [API](../../api-design-guide/concepts/general.md), will use the service account.

Authentication uses a secure, short-lived [IAM token](../../iam/concepts/authorization/iam-token.md). You do not need to keep sensitive authentication data on the VM.

The service account can access cloud resources only within the scope of its [roles](../../iam/concepts/access-control/roles.md). [Assign](../../iam/operations/sa/assign-role-for-sa.md) your service account a specific role for the resource you want to access. You can [revoke](../../iam/operations/roles/revoke.md) the role at any time.

The VM also uses the service account to send custom metrics to [{{ monitoring-full-name }}](../../monitoring/quickstart.md), deliver logs to [{{ cloud-logging-full-name }}](../../logging/quickstart.md), and connect to [{{ backup-full-name }}](../../backup/quickstart/existing-vm.md).

You can only associate a single service account with the VM. To remove or replace the associated service account, [update](../operations/vm-control/vm-update.md) the VM settings accordingly.

## Computing resources {#types}

When creating a VM, you need to specify the amount of computing resources to allocate to it, including the number and performance of vCPUs and the amount of RAM. You can choose the computing resources that are appropriate for the expected load. For more information, see [{#T}](performance-levels.md).

You can create a [reserved instance pool](./reserved-pools.md) to reserve computing resources for as many VMs as you need in a particular availability zone.

## Hardware generations {#hardware-generations}

The virtualized hardware a {{ compute-name }} VM is deployed on and its OS has access to can belong to different [generations](./hardware-generations.md).

The VM will run on virtualized hardware of the generation assigned to the [disk](./disk.md), [snapshot](./snapshot.md), or [image](./image.md) the VM was created based on.

Once a VM has been created, its hardware generation cannot be changed. Instead, you can create a [snapshot](../operations/disk-control/create-snapshot.md#create) or [image](../operations/image-create/create-from-disk.md) from the boot disk of your existing VM with preferred hardware generation assigned and then proceed to create a new VM from the resulting snapshot or image.

## Disks {#disks}

A VM must have at least one disk attached, which is a boot disk. Currently, you can only attach a boot disk when creating a VM.

You can also attach additional disks to your VM. You can either attach a previously created disk or create one with a new VM. You can create an empty disk or restore it from a [snapshot](../concepts/snapshot.md) or an [image](../concepts/image.md).

{% include [attach_empty_disk](../_includes_service/attach-empty-disk.md) %}

You can attach and detach additional disks even after you created the VM.

Read more about disks in [{#T}](disk.md).

## Statuses {#status}

The status of a VM determines which operations you can currently perform on it.

> For example, the `STOPPED` status means the VM is stopped and you cannot connect to it. To connect to such a VM, you must [start](../operations/vm-control/vm-stop-and-start.md#start) it first. After the status switches to `RUNNING` and the OS boots, you will be able to connect to the VM.

For more information about statuses, see [{#T}](vm-statuses.md).

## Metadata {#metadata}

You can specify your own metadata when creating or updating VMs. For example, to connect to a Linux VM, you need to provide an SSH key to it. which can be done using the metadata service. For more information, see [{#T}](vm-metadata.md).

## Network {#network}

When creating a VM, you need to specify its network interface settings by selecting the [subnet](../../vpc/concepts/network.md#subnet) to connect the VM to, configuring an [internal and public IP address](../../vpc/concepts/address.md), and adding the required [security groups](../../vpc/concepts/security-groups.md). This will allow the VM to work with other services on the intranet and internet.

For more information, see [{#T}](network.md).

## Use cases {#examples}

* [{#T}](../tutorials/vm-scale-scheduled/index.md)
* [{#T}](../tutorials/gre-over-ipsec.md)
* [{#T}](../tutorials/ntp.md)
* [{#T}](../tutorials/vm-fluent-bit-logging.md)
* [{#T}](../tutorials/bind-domain-vm/index.md)

#### See also {#see-also}

* [How to select the right VM type in {{ yandex-cloud }}](https://yandex.cloud/ru/blog/posts/2025/03/vm-type-selection)