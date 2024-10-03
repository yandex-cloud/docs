# Resolving the "timed out waiting for the condition" error when mounting a volume with a large number of files


## Issue description {#issue-description}

When launching a pod, you see this error:

```bash
Warning FailedMount 49s kubelet Unable to attach or mount volumes: unmounted volumes=[jenkins-home], unattached volumes jenkins-home jenkins config kube-api-access-2ldxk sc-config-volume admin-secret jenkins-additional-secrets jenkins-cache tmp-volume[]: timed out waiting for the condition
```

## Diagnostics and error reproduction

Analyze the system logs:

```bash
journalctl -t kernel --no-pager --since "today"
journalctl --system --no-pager --since "today"
journalctl -u kubelet --no-pager --since "today"
```

The `kubelet` system service logs include, at a time close to the launch of the problem pod, you see the message: `If the volume has a lot of files then setting volume ownership could be slow...`

## Solution {#issue-resolution}

The reason behind the long mounting time is the large number of files on the target file system. By default, the `fsgroup` configuration is recursively set at each volume mount. Details about the error are given on its [discussion page in the Kubernetes git repository](https://github.com/kubernetes/kubernetes/issues/69699).

We recommend setting up the security context for the pod using the [following guide](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods).
