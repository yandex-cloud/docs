# Associating a {{ backup-full-name }} policy to a VM automatically


You can use a [supported {{ backup-name }} image](../../backup/concepts/vm-connection.md#os) to create a {{ compute-full-name }} [VM](../../compute/concepts/vm.md) that will have a [backup policy](../../backup/concepts/policy.md) associated automatically. 

To do this, provide the script for installing the [{{ backup-name }}](../../backup/concepts/agent.md) agent and the ID of the required policy in the VM [metadata](../../compute/concepts/vm-metadata.md). The system automatically associates the specified policy with the VM after the VM and the {{ backup-name }} agent are up and running.

You can create an infrastructure to automatically associate backup policies with VMs using the following tools: