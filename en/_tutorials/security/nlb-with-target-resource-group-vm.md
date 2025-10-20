# Migrating services from an NLB with an instance group as a target to an L7 ALB


You can migrate the load from a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) load balancer to a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer. The network load balancer is integrated with a VM group. This instance group tracks the number of VMs in the group and changes the composition of the load balancer's target group as needed. An instance group can be integrated with only one of the balancers: either a network load balancer or an L7 load balancer. Therefore, to migrate you need to change the target group integration for the instance group by replacing the network load balancer's target group with the L7 load balancer's target group.

During the migration process, the L7 load balancer will have a [{{ sws-full-name }}](../../smartwebsecurity/) security profile connected to it. An L7 load balancer with a connected security profile operates as follows:

![image](../../_assets/tutorials/security/nlb-with-target-resource-group-vm.svg)

You can create a service migration infrastructure using the following tools:
