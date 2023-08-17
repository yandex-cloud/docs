* `enabled` — флаг отправки логов.
* `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую нужно отправлять логи.
* `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
* `kube_apiserver_enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/).
* `cluster_autoscaler_enabled` — флаг отправки логов `cluster-autoscaler`.
* `events_enabled` — флаг отправки событий {{ k8s }}.

Если отправка логов включена, но не указаны ни `log_group_id`, ни `folder_id`, логи будут отправляться в каталог, где находится [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log_group_id` и `folder_id` нельзя.