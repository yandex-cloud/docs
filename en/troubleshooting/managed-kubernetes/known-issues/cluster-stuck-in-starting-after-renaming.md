# {{ managed-k8s-name }} cluster remains in the `STARTING` status for too long after renaming


## Issue description {#issue-description}

* Your {{ managed-k8s-name }} cluster remains in the `STARTING` status for too long.
* In the list of operations, there are operations in the `Not completed` status.

## Solution {#issue-resolution}

Renaming VMs that were automatically created as worker nodes when deploying a {{ managed-k8s-name }} cluster will disrupt the operation of the node group and the entire cluster. In [this article](../../../managed-kubernetes/operations/node-group/node-group-create.md), we explicitly tell you that you should not rename such nodes.

If you still renamed your nodes, you will need to delete the problematic {{ managed-k8s-name }} cluster and create a new one.