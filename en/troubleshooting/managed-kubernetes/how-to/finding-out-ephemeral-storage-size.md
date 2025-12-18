# How to find out the ephemeral storage size for a {{ managed-k8s-name }} node


## Case description {#case-description}

You need to find out the ephemeral storage size for a {{ managed-k8s-name }} node.

## Solution {#case-resolution}

The ephemeral storage may take up to 50% of the node disk size. Your ephemeral storage may reserve some unused space for system needs.

To learn more about how ephemeral storage works, see [this official {{ k8s }} guide](https://kubernetes.io/docs/concepts/storage/ephemeral-volumes).
