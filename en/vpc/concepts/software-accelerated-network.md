# Software-accelerated network in {{ vpc-name }}

If your application generates an extreme load to the VM cores and, at the same time, requires large amounts of network traffic, the user and network processes may start competing for hardware resources. To avoid this, we recommend using a software-accelerated network in {{ vpc-short-name }}.

{% include [software-accelerated-network](../../_includes/compute/software-accelerated-network.md) %}