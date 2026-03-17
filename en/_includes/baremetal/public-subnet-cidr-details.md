If DHCP is disabled in an ephemeral public subnet or on the server's [network interface](../../baremetal/concepts/servers.md#network-interfaces) connected to such a subnet, and obtaining an address via DHCP is disabled, consider the following when configuring that interface:

* The subnet the server's public IP address is in has a subnet prefix length of `31` bits and consists of these two addresses: the default gateway IP address and the host IP address.
* The gateway IP address is specified under **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}** in the **{{ ui-key.yacloud.baremetal.title_section-server-public-network_p7Zhj }}** section on the server information page.
* The host IP address is greater than the gateway IP address by one.

{% include [public-subnet-cidr-31-example](./public-subnet-cidr-31-example.md) %}