# Questions and answers about node group autoscaling in {{ managed-k8s-name }}

#### Why are there N nodes in my cluster now, but it's not getting downsized? {#not-scaling-down}

[Autoscaling](../concepts/autoscale.md) doesn't stop nodes with [pods](../concepts/index.md#pod) that can't be evicted. Scaling barriers:
* Pods whose eviction is limited with [PodDisruptionBudget](../concepts/node-group/node-drain.md).
* Pods in the `kube-system` [namespace](../concepts/index.md#namespace):
  * That haven't been created under the [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) controller.
  * That don't have `PodDisruptionBudget` or whose eviction is limited by `PodDisruptionBudget`.
* Pods that haven't been created under a replication controller ([ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), or [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)).
* Pods with a `local storage`.
* Pods that can't be evicted anywhere due to restrictions. For example, due to lack of resources or lack of nodes matching the [affinity or anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) selectors.
* Pods with an annotation that disables eviction: `"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"`.

{% note info %}

Pods `kube-system`, pods with `local-storage`, and pods without a replication controller can be evicted. To do this, set the annotation `"safe-to-evict": "true"`:

```bash
kubectl annotate pod <pod name> cluster-autoscaler.kubernetes.io/safe-to-evict=true
```

{% endnote %}

Other possible causes:
* The [node group](../concepts/index.md#node-group) has already reached its minimum size.
* The node is idle for less than 10 minutes.
* During the last 10 minutes, the node group has been scaled up.
* During the last 3 minutes, there was an unsuccessful attempt to scale down the node group.
* There was an unsuccessful attempt to stop a certain node. In this case, the next attempt occurs in 5 minutes.
* The node has an annotation that prohibits stopping it on scale-down: `"cluster-autoscaler.kubernetes.io/scale-down-disabled": "true"`. You can add or remove annotation using `kubectl`.

  Check for annotation on the node:

  ```bash
  kubectl describe node <node name> | grep scale-down-disabled
  ```

  Result:

  ```bash
  Annotations:        cluster-autoscaler.kubernetes.io/scale-down-disabled: true
  ```

  Set the annotation:

  ```bash
  kubectl annotate node <node name> cluster-autoscaler.kubernetes.io/scale-down-disabled=true
  ```

  Remove the annotation by running the `kubectl` command with `-`:

  ```bash
  kubectl annotate node <node name> cluster-autoscaler.kubernetes.io/scale-down-disabled-
  ```

#### Why has the pod been deleted, but the node group fails to downsize? {#not-scaling-pod}

If the node is underloaded, it's removed in 10 minutes.

#### Why isn't autoscaling performed even when the number of nodes gets less than the minimum or greater than the maximum? {#beyond-limits}

Autoscaling won't violate preset limits, but {{ managed-k8s-name }} isn't explicitly controlling the limits. Scaling up will only trigger if there are pods in the `unschedulable` status.

To get answers to other questions about autoscaling, see the [documentation {{ k8s }}](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).