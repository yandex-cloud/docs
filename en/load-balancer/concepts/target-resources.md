# Targets and groups

A load balancer distributes the load across cloud resources that are combined into a *target group*. You cannot make a single cloud resource a target for multiple load balancers.

*A target* is defined by two parameters: the subnet ID and the internal IP address of the resource. Targets within one group must be located in the same cloud network. All targets must be connected to the same subnet within a single availability zone. The maximum number of resources in a target group is 254.

The targets must receive traffic on the same port as the one specified in the listener configuration.

## Attached target group {#attached-target-group}

An attached target group is a group of targets that is [attached](../operations/target-group-attach.md) to a load balancer. Only one target group can be attached to each load balancer. Once a target group is attached, the load balancer starts performing target health checks and can distribute the load across the resources in the group.

