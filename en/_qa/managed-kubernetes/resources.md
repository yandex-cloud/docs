#### What resources do I need to maintain a {{ k8s }} cluster with a group of, say, three nodes? {#required-resources}

Each [node](../../managed-kubernetes/concepts/index.md#node-group) needs resources to run the {{ k8s }} components that allow the node to work as part of the [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). For more information, see [{#T}](../../managed-kubernetes/concepts/node-group/allocatable-resources.md).

#### Can I change resources for each node in a {{ k8s }} cluster? {#change-resources}

You can only change resources for a node group. You can create groups with different configurations in a single {{ k8s }} cluster and spread them across multiple [availability zones](../../overview/concepts/geo-scope.md). For more information, see [{#T}](../../managed-kubernetes/operations/node-group/node-group-update.md).

#### Who handles {{ k8s }} cluster scaling? {#scaling}

In {{ managed-k8s-name }}, you can enable [cluster autoscaling](../../managed-kubernetes/concepts/autoscale.md#ca).

#### Do the {{ k8s }} cluster nodes need internet access? {#internet-access}

{% include [nodes-internet-access](../../_includes/managed-kubernetes/nodes-internet-access.md) %}

{% include [nodes-internet-access-additional](../../_includes/managed-kubernetes/nodes-internet-access-additional.md) %}

#### How are old images automatically cleaned up on nodes? {#image-garbage-collection}

Kubelet automatically cleans up unused images. Cleanup starts when disk usage reaches the high threshold and continues until it falls to the low threshold. These thresholds are configured using the `imageGCHighThresholdPercent` and `imageGCLowThresholdPercent` parameters in the kubelet configuration.

Do not run third-party image cleanup tools at the same time, as they can interfere with kubelet. For more information about garbage collection, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/architecture/garbage-collection/#containers-images).

If there is still not enough disk space, check what is using it: images, logs, or application data. If the issue persists, [create a support ticket]({{ link-console-support }}). Specify the cluster ID, error time, diagnostic results.

#### How can I check the node ephemeral storage size? {#ephemeral-storage}

Run this command:

```bash
kubectl get nodes -o custom-columns="NAME:.metadata.name,CAPACITY_EPHEM:.status.capacity.ephemeral-storage,ALLOCATABLE_EPHEM:.status.allocatable.ephemeral-storage"
```

`CAPACITY_EPHEM` stands for the total `ephemeral-storage` capacity of the node, while `ALLOCATABLE_EPHEM` shows how much of that capacity is available for allocation to pods after reservations. Neither value shows how much disk space is currently free.

Learn more about [reserving node resources](../../managed-kubernetes/concepts/node-group/allocatable-resources.md) and [local ephemeral storage](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#local-ephemeral-storage).
