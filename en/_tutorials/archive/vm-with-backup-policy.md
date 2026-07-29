# Associating a {{ backup-full-name }} policy with a VM automatically

You can create a {{ compute-full-name }} [virtual machine](../../compute/concepts/vm.md) with an automatically linked [backup policy](../../backup/concepts/policy.md) based on a [supported {{ backup-name }} image](../../backup/concepts/vm-connection/index.md#os). 

To do this, provide the script for installing the [{{ backup-name }}](../../backup/concepts/agent.md) agent and the ID of the required policy in the VM [metadata](../../compute/concepts/vm-metadata.md). The system automatically associates the specified policy with the VM after the VM and the {{ backup-name }} agent are up and running.

You can create an infrastructure to automatically associate backup policies with VMs using the following tools: