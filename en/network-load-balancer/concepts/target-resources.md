# Targets and groups

A network load balancer distributes the load across cloud resources that are combined into a *target group*.

*A target* is defined by two parameters: the subnet ID and the internal IP address of the resource. Targets within one group must be located in the same cloud network. All targets must be connected to the same subnet within a single availability zone. The maximum number of resources in a target group is 254.

The targets must receive traffic on the same port as the one specified in the listener configuration.

## Attached target group {#attached-target-group}

An attached target group is a group of targets that is [attached](../operations/target-group-attach.md) to a network load balancer. You can attach a target group to a few load balancers. Note that the target group cannot be connected to the ports with the same number on different load balancers. For example, if you have a target group that connected to a load balancer on port 8080, you must attach it to a second load balancer on a port 8081. 

Once a target group is attached, the load balancer starts performing target health checks and can distribute the load across the resources in the group.

