### {{ roles.k8s.editor }} {#k8s-editor}

Роль `{{ roles.k8s.editor }}` дает права на [создание](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md), [удаление](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md), [изменение](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md), остановку и запуск [кластеров](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [групп узлов {{ k8s }}](../../../managed-kubernetes/concepts/index.md#node-group).

Включает в себя роль `{{ roles.k8s.viewer }}`.
