* Policy with `max_unavailable > 0` and `max_expansion = 0`.

  This policy prohibits expanding the node group in the course of the operation (`max_expansion = 0`).

  Modifying or updating the node group will be performed by sequentially executing the operation for `max_unavailable` nodes at a time, until the operation is completed for all nodes in the group. As the selected nodes will become unavailable during the operation, before it executes it, the cluster will try to migrate the workload from these nodes to the remaining ones in the group.

  {% note warning %}

  If the workload cannot be migrated to the remaining nodes due to insufficient computing resources on those nodes, the operation will be forcibly performed for the selected nodes. 

  This may lead to complete or partial unavailability of your applications in the cluster until the operation is fully completed for the whole node group.

  {% endnote %}

  {% cut "Example" %}

  > You have a node group set up as follows:
  > * Scaling type: Fixed.
  > * Number of nodes: 5.
  > * `max_expansion`: 0.
  > * `max_unavailable`: 2.
  > 
  > If you modify the node group in this configuration:
  > 1. The workload from two nodes will be migrated to the remaining three nodes.
  > 1. The two nodes without workload will enter the `Reconciling` status, get updated, rebooted, and then return to the `Running` status.
  > 1. The workload from the next un-updated nodes will be migrated to the two updated nodes and one un-updated node.
  > 1. The two un-updated nodes without workload will enter the `Reconciling` status, get updated, rebooted, and then return to the `Running` status.
  > 1. The workload from the last un-updated node will be migrated to the four updated ones.
  > 1. The last un-updated node without workload will enter the `Reconciling` status, get updated, rebooted, and then return to the `Running` status.

  {% endcut %}

* Policy with `max_expansion > 0` and `max_unavailable = 0`.

  This policy makes sure you have no unavailable nodes during the update process (`max_unavailable = 0`).

  Modifying or updating the node group will be performed by sequentially expanding the node group by `max_expansion` new nodes at a time. These new nodes will get the modified configuration or updated {{ k8s }} version right away. Next, the new nodes will take the workload from the existing outdated ones, which will then be deleted. This process will continue until all nodes with the outdated configuration are replaced with new ones. The migration of workload from nodes consumes the computing resources of these nodes in the process.

  If you use a deployment policy like that, make sure your cloud has enough resources to expand the group before modifying it. [Increase quotas](../../../managed-kubernetes/concepts/limits.md) if needed.

  {% note warning %}

  The operation for the node group may slow down or stop entirely if there are not enough resources for the expansion.

  When expanding your node group, you pay for the nodes you create. For more information, see [{#T}](../../../managed-kubernetes/pricing.md).

  {% endnote %}

  {% cut "Example" %}

  > You have a node group set up as follows:
  > * Scaling type: Fixed.
  > * Number of nodes: 5.
  > * `max_expansion`: 2.
  > * `max_unavailable`: 0.
  > 
  > If you modify the node group in this configuration:
  > 1. Two new nodes with the updated configuration will be created.
  > 1. After the new nodes enter the `Running` status, the workload from the two un-updated nodes will be migrated to the new ones, and the two nodes without workload will be deleted.
  > 1. Two more new nodes with the updated configuration will be created.
  > 1. After the new nodes enter the `Running` status, the workload from the two un-updated nodes will be migrated to the new ones, and the two nodes without workload will be deleted.
  > 1. One more new node with the updated configuration will be created.
  > 1. After the new node enters the `Running` status, the workload from the last un-updated node will be migrated to the new one, and the node without workload will be deleted.

  {% endcut %}

* Policy with `max_expansion > 0` and `max_unavailable > 0`.

  This policy is a combination of the policies described above.

  Modifying or updating the node group will be performed by sequentially executing the operation for `max_unavailable` nodes at a time, until the operation is completed for all nodes in the group. As the selected nodes will become unavailable during the operation, before it executes it, the cluster will try to migrate the workload from these nodes to the remaining ones in the group. The migration of workload from nodes consumes the computing resources of these nodes in the process.

  The node group will be expanded by `max_expansion` nodes to be able to handle the workload from the nodes that are being updated. The group's expansion and the operation for the nodes take place simultaneously.

  When using this policy, you should monitor both the available computing resources of the nodes and the quotas and resources of your cloud.

  {% cut "Example" %}

  > You have a node group set up as follows:
  > * Scaling type: Fixed.
  > * Number of nodes: 5.
  > * `max_expansion`: 2.
  > * `max_unavailable`: 2.
  > 
  > If you modify the node group in this configuration:
  > 1. Two new nodes with the updated configuration will start to be created. At the same time, the workload from the two un-updated nodes will start to be migrated to the remaining three un-updated nodes.
  > 1. The new nodes will enter the `Running` status and start getting workload from the migrated nodes.
  > 1. The two nodes without workload will enter the `Reconciling` status, get updated, rebooted, and then return to the `Running` status.
  > 1. The workload from the two un-updated nodes will be migrated to the four updated nodes and one un-updated node.
  > 1. One node without workload will enter the `Reconciling` status, get updated, rebooted, and then return to the `Running` status. The other one will be deleted.
  > 1. The workload from the remaining un-updated node will be migrated to the five updated nodes. With that done, this node will be deleted.
  >
  > The behavior may slightly differ from the description depending on which comes first: pod migration from the un-updated node or the new/rebooted nodes getting the `Running` status; however, ultimately, the group will enter the required state.

  {% endcut %}
