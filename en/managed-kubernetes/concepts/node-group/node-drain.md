# Evicting pods from nodes

When you update a node group, pods are evicted from the old node and migrated to the new one. To make sure eviction does not affect the availability of the services provided by your applications in the {{ k8s }} cluster, configure the {{ k8s }} API [PodDisruptionBudget](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/pod-disruption-budget-v1/) object for the pods of your application.

The `PodDisruptionBudget` object is defined by these three fields:
* `.spec.selector`: Selector {{ k8s }} label that marks the set of pods this selector applies to. This is a required field.
* `.spec.minAvailable`: Minimum number of pods from the set to be available after eviction. You can specify it as a percentage value.
* `.spec.maxUnavailable`: Maximum number of pods from the set that may become not available after eviction. You can specify it as a percentage value.

If you do not define the [PodDisruptionBudget policy](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/), all pods will be evicted at once, which may disrupt your application.

{% note warning %}

* Pod can only be evicted if they were created by an application replication controller: [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). If a pod is created without a controller, it will be lost during the update.
* [Persistent volumes](../volume.md) (`PersistentVolumes`) used by the pods managed by the `StatefulSet` controller, can only be moved between nodes within a single availability zone.

{% endnote %}

Specifics for evicting pods from nodes:
* Configure the `PodDisruptionBudgets` policy to prohibit eviction of too many pods at once, but allow eviction of at least one pod.
* Pod eviction is subject to the node stop timeout (7 minutes). The node will be stopped even if not all pods are evicted over this time period.
* When you scale down a node group to evict pods and then delete the node, the nodes without pods are drained and deleted first. If a group has a fixed number of nodes, a random node will be deleted.
* You can manually drain the nodes you no longer need in an autoscaling node group. To do this, before scaling it down:
  1. Disable the creation of new pods on the relevant node with the `kubectl cordon` command.
  1. Evict the pods from the node using `kubectl drain`.

  When reducing the group size, the drained node will be deleted first.
* The nodes to drain and stop are labeled as `Unschedulable`. This helps you avoid creating new pods on them.
* Nodes in the group are drained one at a time.
* Nodes are not drained when deleting a node group. If pods on the nodes to delete receive requests, they will not processed until {{ k8s }} checks the nodes as unhealthy and creates pods on the running nodes. To avoid this, change the size of the node group to zero, wait for the operation to complete, and delete the node group.
