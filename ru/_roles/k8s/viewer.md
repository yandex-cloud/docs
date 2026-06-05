
Роль `k8s.viewer` позволяет просматривать информацию о кластерах и группах узлов {{ k8s }}.

Пользователи с этой ролью могут:
* просматривать список [кластеров {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), информацию о них и настройках их взаимодействия с {{ marketplace-name }}, а также о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать список [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров {{ k8s }} и информацию о таких группах узлов;
* просматривать информацию о приложениях из {{ marketplace-name }}, а также о назначенных правах доступа к ним;
* просматривать статистику использования ресурсов и информацию о [квотах](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) сервиса {{ managed-k8s-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).