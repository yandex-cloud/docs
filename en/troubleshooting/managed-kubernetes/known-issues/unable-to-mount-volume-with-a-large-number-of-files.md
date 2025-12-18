# Fixing the `Timed out waiting for the condition` error when mounting a volume with a large number of files



## Issue description {#issue-description}

When launching a pod, you see this error:

```bash
Warning FailedMount 49s kubelet Unable to attach or mount volumes: unmounted volumes=[jenkins-home], unattached volumes jenkins-home jenkins config kube-api-access-2ldxk sc-config-volume admin-secret jenkins-additional-secrets jenkins-cache tmp-volume[]: timed out waiting for the condition
```

## Diagnostics and issue reproduction {#issue-diagnostics-and-reproduction}

Analyze the system logs:

```bash
journalctl -t kernel --no-pager --since "today"
journalctl --system --no-pager --since "today"
journalctl -u kubelet --no-pager --since "today"
```

When launching the pod in question, the kubelet system service logs contain the following message:

```
If the volume has a lot of files then setting volume ownership could be slow...
```

## Solution {#issue-resolution}

A volume takes a while to mount because of the large number of files in the target file system. By default, the `fsgroup` configuration is recursively set at each volume mount. You can find the error details on its [discussion page in the {{ k8s }} Git repository](https://github.com/kubernetes/kubernetes/issues/69699).

We recommend setting up the security context for the pod using [this guide](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods).