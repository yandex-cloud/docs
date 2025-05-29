# Migrating services from an NLB with VMs as targets to an L7 ALB


In this use case, a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) incoming traffic is distributed among VMs located in target groups downstream of the load balancer.

Operating diagram of a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer with a [{{ sws-full-name }}](../../smartwebsecurity/) security profile:

![image](../../_assets/tutorials/security/nlb-with-target-resource-vm.svg)

You can create a service migration infrastructure using the following tools:
