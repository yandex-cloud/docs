# _Not enough resources_ error

Creating a VM may fail with the `Not enough resources` error if the availability zone lacks sufficient hardware resources.

## Solution {#issue-resolution}


Here are some possible solutions to this issue:

{% cut "Select a different availability zone" %}

{% list tabs group=instructions %}

- Management console {#console}

  Select a different availability zone on the VM creation page under **{{ ui-key.yacloud.compute.instances.create.section_base }}**.

- CLI {#cli}

  Specify a different availability zone in the `--zone` parameter of the command you will use to create your VM. You can get a list of availability zones for this parameter by running `yc compute zone list`.

For more information, see [{#T}](../operations/vm-create/create-linux-vm.md) and [{#T}](../operations/vm-control/vm-update.md).

{% endlist %}

If you already have stopped VMs that are failing to start due to the error, you can [move](../operations/vm-control/vm-change-zone.md) them to a different availability zone.

{% endcut %}

{% cut "Reduce the VM computing resources" %}

Reduce the number of vCPUs, amount of RAM, disk space, and the number of GPUs connected to the VM.

{% list tabs group=instructions %}

- Management console {#console}

  Reduce resource allocation on the VM creation or update page under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**.

- CLI {#cli}

  Reduce resource allocation in the following parameters of the command you will use to create or update you VM:

  * `--cores`: Number of vCPUs.
  * `--memory`: Amount of RAM.
  * `--gpus`: Number of GPUs.

{% endlist %}

For more information, see [{#T}](../operations/vm-control/vm-update-resources.md).

{% endcut %}

{% cut "Change the VM placement policy" %}

If you have configured a [placement group](../concepts/placement-groups.md) for your VMs, the issue might be related to the limitations of the VM placement policy for the availability zone or a [host in the host group](../concepts/dedicated-host.md#bind-vm). Try less restrictive VM placement requirements.

{% endcut %}

{% cut "Change the VM type from preemptible to non-preemptible" %}

{% list tabs group=instructions %}

- Management console {#console}

  On the page for creating a new VM or updating a stopped one, disable **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**. Retry creating the VM or restart the existing VM.

- CLI {#cli}

  Set `--preemptible=false` when updating a stopped VM. If you are creating a new VM, skip the `--preemptible` parameter.

{% endlist %}

For more information, see [{#T}](../operations/vm-create/create-preemptible-vm.md#preemptible-to-regular).

In scenarios with preemptible VMs, you can also use [instance groups](../concepts/instance-groups/index.md) of one or multiple VM instances. To restart preemptible VMs, set up [auto-recovery policies](../concepts/instance-groups/autohealing.md) for the group.

{% endcut %}

## If the issue persists {#if-issue-still-persists}

If the issue persists, [create a support request]({{ link-console-support }}).

In your request, specify the following information:

1. ID of the VM instance you cannot start.
1. Issue description.
