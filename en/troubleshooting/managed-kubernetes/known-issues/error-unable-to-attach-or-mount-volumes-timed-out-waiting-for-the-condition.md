# Resolving the `Timed out waiting for the condition` error when mounting a PVC


## Issue description {#issue-description}

When mounting a persistent volume claim (*PVC*) to a {{ managed-k8s-name }} cluster, you see the following error in your `kubelet` output and service logs:
```
Unable to attach or mount volumes: unmounted volumes=[<PVC_name>],
unattached volumes=[conf kube-api-access-r9rql data]: timed out waiting for the condition
```

## Solution {#issue-resolution}

Restart the VM running the cluster's worker node that hosts the pod with the storage in question. Make sure to run a cold restart, shutting down the VM. This restarts the QEMU process on the hypervisor with a new ID.

For a cold VM restart, click [**{{ ui-key.yacloud.common.stop }}**](../../../compute/operations/vm-control/vm-stop-and-start.md#stop), wait until the status shows `STOPPED`, and then [restart the VM](../../../compute/operations/vm-control/vm-stop-and-start.md#start) from the {{ compute-name }} management console or using the YC CLI.
