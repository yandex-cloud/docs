# Linking a {{ backup-full-name }} policy to a VM automatically


You can create a {{ compute-full-name }} [virtual machine](../../compute/concepts/vm.md) based on a {{ backup-name }} [supported image](../../backup/concepts/vm-connection.md#os) to which a [backup policy](../../backup/concepts/policy.md) will be automatically linked. 

To do this, in the [metadata](../../compute/concepts/vm-metadata.md) of the VM, you need to provide the script to install the backup agent and the ID of the required policy. The specified policy will automatically link to the VM after the VM and agent are created, initialized, and launched.

You can create an infrastructure to automatically link backup policies to a VM by using the following tools: