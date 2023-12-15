# Evicting pods from a node

When you update a node group, the pods are evicted from the old node and migrated to the new one. To make sure that eviction does not affect the availability of the services provided by your applications in the {{ k8s }} cluster, configure the {{ k8s }} API [PodDisruptionBudget](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/pod-disruption-budget-v1/) object for the pods of your application.

The `PodDisruptionBudget` object is defined by three fields:
* `.spec.selector`: Selector {{ k8s }} label that marks the set of pods it applies to. This is a required field.
* `.spec.minAvailable`: Minimum number of pods from the set to be available after eviction. You can specify it as a percentage value.
* `.spec.maxUnavailable`: Maximum number of pods from the set that may be unavailable after eviction. You can specify it as a percentage value.

If you do not define the [PodDisruptionBudget policy](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/), the pods will be evicted all at once, which may cause issues in your application.

{% note warning %}

* A pod can only be evicted if it was created by an application replication controller: [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). If a pod is created without a controller, it will be lost during the update.
* [Persistent volumes](../volume.md) (`PersistentVolumes` objects) used by the pods, which are managed by the `StatefulSet` controller, can only be moved between nodes within a single availability zone.

{% endnote %}

Specifics for evicting pods from nodes:
* Configure the `PodDisruptionBudgets` policy to make it impossible to evict too many pods at once, but possible to evict at least one pod.
* Pod eviction is subject to the node stop timeout (7 minutes). The node is stopped even if not all pods are evicted during that time.
* When you downsize a node group to evict pods and then delete nodes, the nodes without pods are drained and deleted first. You can also manually drain the nodes you no longer need using the `kubectl drain` command.
* The nodes to be drained and stopped are marked `Unschedulable`. This helps you avoid creating new pods on them.
* Nodes in the group are drained one at a time.
* Nodes are not drained when a node group is deleted. If requests are sent to pods on the deleted nodes, they will not processed until {{ k8s }} diagnoses the nodes as unhealthy and creates pods on the running nodes. To avoid this, change the size of the node group to zero, wait for the operation to complete, and delete the node group.