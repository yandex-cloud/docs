# Ресурсы

* [Какие ресурсы требуются для обслуживания кластера {{ k8s }}, в который входит группа, например, из трех узлов?](#required-resources)

* [Можно ли изменять ресурсы для каждого узла в кластере {{ k8s }}?](#change-resources)

* [Кто будет следить за масштабированием кластера {{ k8s }}?](#scaling)

* [Нужен ли узлам кластера {{ k8s }} доступ в интернет?](#internet-access)

#### Какие ресурсы требуются для обслуживания кластера {{ k8s }}, в который входит группа, например, из трех узлов? {#required-resources}

Для каждого [узла](../concepts/index.md#node-group) необходимы ресурсы для запуска компонентов, которые отвечают за функционирование узла как части [кластера {{ k8s }}](../concepts/index.md#kubernetes-cluster). Подробнее читайте в разделе [{#T}](../concepts/node-group/allocatable-resources.md).

#### Можно ли изменять ресурсы для каждого узла в кластере {{ k8s }}? {#change-resources}

Вы можете изменять ресурсы только для группы узлов. В одном кластере {{ k8s }} можно создавать группы с разными конфигурациями и размещать их в разных [зонах доступности](../../overview/concepts/geo-scope.md). Подробнее читайте в разделе [{#T}](../operations/node-group/node-group-update.md).

#### Кто будет следить за масштабированием кластера {{ k8s }}? {#scaling}

В {{ managed-k8s-name }} можно включить [автоматическое масштабирование кластера](../concepts/autoscale.md#ca).

#### Нужен ли узлам кластера {{ k8s }} доступ в интернет? {#internet-access}

Для подключения к внешним ресурсам, например реестрам Docker-образов [{{ container-registry-name }}](../../container-registry/concepts/index.md), [{{ cloud-registry-name }}](../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/), а также бакетам [{{ objstorage-name }}](../../storage/concepts/bucket.md), у узлов группы должен быть доступ в интернет.

Чтобы обеспечить доступ в интернет, [назначьте](../operations/node-group/node-group-update.md#node-internet-access) узлам публичный IP-адрес и [настройте](../operations/connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md).

Подробнее см. в подразделе [Доступ в интернет для рабочих узлов кластера](../concepts/network.md#nodes-internet).