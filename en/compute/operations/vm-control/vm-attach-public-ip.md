# Assigning a public IP address to a VM

If you created a [VM](../../concepts/vm.md) without a [public IP address](../../../vpc/concepts/address.md#public-addresses), you can assign it the IP address [you reserved](../../../vpc/operations/get-static-ip.md) in [{{ vpc-full-name }}](../../../vpc/) or the one automatically selected by {{ compute-name }} from among available IP addresses. The reserved IP address and the VM must be in the same [availability zone](../../../overview/concepts/geo-scope.md).

If a VM has multiple [network interfaces](../../concepts/network.md), you can assign a public IP address to each one.

{% include [vm-attach-public-ip](../../../_includes/compute/vm-attach-public-ip.md) %}
