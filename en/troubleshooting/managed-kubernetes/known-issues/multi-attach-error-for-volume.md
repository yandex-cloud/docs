# Resolving the `Multi-Attach error for volume` error



## Issue description {#issue-description}

When trying to use a `persistent volume` on multiple pods at once, you see errors like this:
* `Multi-Attach error for volume "<volume-name>" Volume is already used by pod(s) <pod1>, <pod2>`;
* `Multi-Attach error for volume "<volume-name>" Volume is already exclusively attached to one node and can't be attached to another`.

## Solution {#issue-resolution}

By default, storage classes that are based on network disks come with the cluster, and they do not support multiple access mode. We provide more details about it in [this {{ managed-k8s-name }} guide](../../../managed-kubernetes/operations/volumes/manage-storage-class.md). This is a limitation of our [driver](https://github.com/yandex-cloud/k8s-csi-s3). You cannot use it for multiple access, even if you create your own storage class based on it.

If you need to use `ReadWriteMany`, we recommend using CSI for our object storage because the volumes based on it support this access mode:

Automatic installation via the marketplace or `Helm` chart is described [here](../../../managed-kubernetes/operations/volumes/s3-csi-integration.md), and manual integration is described [here](../../../managed-kubernetes/operations/volumes/s3-csi-integration.md?tabs=instructions_manual).



If you need to use `ReadWriteMany`, we recommend using CSI for our object storage because the volumes based on it support this access mode. For automatic installation from our marketplace or Helm chart, see [this guide](../../../managed-kubernetes/operations/applications/csi-s3.md); for manual integration, refer to [this article](../../../managed-kubernetes/operations/volumes/s3-csi-integration.md).

## If the issue persists {#if-issue-still-persists}

If the actions described above did not help solve the issue, you can try to organize storage on your own. Some of the possible solutions also support multiple access (for example, nfs or CEPH). You can read more about this in the [k8s official documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).


