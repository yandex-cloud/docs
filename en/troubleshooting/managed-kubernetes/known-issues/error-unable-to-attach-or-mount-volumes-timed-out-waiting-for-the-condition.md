# Fixing the «timed out waiting for the condition» error when mounting a PVC

## Issue description {#issue-description}

When mounting a Persistent Volume Claim (PVC) to the Managed Service for Kubernetes cluster, you see the following error in your Kubelet output and service logs:

```
Unable to attach or mount volumes: unmounted volumes=[<PVC_NAME>],
unattached volumes=[conf kube-api-access-r9rql data]: timed out waiting for the condition
```

## Solution {#issue-resolution}

Restart the VM running the cluster's worker node hosting the pod with the problem storage.
Be sure to run a cold restart, shutting down the VM. This restarts the QEMU process on the hypervisor with a new ID.

For a cold VM restart, use the [Stop](../../../compute/operations/vm-control/vm-stop-and-start.md#stop) button, wait for the `Stopped` status, then [start the VM](../../../compute/operations/vm-control/vm-stop-and-start.md#start) from the Compute Cloud management console or YC CLI.
