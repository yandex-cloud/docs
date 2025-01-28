---
title: VM statuses in {{ compute-full-name }}
description: In this tutorial, you will learn about the VM statuses in {{ compute-name }}.
---

# VM statuses

## List of statuses {#list-of-statuses}

A VM can have one of the following statuses:

- `PROVISIONING`: {{ yandex-cloud }} is allocating resources to the VM.
- `STARTING`: VM is starting.
- `RUNNING`: VM is running.
- `STOPPING`: VM is stopping.
- `STOPPED`: VM is stopped.
- `RESTARTING`: VM is restarting.
- `UPDATING`: VM is being updated.
- `CRASHED`: VM crashed and will be restarted automatically.
- `ERROR`: Fatal error; the VM cannot be recovered.
- `DELETING`: VM is being deleted.

## Operations on a VM {#operations-on-VM}

The diagram below shows only switching statuses under normal operation during the following actions:

- [Creating](#create) a VM.
- [Stopping and starting](#stop-and-start) a VM.
- [Restarting](#restart) a VM.

The diagram does not show the following intermediate statuses:

- `UPDATING` for [updating](#update).
- `DELETING` for [deleting](#delete).
- `CRASHED` and `ERROR` for [error situations](#error).

![image](../../_assets/compute/create-and-run.svg)

### Creating {#create}

A newly [created](../operations/vm-create/create-linux-vm.md) VM gets the `PROVISIONING` status. This is when computing resources are allocated to the VM: the number and capacity of vCPUs, the amount of RAM. It also gets an IP address, and its disks are created.

With that done, the VM automatically starts and enters the `STARTING` status.

Once successfully started, it will get the `RUNNING` status, and the operating system will start booting up. After that you will be able to connect to the VM.

### Stopping and starting {#stop-and-start}

^6^ When a VM [stops](../operations/vm-control/vm-stop-and-start.md#stop), the hypervisor sends a shutdown signal to the VM operating system. The OS has 30 seconds to gracefully terminate all running processes to avoid data loss. When this time expires, the VM's process is forced to stop, and the VM enters the `STOPPED` status.

At the next [start](../operations/vm-control/vm-stop-and-start.md#start), the VM will go through the same statuses as when it was created: `PROVISIONING` → `STARTING` → `RUNNING`.

### Restarting {#restart}

When [restarting](../operations/vm-control/vm-stop-and-start.md#restart), the VM gets the `RESTARTING` status. All its computing resources being already allocated, following the restart, the VM will go back to the `RUNNING` status.

### Updating {#update}

You can update the VM parameters, such as change its name, regardless of the VM status. Following an update (the `UPDATING` status), the VM will go back to its previous status.

If you update the [metadata](vm-metadata.md), it will be available from inside the VM immediately after the update. You do not need to stop or restart the VM in this case.

### Deleting {#delete}

When you [delete](../operations/vm-control/vm-delete.md) a VM, first all ongoing operations are canceled and stopped, then the VM enters the `DELETING` status.

When the deletion is complete, the VM disappears from the list of available resources.

## Errors {#error}

There are two error statuses:

- `CRASHED`: Error; the VM cannot continue to operate.

    If the VM has entered this status, {{ yandex-cloud }} will try to restart it. Restart attempts will be repeated until the VM's status changes to `RUNNING` or `ERROR`.

- `ERROR`: Fatal error; the VM cannot be recovered.

    To fix the error, try [stopping](../operations/vm-control/vm-stop-and-start.md#stop) and re-[starting](../operations/vm-control/vm-stop-and-start.md#start) the VM.

    If the `ERROR` status persists or the VM keeps getting the `CRASHED` status, contact [support](../../support/overview.md) or create a new VM.

