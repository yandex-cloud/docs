# Cluster pods remain `PENDING` for too long


## Issue description {#issue-description}

* Attempting to start new pods in a {{ managed-k8s-name }} cluster results in these pods remaining `PENDING` for a long period without switching to `RUNNING`.
* New pods get frozen as `PENDING`.
* One or more pods in a {{ managed-k8s-name }} cluster fail to switch to `RUNNING`.

## Solution {#issue-resolution}

Pods can get stuck in the `PENDING` status if the processes within the init container of one or more pods fail to complete successfully. For example, the kubelet daemon in such pods may continuously crash. In this case, the kubelet immediately restarts due to the `restartPolicy: Always` policy.

For more details about init containers, see [this {{ k8s }} overview article](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/#detailed-behavior).

## If the issue persists {#if-issue-still-persists}

For more detailed diagnostics of kubelet issues in newly created pods, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the {{ managed-k8s-name }} cluster in question. 
1. Logs with `kubelet/kernel/system` syslog tags from one or more {{ managed-k8s-name }} cluster nodes experiencing issues when attempting to start new pods.

You can also use [our script to collect {{ managed-k8s-name }} diagnostic logs automatically](https://github.com/yandex-cloud/yc-architect-solution-library/tree/main/yc-k8s-capture-nodes-logs).