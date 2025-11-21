#### Why does my cluster have N nodes and is not scaling down? {#not-scaling-down}

[Autoscaling](../../managed-kubernetes/concepts/autoscale.md) does not stop nodes with [pods](../../managed-kubernetes/concepts/index.md#pod) that cannot be evicted. The following prevents scaling:
* Pods with a [PodDisruptionBudget](../../managed-kubernetes/concepts/node-group/node-drain.md) that restricts their eviction.
* Pods in the `kube-system` [namespace](../../managed-kubernetes/concepts/index.md#namespace):
  * Those not managed by a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) controller.
  * Those without a `PodDisruptionBudget` or those with a `PodDisruptionBudget` restricting their eviction.
* Pods not managed by a replication controller, such as [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).
* Pods with `local-storage`.
* Pods that cannot be scheduled anywhere due to restrictions, e.g., due to insufficient resources or lack of nodes matching the [affinity or anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) selectors.
* Pods annotated with `"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"`.

{% note info %}

You can evict `kube-system` pods, pods with `local-storage`, and pods without a replication controller. To do this, set `"safe-to-evict": "true"`:

```bash
kubectl annotate pod <pod_name> cluster-autoscaler.kubernetes.io/safe-to-evict=true
```

{% endnote %}

Other possible causes include:
* The [node group](../../managed-kubernetes/concepts/index.md#node-group) has already reached its minimum size.
* The node has been idle for less than 10 minutes.
* The node group was scaled up in the last 10 minutes.
* There was a failed attempt to scale down the node group in the last three minutes.
* There was an unsuccessful attempt to stop a certain node. In this case, the next attempt occurs in 5 minutes.
* The node is annotated to prevent it from being stopped during downscaling: `"cluster-autoscaler.kubernetes.io/scale-down-disabled": "true"`. You can add or remove the annotation using `kubectl`.

  Check the node for annotations:

  ```bash
  kubectl describe node <node_name> | grep scale-down-disabled
  ```

  Result:

  ```bash
  Annotations:        cluster-autoscaler.kubernetes.io/scale-down-disabled: true
  ```

  Set the annotation:

  ```bash
  kubectl annotate node <node_name> cluster-autoscaler.kubernetes.io/scale-down-disabled=true
  ```

  You can remove the annotation by running the `kubectl` command with `-`:

  ```bash
  kubectl annotate node <node_name> cluster-autoscaler.kubernetes.io/scale-down-disabled-
  ```
  
#### In an autoscaling group, the number of nodes never scales down to one, even when there is no load {#autoscaler-one-node}

In a {{ managed-k8s-name }} cluster, the `kube-dns-autoscaler` app decides on the number of CoreDNS replicas. If the `preventSinglePointFailure` parameter in the `kube-dns-autoscaler` configuration is set to `true` and there is more than one node in the group, the minimum number of CoreDNS replicas is two. In this case, the Cluster Autoscaler cannot scale down the number of nodes in the cluster below that of CoreDNS pods.

Learn more about DNS scaling based on the cluster size [here](../../tutorials/container-infrastructure/dns-autoscaler.md).

**Solution**:

1. Disable the protection setting that limits the minimum number of CoreDNS replicas to two. To do this, set the `preventSinglePointFailure` parameter to `false` in the `kube-dns-autoscaler` [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/).
1. Enable the `kube-dns-autoscaler` pod eviction by adding the `save-to-evict` annotation to [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

    ```bash
    kubectl patch deployment kube-dns-autoscaler -n kube-system \
      --type merge \
      -p '{"spec":{"template":{"metadata":{"annotations":{"cluster-autoscaler.kubernetes.io/safe-to-evict":"true"}}}}}'
    ```

#### Why does the node group fail to scale down after the pod deletion? {#not-scaling-pod}

If a node is underutilized, it will be deleted after 10 minutes.

#### Why does autoscaling fail to trigger even though the number of nodes is below the minimum or above the maximum? {#beyond-limits}

Autoscaling will not violate the preset limits, but {{ managed-k8s-name }} does not explicitly enforce the limits. Upscaling will only happen if there are `unschedulable` pods.

#### Why do _Terminated_ pods remain in my cluster? {#terminated-pod}

This happens because the [Pod garbage collector (PodGC)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) fails to timely clean up these pods during autoscaling. For more information, see [Deleting terminated pods](../../managed-kubernetes/operations/autoscale.md#delete-terminated).

To get answers to other questions about autoscaling, see [{{ k8s }} FAQ](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

#### Is Horizontal Pod Autoscaler supported? {#horizontal-pod-autoscaler}

Yes, {{ managed-k8s-name }} supports [Horizontal Pod Autoscaler](../../managed-kubernetes/concepts/autoscale.md#hpa).
