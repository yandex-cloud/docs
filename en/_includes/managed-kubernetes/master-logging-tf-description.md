* `enabled`: Flag that enables log sending.
* `log_group_id`: ID of the [log group](../../logging/concepts/log-group.md) to send the logs to.
* `folder_id`: ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to send the logs to. The logs will be sent to the log group of the default folder.
* `kube_apiserver_enabled`: Flag that enables [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/) log sending.
* `cluster_autoscaler_enabled`: Flag that enables `cluster-autoscaler` log sending.
* `events_enabled`: Flag that enables {{ k8s }} event sending.

If log sending is enabled but neither `log_group_id` nor `folder_id` is specified, the logs will be sent to the default log group of the folder with the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). You cannot set both `log_group_id` and `folder_id` at the same time.