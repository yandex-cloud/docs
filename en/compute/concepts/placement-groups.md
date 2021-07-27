---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# VM placement groups

When VM instances are created, they're automatically distributed across the {{ yandex-cloud }} physical infrastructure. To control hardware fault tolerance levels, you can combine your VM instances into placement groups.

_VM placement groups_ are groups of instances, each hosted on physical hardware according to a certain strategy. {{ compute-full-name }} uses the distributed placement strategy.

_Distributed placement_ (`spread`) is a strategy for instance placement that ensures that each instance is hosted in a separate server rack in one of the availability zones. If one rack fails, the others continue to run normally.

![image](../../_assets/compute/placement-groups.svg)

By grouping VM instances based on the distributed placement strategy, you can ensure a high level of fault tolerance for your instances and reduce the risk of parallel failure of VM instances hosted in the same server rack. However, the placement requirements are more demanding, so a physical resource shortage is more likely for instances in a placement group rather than for the same number of ungrouped instances.

For more information about the organizational and technical limits of placement groups, see [{#T}](../concepts/limits.md).

## See also {#see-also}

* [How to create a placement group](../operations/placement-groups/create.md).
* [How to add a VM instance to a placement group](../operations/placement-groups/add-vm.md).
* [How to create a VM instance in a placement group](../operations/placement-groups/create-vm-in-pg.md).

