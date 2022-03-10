# VM statuses

## List of statuses {#list-of-statuses}

A VM can have one of the following statuses:

- `PROVISIONING`: {{ yandex-cloud }} is allocating resources to the VM.
- `STARTING`: the VM is being started.
- `RUNNING`: the VM has been started and is running.
- `STOPPING`: the VM is being stopped.
- `STOPPED`: the VM is stopped.
- `RESTARTING`: the VM is being restarted.
- `UPDATING`: the VM is being updated.
- `CRASHED`: the VM has crashed and will be restarted automatically.
- `ERROR`: a fatal error has occurred and the VM cannot be recovered.
- `DELETING`: the VM is being deleted.

## Operations on a VM {#operations-on-VM}

The diagram below shows only transitions between statuses under normal operation during the following actions:

- [VM creation](#create)
- [VM stop and start ](#stop-and-start)
- [VM restart](#restart)

The diagram does not show the following intermediate statuses:

- `UPDATING` ([update](#update))
- `DELETING` ([deletion](#delete))
- `CRASHED` and `ERROR` ([error occurrence](#error)).

![image](../../_assets/compute/create-and-run.svg)

### Creation {#create}

When it is [created](../operations/vm-create/create-linux-vm.md), a VM gets the `PROVISIONING` status. At this stage, the VM is allocated computing resources: the number and performance of processor cores (vCPUs) and the amount of RAM. It is assigned an IP address and its disks are created.

After that, the VM starts automatically and switches to the `STARTING` status.

If the startup is successful, the VM's status changes to `RUNNING` and the operating system starts loading. After that, you will be able to connect to the VM.

### Stop and start {#stop-and-start}

When [stopped](../operations/vm-control/vm-stop-and-start.md#stop), the VM switches to the `STOPPED` status.

At the next [start](../operations/vm-control/vm-stop-and-start.md#start), the VM undergoes the same statuses as when it was created: `PROVISIONING` → `STARTING` → `RUNNING`.

### Restart {#restart}

When being [restarted](../operations/vm-control/vm-stop-and-start.md#restart), the VM switches to the `RESTARTING` status. Since all the computing resources have been allocated, the VM returns to the `RUNNING` status after it is restarted.

### Update {#update}

You can update the parameters of a VM, such as change its name, regardless of the VM status. Once updated (the `UPDATING` status), the VM returns to the previous status.

If you update the [metadata](vm-metadata.md), it will be available from inside the VM immediately after the update. You do not need to stop or restart the VM.

### Delete {#delete}

When you [delete](../operations/vm-control/vm-delete.md) a VM, all the ongoing operations are first aborted and then the VM switches to the `DELETING` status.

When the deletion is complete, the instance disappears from the list of available resources.

## Errors {#error}

There are two error statuses:

- `CRASHED`: an error has occurred and the VM operation cannot continue.

    If the VM has switched to this status, {{ yandex-cloud }} will try to restart it. Restart attempts will be repeated until the VM status changes to `RUNNING` or `ERROR`.

- `ERROR`: a fatal error has occurred and the VM cannot be recovered.

    If the VM has switched to this status or is continuously switching to the `CRASHED` status, contact the [technical support](../../support/overview.md) or create a new VM.

