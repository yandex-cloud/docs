# Resolving the "Multi-Attach error for volume" error



## Issue description {#issue-description}

When trying to use a `persistent volume` on multiple pods at once, you see this error:
* `Multi-Attach error for volume "<volume-name>" Volume is already used by pod(s) <pod1>, <pod2>`;
* `Multi-Attach error for volume "<volume-name>" Volume is already exclusively attached to one node and can't be attached to another`.

## Solution {#issue-resolution}

By default, storage classes that are based on network disks are delivered with the cluster, and they do not support multiple access mode. We provide more details about this in our [documentation](../../../managed-kubernetes/operations/volumes/manage-storage-class). This is a limitation of our [driver](disk-csi-driver.mks.ycloud.io). You cannot use it for multiple access, even if you create your own storage class based on it.

Such errors can also occur if the pods that should use the `volume` are located [on different nodes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

If you need to use `ReadWriteMany`, we recommend using CSI for our object storage because the volumes based on it support this access mode:

Automatic installation via the marketplace or `Helm` chart is described [here](../../../docs/managed-kubernetes/operations/volumes/s3-csi-integration), and manual integration is described [here](../../../managed-kubernetes/operations/volumes/s3-csi-integration).


## If the issue persists {#if-issue-still-persists}

If the actions described above did not help solve the issue, you can try to organize storage on your own. Some of the possible solutions also support multiple access (for example, nfs or CEPH). You can read more about this in the [k8s official documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

