# История изменений в Yandex Managed Service for Kubernetes

<!-- Changelog begin -->

{% changelog %}
```
date: 2025-12
index: 3
```

### Kubernetes 1.34 в RAPID, 1.33 в REGULAR

![image](../_assets/managed-kubernetes/rapid-1-34-regular-1-33.png)

Используйте актуальную версию Kubernetes в ваших кластерах. В [релизных каналах](concepts/release-channels-and-updates.md) стали доступны следующие версии Kubernetes:
* 1.34 в `RAPID`;
* 1.33 в `REGULAR`.

{% endchangelog %}

{% changelog %}
```
date: 2025-09
index: 2
```

### Доступ к API Yandex Cloud из кластера с помощью федерации сервисных аккаунтов IAM

![image](../_assets/managed-kubernetes/mk8s-wlif.svg)

Получайте IAM-токен для аутентификации в API Yandex Cloud прямо из пода кластера с помощью интеграции с федерацией сервисных аккаунтов Identity and Access Management. Подробнее:
* [Руководство по интеграции](tutorials/wlif-managed-k8s-integration.md)
* [Доклад на Yandex Neuro Scale 2025](https://scale.yandex.cloud/?broadcast=89&speech=2653)

{% endchangelog %}

{% changelog %}
```
date: 2025-09
index: 1
```

### Контроллер Yandex Cloud Gwin 

![image](../_assets/managed-kubernetes/gwin-scheme.png)

Используйте новый контроллер Yandex Cloud Gwin для балансировки трафика с помощью Application Load Balancer. Одновременно поддерживаются спецификации Kubernetes [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) и [Gateway API](https://gateway-api.sigs.k8s.io/). Подробнее:
* [Документация Gwin](alb-ref/gwin-index.md)
* [Доклад на Yandex Neuro Scale 2025](https://scale.yandex.cloud/?broadcast=89&speech=2658)

#### Ubuntu 22.04 на узлах кластера

Начиная с версии Kubernetes 1.30 операционная система узлов изменилась с Ubuntu 20.04 на Ubuntu 22.04. При обновлении групп узлов в этих версиях новые узлы автоматически создаются из образа виртуальной машины с Ubuntu 22.04. Подробнее на странице [Обновление операционной системы в группе узлов](concepts/node-os-update.md).

#### Выбор конфигурации мастера в CLI и Terraform

Используйте инструменты [Yandex Cloud CLI](../cli/index.md) и [Terraform](../terraform/index.md) для [конфигурации](concepts/index.md#master-resources) ресурсов мастера. Подробнее на странице [Создание кластера Managed Service for Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-create.md).

{% endchangelog %}

<!-- Changelog end -->

Изменения появляются в [релизных каналах](concepts/release-channels-and-updates.md) сервиса последовательно. Сначала обновления, содержащие новую функциональность и улучшения, появляются на канале `rapid`, через некоторое время они попадают в `regular` и уже после этого добавляются в `stable`.

## I квартал 2026 {#q1-2026}

### Новые возможности {#q1-2026-new-features}

* Добавлена поддержка [пулов резервов виртуальных машин](concepts/node-group/reserved-pools.md). Зарезервированные ресурсы будут гарантированно доступны для создания групп узлов кластера фиксированного размера. Пулы резервов можно использовать с помощью [Yandex Cloud CLI](../cli/index.md), [Terraform](../terraform/index.md) и [API](managed-kubernetes/api-ref/NodeGroup/create.md), а также передавать с помощью [переменных в шаблоне виртуальной машины](concepts/node-group/variables-in-the-template.md).
* Усовершенствована [интеграция с федерацией сервисных аккаунтов](../iam/concepts/workload-identity.md) Identity and Access Management:
  * Добавлена интеграция с федерацией сервисных аккаунтов с использованием контроллера DaemonSet `yc-metadata-server` на узлах для автоматического обмена токенов сервисного аккаунта Kubernetes на IAM-токен.
  * Управление интеграцией для мастеров и групп узлов доступно с помощью консоли управления, CLI, Terraform и API.
* Добавлена роль [`k8s.cluster-api.admin`](security/index.md#k8s-cluster-api-admin). Пользователь с этой ролью получает группу `yc:k8s-core-admin` и роль `admin` в [Kubernetes RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).
* Добавлена поддержка [групп пользователей](../organization/concepts/groups.md) Yandex Identity Hub в качестве субъектов в [Kubernetes RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/). Теперь в `RoleBinding` и `ClusterRoleBinding` можно указывать группу пользователей — все участники группы автоматически получат назначенные ей права в кластере.
* Группы виртуальных машин и диски, создаваемые при работе в Managed Service for Kubernetes, теперь маркируются [облачными метками](../resource-manager/concepts/labels.md) о принадлежности к кластеру и дополнительной информацией, позволяющей ассоциировать их с объектами Kubernetes.
  * Для групп виртуальных машин, создаваемых вместе с группой узлов, указывается идентификатор группы узлов `managed-kubernetes-node-group-id`, идентификатор кластера `managed-kubernetes-cluster-id` и пользовательские метки `labels`, заданные при создании группы узлов.
  * Для дисков, создаваемых для Persistent Volume, указывается идентификатор кластера `managed-kubernetes-cluster-id`, имя кластера `managed-kubernetes-cluster-name` и имя соответствующего Persistent Volume `managed-kubernetes-volume-name`.
* Добавлена возможность создавать тома объемом больше 8 ТБ с помощью поля `blockSize` в [спецификации класса хранилища](operations/volumes/manage-storage-class.md#sc-spec).

### Улучшения {#q1-2026-improvements}

* Поддержан Kubernetes версии [1.35](https://kubernetes.io/blog/2025/12/17/kubernetes-v1-35-release/). Подробнее на странице [Релизные каналы](concepts/release-channels-and-updates.md).
* Операции изменения [вычислительных ресурсов мастера](concepts/index.md#master-resources) теперь отображаются в списке операций кластера.
* Для кластеров с Kubernetes версии 1.35 и выше используется механизм управления ресурсами [cgroup v2](https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html).
* Среда запуска контейнеров [containerd](https://containerd.io/) обновлена до версии [2.2.1](https://github.com/containerd/containerd/releases/tag/v2.2.1) для кластеров с Kubernetes версии 1.31 и выше.
* Утилита [runc](https://github.com/opencontainers/runc) обновлена до версии [1.3.4](https://github.com/opencontainers/runc/releases/tag/v1.3.4) для кластеров с Kubernetes версии 1.31 и выше.
* Добавлен [toleration](concepts/index.md#taints-tolerations) `CriticalAddonsOnly` для подов [`cilium-operator`](https://docs.cilium.io/en/stable/network/concepts/ipam/cluster-pool/#cilium-operator) и [`hubble-relay`](https://docs.cilium.io/en/stable/observability/hubble/setup/#hubble-relay), что позволяет размещать их на выделенных узлах для системных нагрузок.

### Исправления {#q1-2026-problems-solved}

* Исправлен формат [конфигурации containerd](https://containerd.io/docs/1.7/man/containerd-config.toml.5). Конфигурация приведена к формату, совместимому с версиями 1.7 и 2.0 и выше. Ранее формат мог приводить к ошибкам при подключении внешних узлов и обновлении GPU Operator выше версии 24.9.2.

  {% note info %}

  Если вы меняете конфигурацию containerd на узлах кластера, перед обновлением кластера убедитесь, что используемые инструменты для изменения конфигурации совместимы с форматом containerd версий 1.7 и 2.0 и выше. Подробнее о формате конфигурации в [документации containerd](https://containerd.io/docs/1.7/man/containerd-config.toml.5).

  {% endnote %}

### Прочие изменения {#q1-2026-other-changes}

* Компонент [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) удален с мастеров кластеров со всеми актуальными версиями Kubernetes во всех релизных каналах.

## IV квартал 2025 {#q4-2025}

### Улучшения {#q4-2025-improvements}

* Поддержан Kubernetes версии [1.34](https://kubernetes.io/blog/2025/08/27/kubernetes-v1-34-release/). Подробнее на странице [Релизные каналы](concepts/release-channels-and-updates.md).
* Поддержано [автоматическое масштабирование кластера](concepts/autoscale.md#ca) в ответ на запросы подов на [эфемерное хранилище](https://kubernetes.io/docs/concepts/storage/ephemeral-storage/).
* Обновлен компонент [node-problem-detector](https://github.com/kubernetes/node-problem-detector) до версии [0.8.21](https://github.com/kubernetes/node-problem-detector/releases/tag/v0.8.21). Включен эндпоинт для сбора метрик с этого компонента. 
* Добавлено поле `criticalAddonsOnly` для манифестов `calico-typha-horizontal-autoscaler` и `calico-typha-vertical-autoscaler`, что обеспечивает возможность группировать системные поды на определенных узлах.

### Исправления {#q4-2025-problems-solved}

* Исправлена [проблема](https://github.com/kubernetes/kubernetes/issues/126440), при которой контейнеры в подах оставались в статусе `Created` в кластерах с версиями Kubernetes 1.29 и 1.30.
* Устранена проблема конфигурации [ip-masq-agent](https://github.com/kubernetes-sigs/ip-masq-agent), которая в кластерах с большим количеством сервисов типа `LoadBalancer` при большом потоке трафика могла приводить к его потере.
* Исправлена ошибка, при которой в некоторых случаях при одновременном создании нескольких групп узлов создавалась только одна группа.
* Обновлена валидация диапазона IP-адресов для сервисов кластера (Service CIDR). Теперь диапазон не может быть шире `/12`.
* Устранена проблема зависания операции остановки кластера пользователем, когда у сервисного аккаунта отсутствовали какие-либо права, например если права у сервисного аккаунта удалились раньше, чем остановился кластер.

### Прочие изменения {#q4-2025-other-changes}

* Добавлена проверка прав на уровне кластера на все операции с кластерами и группами узлов.
* Изменены права доступа к конфигурационным файлам Kubernetes на узлах кластера на более строгие значения для повышения безопасности.
* Отключена возможность удаления ключа шифрования Yandex Key Management Service, если он используется для шифрования в кластере Yandex Managed Service for Kubernetes.

## III квартал 2025 {#q3-2025}

### Новые возможности {#q3-2025-new-features}

* Добавлена возможность выбора [конфигурации мастера](concepts/index.md#master-resources) с помощью [Terraform](../terraform/index.md) и [Yandex Cloud CLI](../cli/index.md) при создании или изменении кластера. Подробнее на странице [Создание кластера Managed Service for Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-create.md).
* Реализован [доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Yandex Identity and Access Management](tutorials/wlif-managed-k8s-integration.md). Теперь токены сервисного аккаунта Kubernetes можно обменивать на IAM-токены Yandex Cloud для простой аутентификации и авторизации в облаке из подов кластера.
* Поддержана возможность аутентификации в [Yandex Cloud Registry](../cloud-registry/index.md) с помощью сервисного аккаунта группы узлов. Для доступа к реестрам Cloud Registry [назначьте](../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту группы узлов [роль](../cloud-registry/security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller`.
* Добавлена поддержка одновременного [увеличения размера](concepts/volume.md#volume-expansion) нескольких постоянных томов, смонтированных на одном узле. Подробнее на странице [Увеличение размера тома для подов](operations/volumes/volume-expansion.md).

### Улучшения {#q3-2025-improvements}

* Поддержан Kubernetes версии [1.33](https://kubernetes.io/blog/2025/04/23/kubernetes-v1-33-release/). Подробнее на странице [Релизные каналы](concepts/release-channels-and-updates.md).
* Среда запуска контейнеров [containerd](https://containerd.io/) обновлена до версии [1.7.27](https://github.com/containerd/containerd/releases/tag/v1.7.27) для кластеров с Kubernetes версии 1.30 и выше.
* Начиная с версии Kubernetes 1.30 операционная система узлов изменилась с Ubuntu 20.04 на Ubuntu 22.04. При обновлении групп узлов в этих версиях новые узлы автоматически создаются из образа виртуальной машины с Ubuntu 22.04. Подробнее на странице [Обновление операционной системы в группе узлов](concepts/node-os-update.md).
* В [Cluster Autoscaler](concepts/autoscale.md#ca) добавлена проверка доступности [зоны](../overview/concepts/geo-scope.md) при выборе группы узлов для масштабирования. Теперь в недоступных зонах не будут выполняться попытки автоматического масштабирования групп узлов.

### Исправления {#q3-2025-problems-solved}

* Исправлена ошибка, в результате которой при изменении ресурсов мастера кластер переходил в статус `Running` до фактического завершения операции изменения.
* Устранена ошибка, которая приводила к нарушению связи мастера с узлами в кластерах с туннельным режимом при миграции мастера из одной подсети в другую. Данная проблема приводила к неработоспособности Kubernetes Webhook и Aggregated API на перенесенном мастере.

### Прочие изменения {#q3-2025-other-changes}

Убрана возможность отключить опцию автоматического увеличения ресурсов мастера при повышении нагрузки. Теперь опция включена для всех кластеров Managed Service for Kubernetes. Из документа [Уровень обслуживания Yandex Managed Service for Kubernetes®](https://yandex.ru/legal/cloud_sla_kb) удалено условие, что в настройках мастера должна быть включена указанная опция.

## II квартал 2025 {#q2-2025}

### Новые возможности {#q2-2025-new-features}

* Поддержан Kubernetes версии [1.32](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.32.md). Подробнее на странице [Релизные каналы](concepts/release-channels-and-updates.md).
* Добавлена возможность указать одно и то же значение для минимального и максимального количества узлов в группе с [автоматическим масштабированием](concepts/node-group/cluster-autoscaler.md). Таким образом можно, не меняя тип группы на фиксированный, добиться фиксированного размера и фактически отключить автоматическое масштабирование.
* Поддержаны [шифрованные диски](concepts/volume.md#encrypted-disks) Yandex Compute Cloud для статической и динамической подготовки постоянных томов.
* Добавлена передача в Yandex Audit Trails [события уровня конфигурации](at-ref.md#control-plane-events) `UpdateClusterCertificate` при обновлении [сертификата кластера](concepts/release-channels-and-updates.md#certificates).
* Обновлен сетевой контроллер [Calico](concepts/network-policy.md#calico) до версии [3.30](https://github.com/projectcalico/calico/blob/release-v3.30/release-notes/v3.30.0-release-notes.md).

### Улучшения {#q2-2025-improvements}

* Реализован механизм принудительного удаления узла в группе с [автоматическим масштабированием](concepts/node-group/cluster-autoscaler.md), если он по каким-то причинам не смог подключиться к кластеру в течение 15 минут. После удаления узел автоматически пересоздается.
* В соответствии с [CIS Kubernetes Benchmarks](https://www.cisecurity.org/benchmark/kubernetes) отключен профайлинг на компонентах мастеров.
* В кластерах с [туннельным режимом](concepts/network-policy.md#cilium) добавлена поддержка [Topology Aware Routing](https://kubernetes.io/docs/concepts/services-networking/topology-aware-routing/) для локализации трафика в одной [зоне доступности](../overview/concepts/geo-scope.md) с целью сокращения сетевых задержек.
* Улучшена безопасность регистрации узлов в кластере: теперь с помощью bootstrap-конфигурации можно выписать сертификат для узла только с самого этого узла, а не из любого другого узла или любого пода.

### Исправления {#q2-2025-problems-solved}

* Исправлена ошибка в сетевом контроллере [Cilium](concepts/network-policy.md#cilium), которая приводила к недоступности сети кластера в случае отказа мастеров. Теперь при полном отказе мастеров сеть и приложения в кластере продолжают работать. Поддерживается только в кластерах с Cilium версии 1.15 и выше (Kubernetes версии 1.31).
* Исправлена ошибка, которая могла приводить к тому, что после окончания срока действия сертификата компоненты мастеров продолжали работать со старым сертификатом.
* Исправлена ошибка, которая могла приводить к невозможности [автоматического масштабирования](concepts/node-group/cluster-autoscaler.md) групп узлов с количеством узлов более 80.
* Исправлена ошибка, которая могла приводить к невозможности обновления [целевых групп](../network-load-balancer/concepts/target-resources.md) Yandex Network Load Balancer для сервисов типа `LoadBalancer`.

## I квартал 2025 {#q1-2025}

### Новые возможности {#q1-2025-new-features}

* Реализована возможность настройки [вычислительных ресурсов](concepts/index.md#master-resources) для мастеров, добавлены соответствующие [квоты](concepts/limits.md#managed-k8s-quotas).
* Обновлены типы конфигураций мастеров: 
  * _Базовый_ — содержит один хост мастера в одной зоне доступности. Прежнее название — _зональный_.
  * _Высокодоступный в трех зонах доступности_ — содержит три хоста мастера в трех разных зонах доступности. Прежнее название — _региональный_.
  * _Высокодоступный в одной зоне доступности_ — содержит три хоста мастера в одной зоне доступности и одной подсети. Новая конфигурация.

  Подробнее в [описании мастера](concepts/index.md#master).

### Исправления и улучшения {#q1-2025-problems-solved}

* Шифрование секретов кластеров в [etcd](https://kubernetes.io/docs/concepts/architecture/#etcd) переключено на [KMS v2](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/#kms-v2).
* Исправлена ошибка, в результате которой в некоторых случаях не удавалось создать кластер Managed Service for Kubernetes с включенной записью логов.
* Изменена особенность, при которой наличие управляемых кластером Managed Service for Kubernetes балансировщиков Network Load Balancer с включенной защитой от удаления блокировало удаление кластера. Теперь процесс удаления кластера не блокируется, а балансировщики остаются в каталоге пользователя.

## IV квартал 2024 {#q4-2024}

### Новые возможности {#q4-2024-new-features}

* Добавлена поддержка Kubernetes версии [1.31](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.31.md). Подробнее на странице [Релизные каналы](concepts/release-channels-and-updates.md).
* Обновлен [Cilium](https://cilium.io/) с версии [1.12.9](https://github.com/cilium/cilium/releases/tag/v1.12.9) до [1.15.10](https://github.com/cilium/cilium/releases/tag/v1.15.10) для кластеров с Kubernetes версии 1.31 и выше.
* Обновлен [CoreDNS](https://coredns.io/) с версии [1.9.4](https://github.com/coredns/coredns/releases/tag/v1.9.4) до [1.11.3](https://github.com/coredns/coredns/releases/tag/v1.11.3) для всех поддерживаемых версий Kubernetes.

### Исправления и улучшения {#q4-2024-problems-solved}

* Добавлена предварительная проверка (_preflight check_) совместимости объектов или конфигураций с новой версией Kubernetes перед обновлением кластера.

  Если при проверке выявляются несовместимые объекты или конфигурации, обновление завершится ошибкой с указанием несовместимых ресурсов и описанием. 

  В текущей реализации проверка проводится только для [сетевых политик Cilium](concepts/network-policy.md#cilium).
* Устранена одна из проблем, которая в некоторых случаях приводила к тому, что не удавалось подключить новый узел к кластеру, и узел навсегда оставался в статусе `NOT_CONNECTED`.

## III квартал 2024 {#q3-2024}

### Новые возможности {#q3-2024-new-features}

Добавлена поддержка миграции [мастеров](concepts/index.md#master) между [подсетями](../vpc/concepts/network.md#subnet) внутри одной [зоны доступности](../overview/concepts/geo-scope.md).

### Исправления и улучшения {#q3-2024-problems-solved}

* Исправлена ошибка, в результате которой не сохранялись файлы аудитных логов кластера с записями размером более 128 КБ. Включена обрезка записей.
* Проведена ревизия [кластерных ролей](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles) (ClusterRole) контроллера сетевых политик [Cilium](concepts/network-policy.md#cilium). Оставлены только минимально необходимые права.
* Добавлена проверка полей `subnet-id` при обновлении [группы узлов](concepts/index.md#node-group) с помощью CLI, Terraform и API. Теперь если в запросе на обновление одновременно указаны параметры `network-interface` и `locations`, требуется, чтобы поля `subnet-id` в `locations` либо были все пустыми, либо полностью совпадали с набором `subnet-id` в `network-interface` (последовательность указания `subnet-id` может быть любой). Если в запросе больше одного элемента в массиве `network-interface`, поля `subnet-id` в `locations` должны быть пустыми.

## I полугодие 2024 {#h1-2024}

### Новые возможности {#h1-2024-new-features}

* Добавлена поддержка Kubernetes версий [1.28](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md), [1.29](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md) и [1.30](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md). Подробнее на странице [Релизные каналы](concepts/release-channels-and-updates.md).
* Обновлены лимиты [CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md) для поддержки дисков объемом более 200 ТБ.

### Исправления и улучшения {#h1-2024-problems-solved}

* Исправлена ошибка, в результате которой мог теряться размер [снапшота](https://kubernetes.io/docs/concepts/storage/volume-snapshots/) при большом размере [PersistentVolume](concepts/volume.md#persistent-volume).
* Исправлена ошибка, в результате которой в некоторых случаях при обновлении [группы узлов](concepts/index.md#node-group) не обновлялись маршруты до [podCIDR](https://kubernetes.io/docs/reference/kubernetes-api/cluster-resources/node-v1/#NodeSpec), из-за чего поды на узле могли быть недоступны.
* Устранен ряд уязвимостей в [runC](https://github.com/opencontainers/runc).
* Исправлена проблема c запуском [кластера](concepts/index.md#kubernetes-cluster) после обновления сертификатов в остановленном состоянии.
* Исправлена ошибка, в результате которой в некоторых случаях узел при создании навсегда оставался в статусе `NOT_CONNECTED`.

## 2023 {#2023}

### Релиз 2023-6 {#2023-6}

В релизных каналах `rapid`, `regular` и `stable` доступны следующие изменения:
* Добавлена поддержка [сверхбыстрых сетевых хранилищ с тремя репликами (SSD)](../compute/concepts/disk.md#disks-types) для [классов хранилищ](operations/volumes/manage-storage-class.md) и [постоянных томов](concepts/volume.md#persistent-volume).
* Появилась возможность использовать группы узлов c [GPU](../compute/concepts/gpus.md) без предустановленных драйверов. Теперь вы можете самостоятельно выбирать подходящую версию драйвера с помощью приложения [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html). Подробнее на странице [Использование групп узлов с GPU без предустановленных драйверов](tutorials/driverless-gpu.md).
* Убрано ограничение ресурса CPU у подов [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/) для предотвращения троттлинга.
* Добавлена поддержка [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md) в CSI-драйвере Kubernetes. Параметры групп размещения доступны для [классов хранилищ](operations/volumes/manage-storage-class.md).
* Исправлена ошибка игнорирования идентификатора [лог-группы](../logging/concepts/log-group.md) при обновлении параметра `master_logging` в кластере.
* Обновлен сетевой контроллер [Calico](concepts/network-policy.md#calico) до версии [3.25](https://docs.tigera.io/archive/v3.25/release-notes/) для версий Kubernetes начиная с 1.24.

### Релиз 2023-5 {#2023-5}

В релизных каналах `rapid`, `regular` и `stable` доступны следующие изменения:
* Исправлена ошибка, при которой Guest Agent на узлах обращался к ресурсу за пределами кластера.
* Обновлена [патч-версия](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#changelog-since-v1273) для Kubernetes версии 1.27.
* Добавлена поддержка Kubernetes версии 1.26.