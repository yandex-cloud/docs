* `enabled` — флаг отправки логов: `true` или `false`.
* `log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую нужно отправлять логи.
* `folder-id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
* `kube-apiserver-enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/): `true` или `false`.
* `cluster-autoscaler-enabled` — флаг отправки логов `cluster-autoscaler`: `true` или `false`.
* `events-enabled` — флаг отправки событий {{ k8s }}: `true` или `false`.

Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.