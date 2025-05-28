# Linking a {{ backup-full-name }} policy to a VM automatically


You can create a {{ compute-full-name }} [virtual machine](../../compute/concepts/vm.md) with an automatically linked [backup policy](../../backup/concepts/policy.md) based on a [supported {{ backup-name }} image](../../backup/concepts/vm-connection.md#os). 

To do this, you need to provide the [{{ backup-name }}](../../backup/concepts/agent.md) agent installation script and the policy ID in the VM [metadata](../../compute/concepts/vm-metadata.md). The specified policy will be automatically linked to the VM after the VM and the {{ backup-name }} agent are created, initialized, and launched.

You can create an infrastructure to automatically link backup policies to VMs using the following tools: