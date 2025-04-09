# Migrating services from a NLB load balancer with an instance group as a target to an L7 ALB load balancer


In this tutorial, you will learn how to integrate a NLB load balancer with a group of VMs. This VM group tracks the number of VMs in the group and changes the composition of the load balancer's target group as needed. A VM group can only integrate with one of the load balancers: either a network load balancer or a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer. Therefore, when migrating, you need to change the integration with the target group for the VM group: replace the network load balancer target group with the L7 load balancer target group.

You can create a service migration infrastructure using the following tools:
