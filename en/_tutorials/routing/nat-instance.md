# Routing through a NAT instance


A _NAT instance_ is a [VM](../../compute/concepts/vm.md) with pre-configured routing and [IP address](../../vpc/concepts/address.md) translation rules. Technically, it is a regular Ubuntu VM with pre-installed `iptables`, fully user-configurable. The only difference between a NAT instance and a standard VM is that the former has IP routing pre-enabled and supports connecting multiple network interfaces.

NAT instance images are available on {{ marketplace-name }}:

* [NAT instance powered by Ubuntu 22.04 LTS](/marketplace/products/yc/nat-instance-ubuntu-22-04-lts)
* [NAT instance powered by Ubuntu 18.04 LTS](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts)

{{ yandex-cloud }} allows you to connect internal VMs to the internet through a NAT instance with [static routing](../../vpc/concepts/routing.md). All internal VMs use a single public IP address of the NAT instance.

In this tutorial, you will create a test VM and a NAT one and set up routing using [{{ compute-full-name }}](../../compute/) and [{{ vpc-full-name }}](../../vpc/), respectively.

You can use one of the following tools to set up NAT routing:
