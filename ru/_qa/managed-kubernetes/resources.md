# Ресурсы

#### Какие ресурсы требуются для обслуживания кластера {{ k8s }}, в который входит группа, например, из трех узлов? {#required-resources}

Для каждого [узла](../../managed-kubernetes/concepts/index.md#node-group) необходимы ресурсы для запуска компонентов, которые отвечают за функционирование узла как части [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Подробнее читайте в разделе [{#T}](../../managed-kubernetes/concepts/node-group/allocatable-resources.md).

#### Можно ли изменять ресурсы для каждого узла в кластере {{ k8s }}? {#change-resources}

Вы можете изменять ресурсы только для группы узлов. В одном кластере {{ k8s }} можно создавать группы с разными конфигурациями и размещать их в разных [зонах доступности](../../overview/concepts/geo-scope.md). Подробнее читайте в разделе [{#T}](../../managed-kubernetes/operations/node-group/node-group-update.md).

#### Кто будет следить за масштабированием кластера {{ k8s }}? {#scaling}

В {{ managed-k8s-name }} можно включить [автоматическое масштабирование кластера](../../managed-kubernetes/concepts/autoscale.md#ca).