---
title: Autoscaling in {{ managed-k8s-name }}
description: Autoscaling in {{ managed-k8s-name }} allows you to resize a node group, change the number of pods and the amount of resources allocated to each one.
---

# Autoscaling

Autoscaling is when you resize a [node group](./index.md#node-group), change the number of pods or the amount of resources allocated to each pod based on resource requests for [pods](./index.md#pod) running on this group's nodes.

In a {{ managed-k8s-name }} cluster, you can leverage the following auto-scaling options:
* _Cluster autoscaling_ ({{ k8s-ca }}). {{ managed-k8s-name }} monitors workloads on the nodes and updates the number of nodes within specified limits as required.
* _Master autoscaling_ ({{ k8s-ma }}). {{ managed-k8s-name }} monitors workload on the master node and updates its configuration as required.
* _Horizontal pod scaling_ ({{ k8s-hpa }}). {{ k8s }} dynamically changes the number of pods running on each node in the group.
* _Vertical pod scaling_ ({{ k8s-vpa }}). When workloads increase, {{ k8s }} allocates additional resources to each pod within the set limits.

{% include [master-autoscaler-note](../../_includes/managed-kubernetes/master-autoscaler-note.md) %}

You can employ several types of autoscaling in the same cluster. However, using {{ k8s-hpa }} and {{ k8s-vpa }} together is not recommended.

## Cluster autoscaling {#ca}

{{ k8s-ca }} automatically modifies the number of nodes in a group depending on your workloads.

{% include [autoscaled-node-group-restriction](../../_includes/managed-kubernetes/autoscaled-node-group-restriction.md) %}

When [creating a node group](../operations/node-group/node-group-create.md), select an autoscaling type and set the minimum, maximum, and initial number of nodes in the group. {{ k8s }} will periodically check the pod status and workloads on the nodes, adjusting the group size as required:
* If pods cannot be assigned due to a lack of vCPUs or RAM on the existing nodes, the number of nodes in the group will gradually increase to the specified maximum.
* If a workload on nodes is low, and all pods can be assigned to fewer nodes in a group, the number of nodes in the group will gradually decrease to the specified minimum. If pods on the node cannot be evicted within the specified period of time ({{ k8s-decomission-timeout }}), the node is forced to stop. The timeout cannot be changed.

{% note info %}

When calculating the current limits and [quotas]({{ link-console-quotas }}), {{ managed-k8s-name }} uses the specified maximum node group size as its actual size, regardless of the current group size.

{% endnote %}

{{ k8s-ca }} activation is only available when creating a node group. {{ k8s-ca }} is managed on the {{ managed-k8s-name }} side.

For more information, see these {{ k8s }} guides:

* [{{ k8s-ca }} description](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler)
* [Default parameters](https://github.com/kubernetes/autoscaler/blob/c6b754c359a8563050933a590f9a5dece823c836/cluster-autoscaler/FAQ.md#what-are-the-parameters-to-ca)

For more information, see [{#T}](../qa/cluster-autoscaler.md).

## Master autoscaling {#master-autoscaler}

{% include [master-autoscaler-note](../../_includes/managed-kubernetes/master-autoscaler-note.md) %}

{% include [master-pricing-note](../../_includes/managed-kubernetes/master-pricing-note.md) %}

{{ k8s-ma }} automatically adjusts master configuration according to the current workload. This enables stable cluster operation without manual configuration selection.

For scaling, {{ k8s-ma }} regularly collects master utilization metrics, such as th number of vCPUs and the amount of RAM. It can then take the following decisions based on these metrics:

* Scale up resources if the master node is near overload.
* Scale down resources if the master node is consistently underutilized.
* Keep resources unchanged if utilization is within normal ranges.

To prevent reactions to brief load spikes, {{ k8s-ma }} takes decisions based on aggregated metrics over a few minutes. Scaling is only triggered when a critical threshold persists for a sustained period.

Apart from that, {{ k8s-ma }} does not scale down below the master configuration you selected when [creating](../operations/kubernetes-cluster/kubernetes-cluster-create.md) or [modifying](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-resources) your cluster; such configuration acts as a lower scaling limit.

After taking a decision, the scaler selects the closest [matching master configuration](./master-configuration.md) to ensure that post-scaling utilization remains within normal limits.

Even when using {{ k8s-ma }}, choose the master configuration that matches the real cluster load. You may want to check out our [recommended configuration](./master-configuration.md) options that depend on the number of nodes, maximum number of pods, and CNI in use. An over-provisioned vCPU and RAM configuration will prevent the release of excess resources, while an under-provisioned one may cause over-frequent scaling.

You can view the master node auto-scaling operations under [cluster operations](../operations/kubernetes-cluster/kubernetes-cluster-operation-logs.md). While scaling is in progress, you cannot initiate other cluster operations; you will have to wait for the process to complete.

## Horizontal pod autoscaling {#hpa}

When using horizontal pod scaling, {{ k8s }} changes the number of pods depending on vCPU workload.

When [creating a {{ k8s-hpa }}](../operations/autoscale.md#hpa), specify the following parameters:
* vCPU load average percentage for each pod.
* Minimum and maximum number of pod replicas.

Horizontal pod autoscaling is available for the following controllers:
* [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).
* [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).
* [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).

For more on {{ k8s-hpa }}, see [this {{ k8s }} guide](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/).

## Vertical pod autoscaling {#vpa}

{{ k8s }} uses the `limits` parameters to restrict resources allocated for each application. A pod exceeding the vCPU limit will trigger CPU throttling. A pod exceeding the RAM limit will be stopped.

If required, {{ k8s-vpa }} allocates additional vCPU and RAM resources to pods.

When [creating a {{ k8s-vpa }}](../operations/autoscale.md#vpa), set the autoscaling mode in the specification:
* `updateMode: "Off"` for {{ k8s-vpa }} to [provide recommendations](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#quick-start) on managing pod resources without modifying them.
* `updateMode: "Initial"` for {{ k8s-vpa }} to apply recommendations only when creating pods.
* `updateMode: "Recreate"` for {{ k8s-vpa }} to recreate pods with updated resource values in case of a serious discrepancy between the current requests and recommendations.
* `updateMode: "InPlaceOrRecreate"` for {{ k8s-vpa }} to attempt updating requests and resource limits first, without restarting the pod. If such an update is not possible, the pod will be recreated as in the `Recreate` mode. For more information, see [Resize CPU and Memory Resources assigned to Containers](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/).

For more on {{ k8s-vpa }}, see [this {{ k8s }} guide](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler).

## Use cases {#examples}

* [{#T}](../tutorials/autoscaling.md)
* [{#T}](../tutorials/vpa-autoscaling.md)
* [{#T}](../tutorials/load-testing-grpc-autoscaling.md)
