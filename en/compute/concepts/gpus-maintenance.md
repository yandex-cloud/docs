---
title: GPU VM maintenance in {{ compute-full-name }}
description: This article describes some aspects of GPU VM maintenance in {{ compute-full-name }} and how you can manage maintenance of such VMs.
---

# Maintenance of GPU VMs

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

{{ compute-name }} performs occasional maintenance of the hardware required for your VMs to operate. Sometimes the GPU VMs have to restart during maintenance, in which case maintenance activities are scheduled at least three calendar days in advance.

Users will get maintenance notifications according to the [notification settings](../../console/operations/update.md#notifications).

Additionally, users can [view](../operations/vm-control/gpus-maintenance.md#list-scheduled-maintenance) a list of scheduled maintenance [tasks](#tasks) either for individual VMs or for all VMs they select in a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

{% note warning %}

For VMs with a `RESTART` [maintenance policy](./maintenance-policies.md), no explicit maintenance [tasks](#tasks) are created. Maintenance of such VMs is performed according to the rules described in [this section](./maintenance-policies.md).

{% endnote %}

## Maintenance tasks {#tasks}

During maintenance, a separate _maintenance task_ is created for each GPU VM. To view information about scheduled tasks, follow [this guide](../operations/vm-control/gpus-maintenance.md#list-scheduled-maintenance).

For each maintenance task, you can view the following details:

* Unique task [ID](../../api-design-guide/concepts/resources-identification.md).
* Name or ID of the VM the task was created for.
* Task [status](#maintenance-status).
* Task creation date and time.
* Scheduled start date and time, if the task has not yet been run.
* Actual start date and time, if the task is running or completed.
* Latest possible time for postponing the task, if it has not yet been run.
* Completion date and time, if the task has completed.

{% note info %}

Maintenance tasks are not created for [preemptible VMs](./preemptible-vm.md), and no advance notifications are sent.

{% endnote %}

### Task statuses {#maintenance-status}

GPU VM maintenance tasks can have the following statuses:

* `SCHEDULED`: VM maintenance is scheduled for a specific date and time.
* `RUNNING`: VM maintenance is underway.
* `SUCCEEDED`: Maintenance completed successfully.
* `CANCELLED`: Maintenance was canceled.

VMs are stopped and restarted at the scheduled time. However, users may [reschedule](../operations/vm-control/gpus-maintenance.md#reschedule-maintenance) maintenance tasks to an earlier or later time, or instantly [run](../operations/vm-control/gpus-maintenance.md#execute-now) pending tasks.

#### See also {#see-also}

* [{#T}](../operations/vm-control/gpus-maintenance.md)