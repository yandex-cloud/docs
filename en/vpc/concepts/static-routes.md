# Static routing

You can use static routing to route incoming traffic to the desired subnet through VMs that act as routers.

Routing is based on route tables. The tables contain static routes that consist of the target subnet's prefix in CIDR notation and the internal IP address of the next VM ([next hop](https://en.wikipedia.org/wiki/Hop_(networking)#Next_hop)).

Route tables are linked to a subnet and cannot contain duplicate prefixes. After linking the table, all traffic sent to the destination subnet will go through the specified VM.

When creating a table, you can set an unused internal IP that is not linked to any VM as the next hop. In this case, the route will be used only after you create a VM with the appropriate IP address. 

The two main uses of static route in Yandex.Cloud:

1. Building a network route to the appropriate subnet through a single VM. The internal IP address is used as the VM ID.
1. A fail-safe routing scheme with routes in multiple availability zones.

