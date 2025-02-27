# Routing through a NAT instance


A _NAT instance_ is a [VM](../../compute/concepts/vm.md) with pre-configured routing and [IP address](../../vpc/concepts/address.md) translation rules.

{{ yandex-cloud }} allows you to connect internal VMs to the internet through a NAT instance with [static routing](../../vpc/concepts/routing.md). All internal VMs use a single public IP address of the NAT instance.

In this tutorial, you will create a test VM and a NAT one and set up routing using [{{ compute-full-name }}](../../compute/) and [{{ vpc-full-name }}](../../vpc/), respectively.

You can use one of the following tools to set up NAT routing: