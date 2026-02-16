# Nodes in a {{ managed-k8s-name }} group not scaling down



## Issue description {#issue-description}

Nodes in your {{ managed-k8s-name }} cluster group will not scale down.

## Solution {#issue-resolution}

{{ managed-k8s-name }} uses {{ k8s-ca }} for autoscaling of node groups. Here is how it works: you specify the minimum and maximum size of the node group, and the {{ k8s }} cluster regularly checks the state of pods and nodes.

If a workload on nodes is low and all pods can be assigned to fewer nodes per group, the number of nodes in the group will gradually decrease to the specified minimum.

{{ k8s-ca }} periodically checks the load on the nodes and, if the pods can be safely rescheduled to other nodes without overloading them, it drains and shuts down the node.

To enable node draining, check the following:

* The node load is below 50%. To check the load level, you can use the `yc managed-kubernetes cluster list-nodes $CLUSTER_ID` command, where `$CLUSTER_ID` is the {{ managed-k8s-name }} cluster ID.
* The pods on this node do not have local storage.
* There are no `affinity`, `antiaffinity`, `nodeselector`, or `tolopogyspread` rules preventing pod relocation.
* The pods are managed by a controller, e.g., Deployment or StatefulSet.
* [PodDisruptionBudget](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/#pod-disruption-budgets) will remain within its limit after the node deletion.

You can manually find the node in question and check its pods, including those from the `kube-system` namespace. Delete them manually, if required.

You can also set up the [descheduler](https://github.com/kubernetes-sigs/descheduler) to delete the pods you no longer need. For details, see our [autoscaling FAQs](../../../managed-kubernetes/qa/cluster-autoscaler.md) and the [official {{ k8s-ca }} documentation](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

We recommend that you enable master logging in your log group:

```
yc k8s cluster update <cluster_id> --master-logging enabled=true,log-group-id=<log_group_id>,cluster-autoscaler-enabled=true,kube-apiserver-enabled=true
```

The logs will help you identify the cause of the failed downscale.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. Approximate date and time of {{ k8s-ca }} errors.
1. YAML specification of the pod controller, such as Deployment or StatefulSet.
