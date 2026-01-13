Роль `k8s.admin` позволяет управлять кластерами и группами узлов Kubernetes, а также доступом к кластерам Kubernetes.

Пользователи с этой ролью могут:
* просматривать список [кластеров Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и информацию о них, а также создавать, изменять, запускать, останавливать и удалять кластеры Kubernetes;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Kubernetes и изменять такие права доступа;
* просматривать список [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров Kubernetes и информацию о таких группах узлов, а также создавать, изменять и удалять группы узлов кластеров Kubernetes;
* просматривать и изменять настройки взаимодействия кластеров Kubernetes с Cloud Marketplace;
* просматривать информацию о приложениях из Cloud Marketplace, а также устанавливать, обновлять и удалять такие приложения;
* просматривать информацию о назначенных правах доступа к приложениям из Cloud Marketplace и изменять такие права доступа;
* просматривать статистику использования ресурсов и информацию о [квотах](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) сервиса Managed Service for Kubernetes;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `k8s.editor`.