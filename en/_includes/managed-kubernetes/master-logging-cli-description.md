* `enabled`: Flag that enables sending logs, `true` or `false`.
* `log-group-id`: ID of the [log group](../../logging/concepts/log-group.md) to send logs to.
* `folder-id`: ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to send logs to. Logs will be sent to the log group of the default folder.
* `kube-apiserver-enabled`: Flag that enables sending [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) logs, `true` or `false`.
* `cluster-autoscaler-enabled`: Flag that enables sending `cluster-autoscaler` logs, `true` or `false`.
* `events-enabled`: Flag that enables sending {{ k8s }} events, `true` or `false`.
* `audit-enabled`: Flag that enables sending audit events, `true` or `false`.