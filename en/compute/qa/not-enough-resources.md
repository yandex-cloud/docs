# "Not enough resources" error

If there are insufficient hardware resources in an availability zone, creating a VM may fail with the `Not enough resources` error.

## Solution {#issue-resolution}

The possible ways to solve this issue include:

{% cut "Select a different availability zone" %}

{% list tabs group=instructions %}

- Management console {#console}

   Select another availability zone on the VM creation page under **{{ ui-key.yacloud.compute.instances.create.section_base }}**.

- CLI {#cli}

   Specify a different availability zone in the `--zone` parameter of the VM create command. You can get the list of availability zones for this parameter by running the `yc compute zone list` command.

For more information, see [{#T}](../operations/vm-create/create-linux-vm.md) and [{#T}](../operations/vm-control/vm-update.md).

{% endlist %}

If you already have stopped VMs that fail to start due to the error, you can [move](../operations/vm-control/vm-change-zone.md) them to a different availability zone.

{% endcut %}

{% cut "Reduce the amount of VM computing resources" %}

Reduce the number of cores, the amount of RAM, disk space, and the number of GPUs connected to the VM.

{% list tabs group=instructions %}

- Management console {#console}

   Reduce the amount of employed resources on the VM creation or update page under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**.

- CLI {#cli}

   Reduce the amount of resources in the following parameters of the VM create or update command:

   * `--cores`: Number of cores (vCPUs)
   * `--memory`: Amount of RAM
   * `--gpus`: Number of GPUs

{% endlist %}

For more information, see [{#T}](../operations/vm-control/vm-update-resources.md).

{% endcut %}

{% cut "Change the VM placement policy" %}

If you have a [placement group](../concepts/placement-groups.md) set up for your VM, the issue might be related to the limitations of the VM placement policy in the availability zone or a [host from the host group](../concepts/dedicated-host.md#bind-vm). Try softening your VM placement requirements.

{% endcut %}

{% cut "Change the VM type from preemptible to non-preemptible" %}

{% list tabs group=instructions %}

- Management console {#console}

   On the page for creating a new VM or updating a stopped one, disable the **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}** option. Retry to create a new VM or restart an existing one.

- CLI {#cli}

   Provide the `--preemptible=false` parameter when updating a stopped VM. If creating a new VM, do not specify the `--preemptible` parameter.

{% endlist %}

For more information, see [{#T}](../operations/vm-create/create-preemptible-vm.md#preemptible-to-regular).

In scenarios with preemptible VMs, you can also use [instance groups](../concepts/instance-groups/index.md) of one or more VM instances. To restart preemptible VMs, set up [auto-recovery policies](../concepts/instance-groups/autohealing.md) for their groups.

{% endcut %}

## If the issue persists {#if-issue-still-persists}

If the issue persists, [create a request for technical support]({{ link-console-support }}).

In the request, specify the following information:

1. ID of the VM instance you cannot launch.
1. Problem description.
