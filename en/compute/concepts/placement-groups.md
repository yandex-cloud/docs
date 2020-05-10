# Placement groups

When VM instances are created, they're automatically distributed across the Yandex.Cloud physical infrastructure. To control hardware fault tolerance levels, VM instances can be put into placement groups.

_Placement groups_ are groups of instances, each hosted on physical hardware according to a given strategy. {{ compute-full-name }} uses the distributed placement strategy.

_Distributed placement_ (`spread`) is a strategy for instance placement that ensures that each instance is hosted in a separate server rack in one of the availability zones. If one rack fails, the others continue to run normally.

![image](../../_assets/compute/placement-groups.svg)

By grouping VM instances based on the distributed placement strategy, you can ensure a high level of fault tolerance for your instances and reduce the risk of parallel failure of virtual machines hosted in the same server rack. However, due to the strict placement requirements, a physical resource shortage is more likely for instances in a placement group as opped to the same number of instances ungrouped.

For more information about organizational and technical limits of placement groups, see [Quotas and limits](../concepts/limits.md).

## See also

* [How to create a placement group](../operations/placement-groups/create.md).
* [How to add a VM instance to a placement group](../operations/placement-groups/add-vm.md).
* [How to create a VM instance in a placement group](../operations/placement-groups/create-vm-in-pg.md).

