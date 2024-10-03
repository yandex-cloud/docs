# Number of nodes in the group fails to decrease


## Issue description {#issue-description}

The number of nodes in the group does not decrease in the {{ managed-k8s-full-name }} cluster.

## Solution {#issue-resolution}

{{ managed-k8s-full-name }} uses Kubernetes cluster-autoscaler for automatic scaling of the node group. This works as follows: you specify the minimum and maximum size of the node group, and the Kubernetes cluster periodically checks the state of the pods and nodes.

If the load on the nodes is insufficient and all pods can be assigned with fewer nodes in the group, then the number of nodes in the group will gradually decrease to the specified minimum size.

The Kubernetes cluster-autoscaler periodically checks the load on the nodes and, if the pods can be restarted on other nodes without overloading them, it clears the node and stops it.

To clear a node, check the following parameters:
* The node is less than 50% loaded.
* The pods on this node do not have local storage.
* `affinity`/`antiaffinity`/`nodeselector`/`tolopogyspread` does not hinder the pod movement. 
* The pods are managed by a controller (deployment, stateful set).
* The PodDisruptionBudget will not be exceeded after the node removal.
* The pods have the `"cluster-autoscaler.kubernetes.io/safe-to-evict": "false" annotation`.

You can manually find the relevant node and check the pods (including pods from kube-system). Remove them manually if needed.

For details, see our [documentation](../../../managed-kubernetes/qa/cluster-autoscaler), as well as in the official [cluster-autoscaler documentation](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

We also recommend you to enable log writing from the master to your log group:

```
yc k8s cluster update <cluster_id> --master-logging enabled=true,log-group-id=<log_group_id>,cluster-autoscaler-enabled=true,kube-apiserver-enabled=true
```

There, you will be able to find the reason why downscaling is not functioning properly.
