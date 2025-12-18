# Troubleshooting issues when mounting volumes to {{ managed-k8s-name }} cluster pods using Container Storage Interface for S3


## Issue description {#issue-description}

When attempting to mount a volume to the {{ managed-k8s-name }} cluster pods using the `csi-s3` driver, you get the following error message:

```
Warning FailedAttachVolume attachdetach-controller AttachVolume.Attach failed for volume "<volume_name>" : Attach timeout for volume <volume_name>
Warning FailedMount kubelet Unable to attach or mount volumes: unmounted volumes=[<volume_name>], unattached volumes=[<volume_name>]: timed out waiting for the condition
```

## Solution {#issue-resolution}

This issue most often occurs because the {{ managed-k8s-name }} cluster uses an outdated `csi-attacher` version. Apply the [current `attacher.yaml` version](https://github.com/yandex-cloud/k8s-csi-s3/blob/master/deploy/kubernetes/attacher.yaml) by running this command:

```
kubectl apply -f attacher.yaml
```

You may also need to update other `csi-s3` components. Clone the [repository with the current `csi-s3` driver version](https://github.com/yandex-cloud/k8s-csi-s3) locally, and then update the {{ managed-k8s-name }} cluster components with these commands:

```
cd <folder_with_cloned_repository>
cd deploy/kubernetes
kubectl apply -f provisioner.yaml
kubectl apply -f attacher.yaml
kubectl apply -f csi-s3.yaml
```

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. `kubectl describe` command output for the PVs, PVCs, and pods in question.