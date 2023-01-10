# Node group autoscaling in {{ managed-k8s-name }}

The cluster autoscaler resizes the [node group](../index.md#node-group) based on resource requests for the [pods](../index.md#pod) running on the nodes of that group.

## How the autoscaler works {#how-scale}

You specify the minimum and maximum size of the node group, and the [{{ k8s }} cluster](../index.md#kubernetes-cluster) periodically checks the status of the pods and nodes:
* If the pods can't be scheduled onto the existing nodes due to insufficient resources (vCPU, RAM), the number of nodes in the group gradually increases to the maximum specified.
* If the load on the nodes is insufficient and all pods can be scheduled onto fewer nodes in the group, the number of nodes gradually decreases to the minimum specified.

{% note warning %}

You can resize an autoscaling group using [{{ k8s }} cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler), but there are many non-trivial features. If unexpected behavior occurs, we recommend referring to the [FAQ](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md). In particular:
* If you can distribute the load in a cluster to a smaller number of nodes, but you cannot evict pods from the nodes for some reason, the number of nodes in a group will not decrease.
* The actual number of nodes in a group may be below the minimum size of a node group. This may occur if:
  * An autoscaled group resized up from its minimum size after being created.
  * Actual cluster load does not require more nodes than the cluster currently has.

{% endnote %}

{% note info %}

When calculating the current limits and [quotas]({{ link-console-quotas }}), {{ managed-k8s-name }} uses the specified maximum node group size as the actual size, regardless of the current group size.

{% endnote %}

The node group autoscaler is different from [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale). The Horizontal Pod Autoscaler uses a controller to periodically request resource usage based on the metrics defined in each {{ k8s }} API [HorizontalPodAutoscaler](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#horizontalpodautoscaler-v2-autoscaling) object. You can use both mechanisms in parallel.