# Automatic scaling

Automatic scaling is a way to modify the size of a [node group](./index.md#node-group), the number of pods, or the amount of resources allocated to each pod based on resource requests for [pods](./index.md#pod) running on the group's nodes. Autoscaling is available as of {{ k8s }} version 1.15.

In a {{ managed-k8s-name }} cluster, three types of automatic scaling are available:
* _Cluster autoscaling_ ({{ k8s-ca }}). {{ managed-k8s-name }} monitors the load on the nodes and updates the number of nodes within specified limits as required.
* _Horizontal pod scaling_ ({{ k8s-hpa }}). {{ k8s }} dynamically changes the number of pods running on each node in the group.
* _Vertical pod scaling_ ({{ k8s-vpa }}). When load increases, {{ k8s }} allocates additional resources to each pod within established limits.

You can use several types of automatic scaling in the same cluster. However, using {{ k8s-hpa }} and {{ k8s-vpa }} together is not recommended.

## Cluster autoscaling {#ca}

{{ k8s-ca }} automatically modifies the number of nodes in a group depending on the load.

{% include [autoscaled-node-group-restriction](../../_includes/managed-kubernetes/autoscaled-node-group-restriction.md) %}

When [creating a node group](../operations/node-group/node-group-create.md), select an automatic scaling type and set the minimum, maximum, and initial number of nodes in the group. {{ k8s }} will periodically check the pod status and node load on the nodes, adjusting the group size as required:
* If pods cannot be assigned due to a lack of vCPUs or RAM on the existing nodes, the number of nodes in the group will gradually increase to the specified maximum size.
* If the load on the nodes is insufficient, and all pods can be assigned with fewer nodes per group, the number of nodes per group will gradually decrease to the specified minimum size. If a node's pods cannot be evicted within the specified period of time ({{ k8s-decomission-timeout }}), the node is forced to stop. The waiting time cannot be changed.

{% note info %}

When calculating the current limits and [quotas]({{ link-console-quotas }}), {{ managed-k8s-name }} uses the specified maximum node group size as its actual size, regardless of the current group size.

{% endnote %}

{{ k8s-ca }} activation is only available when creating a node group. {{ k8s-ca }} is managed on the {{ managed-k8s-name }} side.

For more information, see the {{ k8s }} documentation:

* [{{ k8s-ca }} description](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler)
* [Default parameters](https://github.com/kubernetes/autoscaler/blob/c6b754c359a8563050933a590f9a5dece823c836/cluster-autoscaler/FAQ.md#what-are-the-parameters-to-ca)

See also [{#T}](../qa/cluster-autoscaler.md).

## Horizontal pod autoscaling {#hpa}

When using horizontal pod scaling, {{ k8s }} changes the number of pods depending on vCPU load.

When [creating a {{ k8s-hpa }}](../operations/autoscale.md#hpa), specify the following using parameters:
* Desired average percentage vCPU load for each pod.
* Minimum and maximum number of pod replicas.

Horizontal pod autoscaling is available for the following controllers:
* [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
* [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)

You can learn more about {{ k8s-hpa }} in the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/).

## Vertical pod autoscaling {#vpa}

{{ k8s}} uses the `limits` parameters to restrict resources allocated for each application. A pod exceeding the vCPU limit will trigger CPU throttling. A pod that has exceeded the RAM limit will be stopped.

If required, {{ k8s-vpa }} allocates additional vCPU and RAM resources to pods.

When [creating a {{ k8s-vpa }}](../operations/autoscale.md#vpa), set the autoscaling option in the specification:
* `updateMode: "Auto"` for {{ k8s-vpa }} to manage pod resources automatically.
* `updateMode: "Off"` for {{ k8s-vpa }} to [provide recommendations](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#quick-start) on managing pod resources without modifying them.

You can learn more about {{ k8s-vpa }} in the [{{ k8s }} documentation](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler).

## Use cases {#examples}

* [{#T}](../tutorials/autoscaling.md)
* [{#T}](../tutorials/vpa-autoscaling.md)
* [{#T}](../tutorials/load-testing-grpc-autoscaling.md)
* [{#T}](../tutorials/cert-manager-webhook.md)