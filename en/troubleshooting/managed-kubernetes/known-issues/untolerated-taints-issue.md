# Resolving the `0/10 nodes are available - node(s) had untolerated taint` error


## Issue description {#issue-description}

When launching a pod in your {{ managed-k8s-name }} cluster, you see this error:

```(text)
0/10 nodes are available: X node(s) had untolerated taint
```

Where `X` is the number of {{ managed-k8s-name }} cluster's affected nodes.

## Solution {#issue-resolution}

This error occurs when a node in the cluster is labeled as *taint*, which is incompatible with the requirements of the apps scheduled to run on it. A *taint* is a node label that means that certain pods cannot be scheduled on that node unless they meet specific conditions.

To resolve this issue, you can either modify the node label so that the pods are allowed to run on it, or update the pod settings to match the node label.

Additionally, we recommend reviewing the pod's *tolerations* and verifying the node's `nodeSelector` or `nodeAffinity` settings. Also, check your {{ managed-k8s-name }} quotas and resource limits to make sure your nodes have sufficient resources available.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a ticket, provide the following information:

1. {{ managed-k8s-name }} cluster ID.
1. {{ managed-k8s-name }} cluster event log: `kubectl get events` output.
1. Cluster node specification: `kubectl describe node $NODE_NAME` output, where `$NODE_NAME` is the affected node name.
1. Specifications of all affected pods in your cluster: `kubectl describe node $POD_NAME` output for each of those pods, where `$POD_NAME` is the pod name.
