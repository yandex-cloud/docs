When creating a VM, you can choose the {{ yandex-cloud }} [availability zone](../../overview/concepts/geo-scope.md) where it will be located.

To move a VM instance to a different availability zone, use a special [CLI](../../cli/cli-ref/managed-services/compute/instance/relocate.md) command or create the VM's copy in the destination availability zone and then delete the original one.