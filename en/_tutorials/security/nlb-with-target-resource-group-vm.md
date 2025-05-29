# Migrating services from an NLB with an instance group as a target to an L7 ALB


In this tutorial, you will learn how to integrate a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) with an instance group. This instance group tracks the number of VMs in the group and changes the composition of the load balancer's target group as needed. An instance group can be integrated with only one of the load balancers: either a network load balancer or a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer. Therefore, when migrating, you need to change the integration with the target group for the instance group: replace the network load balancer target group with the L7 load balancer target group.

Operating diagram of an L7 load balancer with the [{{ sws-full-name }}](../../smartwebsecurity/) security profile:

![image](../../_assets/tutorials/security/nlb-with-target-resource-group-vm.svg)

You can create a service migration infrastructure using the following tools:
