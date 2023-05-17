{% note warning %}

This feature is only available upon agreement with your account manager.

{% endnote %}

The network acceleration is achieved by transferring network load from the VM cores to the dedicated physical server resources. This way, there is no more competition between user and network processes for the hardware resources the VM is running on, as all network traffic is processed separately. This minimizes lags and packet losses when transmitting traffic, while the VM's computing resources are released to serve your applications.

The [cost](../../compute/pricing.md#software-accelerated-network) of additional hardware resources depends on the [platform](../../compute/concepts/vm-platforms.md) and the number of VM cores.

To enable a software-accelerated network, [update the settings](../../compute/operations/vm-control/vm-update-resources.md#enable-software-accelerated-network) of the existing VM or select the **Software-accelerated network** option when [creating a new VM](../../compute/operations/vm-create/create-linux-vm.md).