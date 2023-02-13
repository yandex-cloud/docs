# Automatic scaling

Automatic scaling is a way to modify the size of a [node group](./index.md#node-group), the number of pods, or the amount of resources allocated to each pod based on resource requests for [pods](./index.md#pod) running on the group's nodes. Autoscaling is available as of {{ k8s }} version 1.15.

In a {{ managed-k8s-name }} cluster, three types of automatic scaling are available:
* _Cluster autoscaling_ ({{ k8s-ca }}). {{ managed-k8s-name }} monitors the load on the nodes and modifies the number of nodes within specified limits as required.
* _Horizontal pod scaling_ ({{ k8s-hpa }}). {{ k8s }} dynamically changes the number of pods running on each node of the group.
* _Vertical pod scaling_ ({{ k8s-vpa }}). When load increases, {{ k8s }} allocates additional resources to each pod within established limits.

You can use several types of automatic scaling in the same cluster. However, using {{ k8s-hpa }} and {{ k8s-vpa }} together is not recommended.

## Cluster autoscaling {#ca}

{{ k8s-ca }} automatically modifies the number of nodes in a group depending on the load.

When [creating a node group](../operations/node-group/node-group-create.md), select an automatic scaling type and set the minimum, maximum, and initial number of nodes in the group. {{ k8s }} will periodically check the pod status and node load on the nodes, adjusting the group size as required:
* If pods can't be assigned because of a shortage of vCPUs or RAM on the existing nodes, the number of nodes in the group will gradually increase until it reaches the specified maximum.
* If the load on the nodes is insufficient and all pods can be scheduled onto fewer nodes in the group, the number of nodes gradually decreases to the minimum specified. If the pods in a node can't be relocated in the span of a specified period of time ({{ k8s-decomission-timeout }}), the node is forced to stop. You can't change the waiting time.

{% note info %}

When calculating the current limits and [quotas]({{ link-console-quotas }}), {{ managed-k8s-name }} uses the specified maximum node group size as the actual size, regardless of the current group size.

{% endnote %}

{{ k8s-ca }} activation is only available when creating a node group.

Learn more about {{ k8s-ca }} in the [{{ k8s }} documentation](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler).

## Horizontal pod autoscaling {#hpa}

When using horizontal pod scaling, {{ k8s }} changes the number of pods depending on vCPU load.

When [creating a {{ k8s-hpa }}](../operations/autoscale.md#hpa), specify the following using parameters:
* Desired average percentage vCPU load for each pod.
* Minimum and maximum number of pod replicas.

Horizontal pod autoscaling is available for the following controllers:
* [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).
* [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).
* [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).

Learn more about {{ k8s-hpa }} in the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/).

## Vertical pod autoscaling {#vpa}

{{ k8s}} restricts resource allocation for each application using the `limits` parameters. For a pod that has exceeded the vCPU limit, the processor clock cycle skip mode is enabled. A pod that has exceeded the RAM limit will be stopped.

If required, {{ k8s-vpa }} allocates additional vCPU and RAM resources to pods.

When [creating a {{ k8s-vpa }}](../operations/autoscale.md#vpa), set the autoscaling option in the specification:
* `updateMode: "Auto"` for {{ k8s-vpa }} to manage pod resources automatically.
* `updateMode: "Off"` for {{ k8s-vpa }} to [provide recommendations](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#quick-start) on managing pod resources without modifying them.

{% note info %}

{{ k8s-vpa }} will not apply new recommendations if an application is only deployed in a single pod.

{% endnote %}

Learn more about {{ k8s-vpa }} in the [{{ k8s }} documentation](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler).