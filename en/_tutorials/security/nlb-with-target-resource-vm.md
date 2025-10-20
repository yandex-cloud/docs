# Migrating services from an NLB with VMs as targets to an L7 ALB


You can migrate the load from a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) load balancer to a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer. In a network load balancer, incoming traffic is distributed among the VMs specified in this load balancer's target groups.

During the migration process, the L7 load balancer will have a [{{ sws-full-name }}](../../smartwebsecurity/) security profile connected to it. An L7 load balancer with a connected security profile operates as follows:

![image](../../_assets/tutorials/security/nlb-with-target-resource-vm.svg)

You can create a service migration infrastructure using the following tools:
