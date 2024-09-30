# Routing through a NAT instance


A _NAT instance_ is a special [VM](../../compute/concepts/vm.md) with pre-configured routing and [IP address](../../vpc/concepts/address.md) translation rules.

{{ yandex-cloud }} allows you to configure internet connections for multiple VMs via a NAT instance using [static routing](../../vpc/concepts/routing.md). In this case, only one public IP address is used: the one assigned to the NAT instance.

In this tutorial, you will create a test VM and a NAT instance using [{{ compute-full-name }}](../../compute/) and set up routing with [{{ vpc-full-name }}](../../vpc/).

You can use one of the following tools to set up routing through a NAT instance: