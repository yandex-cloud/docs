# Node group autoscaling in {{ managed-k8s-name }}

Autoscaling is a way of changing the size of a [node group](../index.md#node-group) based on resource requests for [pods](../index.md#pod) running on this group's nodes.

## How autoscaling works {#how-scale}

When [creating a node group](../../operations/node-group/node-group-create.md#create-node-group), you specify the minimum and maximum number of nodes in the group, and the [{{ k8s }} cluster](../index.md#kubernetes-cluster) will check the state of pods and nodes from time to time:
* If pods cannot be assigned due to a lack of resources (vCPUs or RAM) on the existing nodes, the number of nodes in the group will gradually increase to the specified maximum.
* If a workload on nodes is low, and all pods can be assigned to fewer nodes in a group, the number of nodes in the group will gradually decrease to the specified minimum.

## Autoscaling features {#scaling-features}

The [{{ k8s }} cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) resizes an autoscaling group, and this process has many non-trivial features, for example:
* If you can distribute the load in a cluster across fewer nodes, but you cannot evict pods from the nodes for some reason, the number of nodes in a group will not decrease.
* The actual number of nodes in a group may be below the minimum size of a node group. This may occur if:
  * The minimum size of an autoscaling group was increased after it was created.
  * The actual cluster workload does not require more nodes than the cluster currently has.
* You can place an autoscaling node group only in one [availability zone](../../../overview/concepts/geo-scope.md).

{% note tip %}

If unexpected behavior occurs, we recommend referring to the [{{ k8s }} cluster-autoscaler FAQ](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md).

{% endnote %}

{% note info %}

When calculating the current limits and [quotas]({{ link-console-quotas }}), {{ managed-k8s-name }} uses the specified maximum node group size as its actual size, regardless of the current group size.

{% endnote %}

Node group autoscaling is different from [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale). In case of Horizontal Pod Autoscaler, a controller periodically requests resource usage by metrics defined in each {{ k8s }} API [HorizontalPodAutoscaler](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#horizontalpodautoscaler-v2-autoscaling) object. You can use both mechanisms in parallel.

## Use cases {#examples}

* [{#T}](../../tutorials/dns-autoscaler.md)
