Роль `k8s.editor` позволяет управлять кластерами и группами узлов Kubernetes.

Пользователи с этой ролью могут:
* просматривать список [кластеров Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), информацию о них и о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* создавать, изменять, запускать, останавливать и удалять кластеры Kubernetes;
* просматривать список [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров Kubernetes и информацию о таких группах узлов;
* создавать, изменять и удалять группы узлов кластеров Kubernetes;
* просматривать и изменять настройки взаимодействия кластеров Kubernetes с Cloud Marketplace;
* просматривать информацию о приложениях из Cloud Marketplace и о назначенных правах доступа к ним, а также устанавливать, обновлять и удалять такие приложения;
* просматривать статистику использования ресурсов и информацию о [квотах](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) сервиса Managed Service for Kubernetes;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `k8s.viewer`.