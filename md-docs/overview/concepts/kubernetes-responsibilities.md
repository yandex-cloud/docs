# Разграничение зон контроля пользователей Yandex Managed Service for Kubernetes и Yandex Cloud

# Разграничение зон контроля пользователей Yandex Managed Service for Kubernetes и Yandex Cloud

Модель разделения ответственности (Shared Responsibility Model) для Managed Service for Kubernetes в Yandex Cloud распределяет зоны контроля между облачным провайдером и пользователем.

## Зона контроля Yandex Cloud {#yandex-cloud-responsibility}

В зону контроля Yandex Cloud входят:

* [Управляемый Control Plane](#master-nodes).
* [Резервное копирование и восстановление](#backup-restore).
* [Обслуживание кластера](#maintenance).
* [Инфраструктура кластера](#infrastructure).
* [Системные плагины](#system-plugins).

### Управляемый Control Plane {#master-nodes}

Yandex Cloud управляет всеми компонентами [Control Plane](../../glossary/control-plane.md) в Kubernetes и отвечает за их корректную работу. Таким образом обеспечивается заявленная функциональность:

* Отказоустойчивая работа кластера или компонентов Control Plane при выборе [типа мастера](../../managed-kubernetes/concepts/index.md#master) **Высокодоступный** с размещением хостов в трех зонах доступности.
* Процесс обновления компонентов Control Plane в автоматическом режиме или по запросу пользователя при наличии свежих версий.
* Мониторинг компонентов Control Plane, реакция на алерты кластеров Managed Service for Kubernetes по проблемам на уровне Control Plane.
* Сбор и хранение логов Control Plane при включенной настройке **Запись логов**.

{% note info %}

Пользователь не может изменять конфигурацию компонентов Control Plane напрямую. Влияние на конфигурацию ограничено опциями, доступными при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md). Например, пользователь может включить [интеграцию с федерацией сервисных аккаунтов](../../managed-kubernetes/tutorials/wlif-managed-k8s-integration.md) на уровне кластера Managed Service for Kubernetes.

{% endnote %}

[Подробнее о компонентах Control Plane в Kubernetes](https://kubernetes.io/docs/concepts/architecture/#control-plane-components).

### Резервное копирование и восстановление {#backup-restore}

Yandex Cloud обеспечивает мониторинг, резервное копирование и восстановление etcd.

### Обслуживание кластера {#maintenance}

Yandex Cloud обеспечивает выпуск обновлений безопасности:

* для компонентов Control Plane;
* для операционной системы ВМ мастера и узлов при обнаружении уязвимостей;
* для системных компонентов на узлах.

### Инфраструктура кластера {#infrastructure}

Yandex Cloud управляет следующими компонентами инфраструктуры кластера:

* **Сеть**. Yandex Cloud обеспечивает создание, настройку и удаление сетевых балансировщиков [Yandex Network Load Balancer](../../managed-kubernetes/nlb-ref/index.md) с помощью объекта `Service` с типом `LoadBalancer`.

* **Хранилище**. Yandex Cloud обеспечивает создание, настройку, подключение к подам и удаление сетевых дисков Yandex Cloud с помощью объектов `PersistentVolume`.

* **Системные компоненты на узлах**. Yandex Cloud устанавливает на [узлы](../../managed-kubernetes/concepts/index.md#node-group) следующие компоненты:

   * Сервисы `kubelet` и `kube-proxy` (опционально).
   * Среда запуска контейнеров.
   * Сетевые плагины CNI (Calico / Cilium).
   * CSI-драйверы для интеграции с облачным хранилищем.
   * Гостевая операционная система (Ubuntu).

* **Вычислительная и сетевая инфраструктура виртуальных машин**. Yandex Cloud обеспечивает инфраструктуру виртуальных машин, на которых располагаются мастер и узлы.

* **Интеграция с другими сервисами Yandex Cloud**. Обеспечивается взаимодействие с сервисами [Yandex Identity and Access Management](../../iam/index.md), [Yandex Virtual Private Cloud](../../vpc/index.md), [Yandex Container Registry](../../container-registry/index.md), шифрование через [Yandex Key Management Service](../../kms/index.md).

### Системные плагины {#system-plugins}

{% note info %}

Пользователь не может изменять или удалять системные плагины.

{% endnote %}

Для Managed Service for Kubernetes используются системные плагины под управлением Yandex Cloud:

* **csi-driver** — ресурс `DaemonSet`, который устанавливается на все узлы кластера и обеспечивает работу [csi-driver](https://kubernetes-csi.github.io/docs/csi-driver-object.html).
* **[kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)** — поддерживает сетевые правила на узлах. Эти правила разрешают сетевое взаимодействие с подами из сетевых сессий внутри и снаружи кластера.
* **[coreDNS](https://coredns.io/)** — основной DNS-сервер, отвечающий за разрешение имен внутри кластера Kubernetes.
* **[calico](https://github.com/projectcalico/calico)** — управляет [сетевыми политиками](../../managed-kubernetes/concepts/network-policy.md) и обеспечивает сетевое взаимодействие между подами.
* **[cilium](https://cilium.io/)** — управляет [сетевыми политиками](../../managed-kubernetes/concepts/network-policy.md). Включает в себя компоненты cilium-cni, cilium-agent, cilium-operator, hubble. При использовании замещает плагин kube-proxy.
* **[cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler)** — управляет [автоматическим масштабированием](../../managed-kubernetes/concepts/autoscale.md#ca) групп узлов.
* **[metrics-server](https://github.com/kubernetes-sigs/metrics-server)** — собирает метрики использования ресурсов (CPU, RAM) с узлов, подов и ограниченно мастеров.
* **node-problem-detector** — обнаруживает проблемы на узлах кластера и сообщает о них.
* **nvidia-device-plugin** — позволяет узлам кластера автоматически предоставлять и управлять графическими процессорами (GPU) для приложений в контейнерах.
* **ip-masq-agent** — управляет [маскарадингом IP-адресов](../../managed-kubernetes/concepts/index.md#pod-ip-masquerade) в кластере, чтобы контейнеры могли взаимодействовать с внешними сервисами, а узлы кластера могли обращаться к внешним IP-адресам.
* **metadata-server** — ресурс `DaemonSet`, который устанавливается на все узлы кластера и обеспечивает автоматический обмен JWT-токена [сервисного аккаунта](../../managed-kubernetes/concepts/index.md#service-accounts) Kubernetes на IAM-токен облачного сервисного аккаунта.
* **bindings** — роли для системных компонентов кластера.

{% note info %}

Состав системных плагинов может видоизменяться и дополняться.

{% endnote %}

## Зона контроля клиентов Yandex Cloud {#client-responsibility}

В зону контроля клиентов Yandex Cloud входят:

* [Конфигурация кластера](#cluster-config).
* [Ресурсы кластера](#node-groups-config).
* [Конфигурируемые ресурсы](#configured-resources).
* [Управление доступом](#access-control).
* [Анализ работы кластера](#cluster-monitoring).
* [Самостоятельное обновление версий ПО](#software-updates).

### Конфигурация кластера {#cluster-config}

Пользователь управляет конфигурацией кластера, к которой относятся:

* Схема размещения хостов мастера — базовый или высокодоступный мастер (в одной или разных зонах доступности).
* Версия Kubernetes для мастера и [релизный канал](../../managed-kubernetes/concepts/release-channels-and-updates.md).
* Конфигурация сети (сеть, подсети, публичный адрес, группы безопасности, сетевые политики, туннельный режим и т. д.).
* Сервисные аккаунты с необходимыми правами для ресурсов и узлов.
* [Ключи шифрования](../../managed-kubernetes/concepts/encryption.md).
* [Вычислительные ресурсы мастера](../../managed-kubernetes/concepts/index.md#master-resources) (тип платформы, vCPU, RAM).
* Настройка [окна обновлений](../../managed-kubernetes/operations/update-kubernetes.md) кластера.
* Включение логирования Control Plane: [аудитные логи](../../managed-kubernetes/at-ref.md), логи [Cluster Autoscaler](../../managed-kubernetes/concepts/autoscale.md), логи событий, логи API-сервера Kubernetes.

   {% note info %}

   Если пользователь не включил поставку логов Control Plane кластеров в Cloud Logging или Audit Trails, при возникновении инцидентов и других событий хранение логов на стороне сервиса ограничено по времени и размеру:

   * Аудитные логи хранятся не более 5 дней или до достижения размера 5 ГБ.
   * Другие системные логи хранятся не более 1 дня или до достижения размера 7 ГБ.

   {% endnote %}

### Ресурсы кластера {#node-groups-config}

Пользователь управляет конфигурацией и содержимым узлов:

* Вычислительные ресурсы узлов (тип платформы, vCPU, RAM, размер и тип дисков и т. д.).
* Конфигурация сети (публичный адрес, группы безопасности, подсети и зоны доступности).
* Настройка масштабирования для групп узлов.
* Версия Kubernetes для групп узлов.
* Установка дополнительных пакетов/агентов.
* Настройка доступа к узлам (SSH, [OS Login](../../organization/concepts/os-login.md)).
* Настройка метаданных, переменных `sysctl` и др.
* Настройка окна обновлений групп узлов.

{% note warning %}

Пользователи имеют полный доступ к узлам кластера Managed Service for Kubernetes и могут изменять системные компоненты, пакеты и их конфигурации. Это может привести к непредсказуемым последствиям и нарушению работы узлов. Не рекомендуется вносить такие изменения для групп узлов.

{% endnote %}

### Конфигурируемые ресурсы {#configured-resources}

Пользователь может управлять следующими ресурсами:

* Конфигурация некоторых плагинов. Доступно изменение ресурсов `ConfigMap` в плагинах **ip-masq-agent** и **coreDNS**.

* Приложения:

   * Развертывание `Deployment`, `StatefulSet`, `DaemonSet` и других объектов в кластерах Kubernetes.
   * Управление Ingress-контроллерами (например, [NGINX Ingress](https://kubernetes.github.io/ingress-nginx/)).

* Данные:

   * Резервное копирование данных приложений ([Persistent Volumes](../../managed-kubernetes/concepts/volume.md#persistent-volume)).
   * [Шифрование секретов](../../managed-kubernetes/concepts/encryption.md#k8s-secrets-encryption) и данных на уровне приложения.

### Управление доступом {#access-control}

Пользователь может управлять доступом при помощи Kubernetes RBAC:

* Настраивать `ServiceAccounts`, `ClusterRoles` и другие объекты Kubernetes.
* Управлять правами доступа к кластеру.

### Анализ работы кластера {#cluster-monitoring}

Пользователь может использовать мониторинг и логирование для анализа работы кластера:

* Настраивать алерты для метрик приложений.
* Анализировать логи подов с помощью [Fluent Bit](../../managed-kubernetes/operations/applications/fluentbit.md) или сторонних инструментов.

### Самостоятельное обновление версий ПО {#software-updates}

Пользователь может:

* Обновлять группы узлов на новые минорные версии Kubernetes, доступные в сервисе Managed Service for Kubernetes, например с версии 1.32 на 1.33.
* Отслеживать уязвимости на уровне приложений в кластере, в том числе:

   * Сканировать и обновлять образы контейнеров пользовательских приложений.
   * Устранять уязвимости в пользовательском коде и зависимостях.
   * Применять Pod Security Policies или аналоги для ограничения привилегий подов.