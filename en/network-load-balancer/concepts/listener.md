# Traffic listener

*Traffic listener* is a component distributed across all [availability zones](../../overview/concepts/geo-scope.md). It accepts incoming traffic on the load balancer and distributes it to all operating resources in the target groups connected to the load balancer.

You can create multiple traffic listeners for each load balancer.

All traffic listeners on a load balancer always use a single IP address. You cannot use multiple IP addresses on a load balancer.

Here are the required attributes of each traffic listener:
* `Name` is used to identify the listener and connect it to other components of the load balancer.
* `IP address`: IPv4 address for the load balancer to receive incoming traffic. IPv6 protocol is currently not supported. The listener IP address will be announced as a `/32` prefix from all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).
   Hence, if an availability zone fails, the network equipment will redirect incoming traffic to the listener IP address to other active availability zones.

   {% note info %}

   The listener IP address can be assigned to:
   * An external load balancer, automatically from a pool of public addresses or from a list of [reserved IP addresses](../../vpc/operations/get-static-ip.md).
   * An internal load balancer, automatically from a pool of addresses. You cannot reserve an internal IP address from the {{ vpc-short-name }} address space for a traffic listener.

   {% endnote %}

* `Protocol`: Type of transport protocol whose traffic the listener will accept. Currently, TCP and UDP protocols are supported ([UDP protocol support is limited](#nlb-udp)). You can only select one transport protocol per listener.
* `Port`: Port for the selected transport protocol where the listener will accept incoming traffic. Ports ranging from 1 to 32767 can be used for receiving traffic.
* `Target port`: Port where the resources in the target group will accept traffic. This port may be the same as in the `Port` attribute. After creating a listener, this port will deny connections from resources within {{ vpc-short-name }} on the VMs of the target group. VMs in the target group will only accept traffic from the load balancer's traffic listener.

{% note warning %}

If you need to use multiple listeners per load balancer, remember that the ports where your listeners will accept traffic should not overlap. Two listeners residing on the same load balancer cannot accept traffic on the same port.

{% endnote %}

For more granular traffic listening, instead of creating multiple listeners per load balancer, we recommend creating a separate load balancer for each service.
