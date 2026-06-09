# Общие вопросы про Managed Service for Kubernetes

* [Какие сервисы доступны по умолчанию в кластерах Managed Service for Kubernetes?](#defaults)

* [Какая версия Kubernetes CLI (kubectl) должна быть установлена для полноценной работы с кластером?](#kubectl-version)

* [Сможет ли Yandex Cloud восстановить работоспособность кластера, если я допущу ошибки при его настройке?](#tech-support-cases)

* [Кто будет заниматься мониторингом здоровья кластера?](#health-check)

* [Как быстро Yandex Cloud закрывает уязвимости, обнаруженные в системе безопасности? Что делать, если злоумышленник успеет воспользоваться уязвимостью, и мои данные пострадают?](#security-updates)

* [Я могу подключиться к узлу кластера через OS Login, по аналогии с ВМ Yandex Cloud?](#connect-via-oslogin)

* [Какая операционная система используется на узлах кластера?](#cluster-node-os)

* [Поддерживает ли Yandex Virtual Private Cloud протокол IPv6?](#ipv6-support)

#### Какие сервисы доступны по умолчанию в кластерах Managed Service for Kubernetes? {#defaults}

По умолчанию доступны:
* [Сервер метрик (Metrics Server)](https://github.com/kubernetes-sigs/metrics-server) для агрегации данных об использовании ресурсов в [кластере Kubernetes](../concepts/index.md#kubernetes-cluster).
* [Плагин Kubernetes для CoreDNS](https://coredns.io/plugins/kubernetes/) для разрешения имен в кластере.
* [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) с поддержкой [CSI-плагинов](https://github.com/container-storage-interface/spec) для работы с [постоянными томами](../concepts/volume.md) (`PersistentVolume`).

#### Какая версия Kubernetes CLI (kubectl) должна быть установлена для полноценной работы с кластером? {#kubectl-version}

Мы рекомендуем использовать последнюю доступную официальную версию [kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/), чтобы избежать проблем совместимости.

#### Сможет ли Yandex Cloud восстановить работоспособность кластера, если я допущу ошибки при его настройке? {#tech-support-cases}

[Мастер](../concepts/index.md#master) находится под управлением Yandex Cloud, поэтому вы не сможете его повредить. Если у вас возникли проблемы с компонентами кластера Kubernetes, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Кто будет заниматься мониторингом здоровья кластера? {#health-check}

Yandex Cloud. В кластере проводится мониторинг повреждений файловой системы (corrupted file system), неисправностей ядра (kernel deadlock), потери связи с интернетом и проблем с компонентами Kubernetes. Мы также разрабатываем механизм автоматического восстановления для неисправных компонентов.

#### Как быстро Yandex Cloud закрывает уязвимости, обнаруженные в системе безопасности? Что делать, если злоумышленник успеет воспользоваться уязвимостью, и мои данные пострадают? {#security-updates}

Сервисы Yandex Cloud, образы и конфигурация мастера изначально проходят [различные проверки на безопасность и соответствие стандартам](../../security/index.md). 

Пользователи могут выбрать [периодичность установки обновлений](../concepts/release-channels-and-updates.md#updates) в зависимости от решаемых задач и конфигурации кластера. Необходимо учитывать направления атаки и уязвимость приложений, развернутых в кластере Kubernetes. Факторами, влияющими на безопасность приложений, могут быть [политики сетевой безопасности](../concepts/network-policy.md) между приложениями, уязвимости внутри [Docker-контейнеров](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers), а также некорректный режим запуска контейнеров в кластере.

#### Я могу подключиться к узлу кластера через OS Login, по аналогии с ВМ Yandex Cloud? {#connect-via-oslogin}

Да, для этого [воспользуйтесь инструкцией](../operations/node-connect-oslogin.md).

#### Какая операционная система используется на узлах кластера? {#cluster-node-os}

В зависимости от [канала обновлений и версии](../concepts/release-channels-and-updates.md) Kubernetes на узлах кластера предустанавливается Ubuntu 20.04 или Ubuntu 22.04.

#### Поддерживает ли Yandex Virtual Private Cloud протокол IPv6? {#ipv6-support}

В Yandex Virtual Private Cloud [отсутствует поддержка протокола IPv6](../../vpc/concepts/network-overview.md#limits), но на уровне ОС на узлах кластера IPv6 включен по умолчанию.