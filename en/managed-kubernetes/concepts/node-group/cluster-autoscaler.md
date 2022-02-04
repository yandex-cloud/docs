# Cluster autoscaler

Automatic [node group](../index.md#node-group) scaling is the modification of a node group's size based on requests for resources from [pods](../index.md#pod) running on nodes in this group.

## How the autoscaler works {#how-scale}

You specify the minimum and the maximum size of a node group, and the [{{ k8s }} cluster](../index.md#kubernetes-cluster) periodically checks the status of the pods and the nodes:
* If the pods can't be scheduled onto the existing nodes due to insufficient resources (vCPU, RAM), the number of nodes in the group gradually increases to the maximum specified.
* If the load on the nodes is insufficient and all pods can be scheduled onto fewer nodes in the group, the number of nodes gradually decreases to the minimum specified. 

{% note warning %}

Changing the size of an autoscaled node group is done with the help of the [Kubernetes cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) and has many non-trivial features. If you encounter some unexpected behaviour we recommend consulting [its FAQ](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md). For example:
  * If workloads in a cluster require less nodes than there is but for some reason pods cannot be evicted from all nodes of the group then the number of nodes will not be decreased
  * The actual number of nodes in an autoscaled node group might be less than the minimum size of the group. This might happen if  
    * the minimum size of the group was increased after the group creation
    * cluster has enough resources for the actual cluster load at the moment

{% endnote %}

If the pods in a node cannot be evicted, the node will not change.

{% note info %}

When calculating the current limits and quotas, {{ managed-k8s-name }} uses the specified maximum node group size as the actual size, regardless of the current group size.

{% endnote %}

The node group autoscaler is different from [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/). The Horizontal Pod Autoscaler uses a controller to periodically request resource usage based on the metrics defined in each {{ k8s }} API [HorizontalPodAutoscaler](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/#horizontalpodautoscaler-v1-autoscaling) object. You can use both mechanisms in parallel.