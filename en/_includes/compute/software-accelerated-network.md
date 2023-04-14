Software acceleration transfers network load from instance cores to dedicated physical server resources. This eliminates the competition between user and network processes for the hardware resources that the VM is running on because all network traffic is processed separately. As a result, lag and packet loss when transmitting traffic are minimized and your VM's computing resources are released to serve your applications.

[The cost](../../compute/pricing.md#software-accelerated-network) of additional hardware resources depends on the [platform](../../compute/concepts/vm-platforms.md) and the number of VM cores.

To enable a software-accelerated network, [update the settings](../../compute/operations/vm-control/vm-update-resources.md#enable-software-accelerated-network) of the existing VM or select the **Software-accelerated network** option when [creating a new VM](../../compute/operations/vm-create/create-linux-vm.md).
