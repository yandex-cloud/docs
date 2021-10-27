# Target groups

An L7 load balancer target group is a set of IP addresses of VMs that your network applications are running on. To enable the load balancer to distribute routing requests between the VMs of the target group, specify it in the [backend group](backend-group.md) configuration.

You can create target groups [manually](../operations/target-group-create.md) or create a VM target group for the L7 load balancer in {{ ig-name }}. When you change the VM configuration, {{ ig-name }} automatically updates IP addresses of VMs in the target group. If the target group is connected to a backend group, {{ ig-name }} also monitors health check results delivered by the L7 load balancer.

