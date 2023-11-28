* `enabled`: Flag that enables log sending: `true` or `false`.
* `log-group-id`: ID of the [log group](../../logging/concepts/log-group.md) to send the logs to.
* `folder-id`: ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to send the logs to. The logs will be sent to the log group of the default folder.
* `kube-apiserver-enabled`: Flag that enables [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) log sending: `true` or `false`.
* `cluster-autoscaler-enabled`: Flag that enables `cluster-autoscaler` log sending: `true` or `false`.
* `events-enabled`: Flag that enables {{ k8s }} event sending: `true` or `false`.

If log sending is enabled but neither `log-group-id` nor `folder-id` is specified, the logs will be sent to the default log group of the folder with the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). You cannot set both `log-group-id` and `folder-id` at the same time.