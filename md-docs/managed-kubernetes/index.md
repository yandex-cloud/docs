# Yandex Managed Service for Kubernetes®

Сервис Managed Service for Kubernetes® предоставляет окружение для работы с <a href="../glossary/containerization.md">контейнеризованными приложениями</a> в инфраструктуре Yandex Cloud. Вы можете разворачивать, масштабировать и управлять приложениями в контейнерах с помощью Kubernetes.

Сервис позволяет предоставлять доступ к приложениям, используя публичные и внутренние <a href="concepts/service.md">сервисы различных типов</a>, а также <a href="operations/applications/marketplace.md">приложения Cloud Marketplace</a>. Все данные надежно хранятся и реплицируются в инфраструктуре Yandex Cloud, но можно дополнительно сделать резервные копии данных из Kubernetes и хранить их в <a href="../storage/index.md">Object Storage</a> или другом хранилище. Для управления Kubernetes используйте командную оболочку <a href="https://kubernetes.io/ru/docs/tasks/tools/install-kubectl">kubectl</a>.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ. Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_kb">Уровень обслуживания Yandex Managed Service for Kubernetes®</a>.

# Yandex Managed Service for Kubernetes

 - [Сопоставление с другими сервисами Yandex Cloud](service-comparison.md)

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Подключение к узлу по SSH](operations/node-connect-ssh.md)

 - [Подключение к узлу через OS Login](operations/node-connect-oslogin.md)

 - [Обновление Kubernetes](operations/update-kubernetes.md)

 - [Настройка автомасштабирования](operations/autoscale.md)

 - [Подключение Terraform-провайдера Kubernetes](operations/apply-tf-provider.md)

 - [Установка приложений из Yandex Cloud Marketplace с помощью Terraform](operations/apply-helm-provider.md)

 - [Работа с приватными реестрами Docker-образов](operations/private-registries.md)

### Подключение к кластеру

 - [Обзор способов подключения](operations/connect/index.md)

 - [Настройка групп безопасности](operations/connect/security-groups.md)

 - [Создание статического файла конфигурации](operations/connect/create-static-conf.md)

### Установка приложений из Cloud Marketplace

 - [Основы работы с Cloud Marketplace](operations/applications/marketplace.md)

 - [Установка Битрикс](operations/applications/bitrix.md)

 - [Установка Argo CD](operations/applications/argo-cd.md)

 - [Установка Chaos Mesh](operations/applications/chaos-mesh.md)

 - [Установка cert-manager c плагином Cloud DNS ACME webhook](operations/applications/cert-manager-cloud-dns.md)

 - [Установка Container Storage Interface для S3](operations/applications/csi-s3.md)

 - [Установка Crossplane](operations/applications/crossplane.md)

 - [Установка External Secrets Operator](operations/applications/external-secrets-operator.md)

 - [Установка ExternalDNS c Webhook Cloud DNS](operations/applications/externaldns.md)

 - [Установка Falco](operations/applications/falco.md)

 - [Установка Filebeat OSS](operations/applications/filebeat-oss.md)

 - [Установка Fluent Bit](operations/applications/fluentbit.md)

 - [Установка Gatekeeper](operations/applications/gatekeeper.md)

 - [Установка Gateway API](operations/applications/gateway-api.md)

 - [Установка GitLab Agent](operations/applications/gitlab-agent.md)

 - [Установка GitLab Runner](operations/applications/gitlab-runner.md)

 - [Установка Gwin](alb-ref/gwin-quickstart.md)

 - [Установка HashiCorp Vault](operations/applications/hashicorp-vault.md)

 - [Установка Ingress-контроллера Application Load Balancer](operations/applications/alb-ingress-controller.md)

 - [Обновление Ingress-контроллера Application Load Balancer](operations/applications/upgrade-alb-ingress-controller.md)

 - [Установка Istio](operations/applications/istio.md)

 - [Установка KEDA](operations/applications/keda.md)

 - [Установка Kubernetes Node Remediation](operations/applications/kubernetes-node-remediation.md)

 - [Установка Kyverno & Kyverno Policies](operations/applications/kyverno.md)

 - [Установка Loki](operations/applications/loki.md)

 - [Установка Metrics Provider](operations/applications/metrics-provider.md)

 - [Установка NodeLocal DNS](operations/applications/node-local-dns.md)

 - [Установка node-sitter](operations/applications/node-sitter.md)

 - [Установка Prometheus Operator](operations/applications/prometheus-operator.md)

 - [Установка Thumbor](operations/applications/thumbor.md)

 - [Установка Velero](operations/applications/velero-yc-csi.md)

### Сетевые сценарии

 - [Обеспечение доступа к приложению, запущенному в кластере Kubernetes](operations/create-load-balancer.md)

 - [Настройка контроллера сетевых политик Calico](operations/calico.md)

 - [Настройка контроллера сетевых политик Cilium](operations/cilium.md)

 - [Настройка NodeLocal DNS для контроллера сетевых политик Cilium](operations/cilium-node-local-dns.md)

### Работа с постоянными томами

 - [Динамическая подготовка тома](operations/volumes/dynamic-create-pv.md)

 - [Статическая подготовка тома](operations/volumes/static-create-pv.md)

 - [Управление классами хранилищ](operations/volumes/manage-storage-class.md)

 - [Зашифрованные диски для постоянных томов](operations/volumes/encrypted-disks.md)

 - [Увеличение размера тома для подов](operations/volumes/volume-expansion.md)

 - [Подключение тома в блочном режиме](operations/volumes/mode-block.md)

 - [Интеграция с Object Storage](operations/volumes/s3-csi-integration.md)

### Управление кластером Kubernetes

 - [Получение информации о кластере Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-list.md)

 - [Посмотреть операции с кластером Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-operation-logs.md)

 - [Создание кластера Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-create.md)

 - [Изменение кластера Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-update.md)

 - [Управление доступом к кластеру Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-access.md)

 - [Поддержка федерации сервисных аккаунтов IAM в кластере Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-wlif-integration.md)

 - [Получение списка доступных конфигураций мастера в кластере Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md)

 - [Мониторинг состояния кластера Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-get-stats.md)

 - [Удаление кластера Kubernetes](operations/kubernetes-cluster/kubernetes-cluster-delete.md)

### Управление группой узлов

 - [Информация об имеющихся группах узлов](operations/node-group/node-group-list.md)

 - [Создание группы узлов](operations/node-group/node-group-create.md)

 - [Создание группы с узлами из пула резервов ВМ](operations/node-group/node-group-create-in-instance-pool.md)

 - [Подключение к узлу по SSH](operations/node-connect-ssh.md)

 - [Подключение к узлу через OS Login](operations/node-connect-oslogin.md)

 - [Настройка автомасштабирования](operations/autoscale.md)

 - [Изменение группы узлов](operations/node-group/node-group-update.md)

 - [Управление Kubernetes-метками узлов](operations/node-group/node-label-management.md)

 - [Удаление группы узлов](operations/node-group/node-group-delete.md)

### Работа с внешними узлами

 - [Подключение внешних узлов к кластеру](operations/external-nodes-connect.md)

 - [Настройка WireGuard-шлюзов для подключения внешних узлов к кластеру](operations/external-nodes-connect-wireguard.md)

 - [Настройка IPSec-шлюзов для подключения внешних узлов к кластеру](operations/external-nodes-connect-ipsec.md)

 - [Подключение сервера BareMetal как внешнего узла](operations/bms-server-connect.md)

### Работа с объектами Kubernetes из консоли управления

 - [Подключение к терминалу запущенного контейнера](operations/kubernetes-console/pod-terminal.md)

 - [Управление размещением подов на узлах](operations/kubernetes-console/nodes.md)

 - [Управление рабочими нагрузками](operations/kubernetes-console/workloads.md)

 - [Управление хранилищами](operations/kubernetes-console/storage.md)

 - [Управление ресурсами Service и Ingress](operations/kubernetes-console/network.md)

 - [Управление ресурсами ConfigMap и Secret](operations/kubernetes-console/configuration.md)

 - [Управление сервисными аккаунтами Kubernetes](operations/kubernetes-console/access.md)

 - [Управление пространствами имен](operations/kubernetes-cluster/kubernetes-cluster-namespace-create.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Создание нового Kubernetes-проекта в Yandex Cloud](tutorials/new-kubernetes-project.md)

 - [Создание кластера Kubernetes без доступа в интернет](tutorials/k8s-cluster-with-no-internet.md)

 - [Запуск рабочих нагрузок с GPU](tutorials/running-pod-gpu.md)

 - [Использование групп узлов c GPU без предустановленных драйверов](tutorials/driverless-gpu.md)

 - [Установка Time-Slicing GPUs](tutorials/time-slicing-gpu.md)

 - [Миграция ресурсов в другую зону доступности](tutorials/migration-to-an-availability-zone.md)

### Создание проекта с помощью Terraform

 - [Управление ресурсами Kubernetes с помощью провайдера Terraform](tutorials/kubernetes-terraform-provider.md)

 - [Использование модулей Yandex Cloud в Terraform](tutorials/terraform-modules.md)

 - [Шифрование секретов в Managed Service for Kubernetes](tutorials/kms-k8s.md)

 - [Создание кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API](tutorials/k8s-cluster-api-provider-yandex.md)

 - [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов](tutorials/wlif-managed-k8s-integration.md)

### Настройка и тестирование масштабирования

 - [Горизонтальное масштабирование приложения в кластере](tutorials/autoscaling.md)

 - [Вертикальное масштабирование приложения в кластере](tutorials/vpa-autoscaling.md)

### Использование Container Registry

 - [Интеграция с Container Registry](tutorials/container-registry.md)

 - [Подпись и проверка Docker-образов Container Registry](tutorials/sign-cr-with-cosign.md)

 - [Хранение Docker-образов из проектов Managed Service for GitLab](tutorials/image-storage.md)

### Использование Managed Service for Apache Kafka®

 - [Развертывание веб-интерфейса Apache Kafka®](tutorials/deploy-kafka-ui.md)

### Непрерывная интеграция с GitLab

 - [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](tutorials/gitlab-containers.md)

 - [Сканирование уязвимостей Container Registry при непрерывном развертывании приложений с помощью GitLab](tutorials/cr-scanner-with-k8s-and-gitlab.md)

 - [Построение пайплайна CI/CD в GitLab с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

### Работа с DNS

 - [Интеграция с корпоративной зоной DNS](tutorials/custom-dns.md)

 - [Автоматическое масштабирование DNS по размеру кластера](tutorials/dns-autoscaler.md)

 - [Настройка NodeLocal DNS Cache](tutorials/node-local-dns.md)

 - [Проверка DNS Challenge для сертификатов Let's Encrypt®](tutorials/dnschallenge.md)

 - [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](tutorials/cert-manager-webhook.md)

### Резервное копирование

 - [Резервное копирование в Object Storage](tutorials/kubernetes-backup.md)

 - [Работа со снапшотами](tutorials/pvc-snapshot-restore.md)

### Мониторинг

 - [Мониторинг кластера с помощью Prometheus Operator с поддержкой Yandex Monitoring](tutorials/prometheus-grafana-monitoring.md)

 - [Мониторинг кластера Managed Service for Kubernetes с помощью Filebeat OSS](tutorials/filebeat-oss-monitoring.md)

 - [Передача логов кластера Managed Service for Kubernetes в Cloud Logging](tutorials/k8s-fluent-bit-logging.md)

### Использование продуктов Cloud Marketplace

 - [Интеграция с Argo CD](tutorials/marketplace/argo-cd.md)

 - [Интеграция с Crossplane](tutorials/marketplace/crossplane.md)

 - [Синхронизация с секретами Yandex Lockbox](tutorials/kubernetes-lockbox-secrets.md)

 - [Настройка Fluent Bit для работы с Cloud Logging](tutorials/fluent-bit-logging.md)

 - [Настройка Gateway API](tutorials/marketplace/gateway-api.md)

 - [Настройка L7-балансировщика Application Load Balancer с помощью Ingress-контроллера](tutorials/alb-ingress-controller.md)

 - [Настройка логирования для L7-балансировщика Application Load Balancer с помощью Ingress-контроллера](tutorials/alb-ingress-controller-log-options.md)

 - [Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer](tutorials/alb-ingress-with-sws-profile.md)

 - [Проверка состояния приложений в кластере Managed Service for Kubernetes с помощью L7-балансировщика Application Load Balancer](tutorials/custom-health-checks.md)

 - [Настройка Kyverno & Kyverno Policies](tutorials/marketplace/kyverno.md)

 - [Использование Metrics Provider для трансляции метрик](tutorials/marketplace/metrics-provider.md)

 - [Редактирование изображений для сайтов с помощью Thumbor](tutorials/marketplace/thumbor.md)

 - [Использование Istio](tutorials/marketplace/istio.md)

 - [Использование HashiCorp Vault для хранения секретов](tutorials/marketplace/hashicorp-vault.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Релизные каналы и обновления](concepts/release-channels-and-updates.md)

 - [Поддержка версий Kubernetes](concepts/k8s-supported-versions.md)

 - [Разграничение зон контроля в Managed Service for Kubernetes](concepts/kubernetes-responsibilities.md)

 - [Обновление операционной системы в группе узлов](concepts/node-os-update.md)

 - [Шифрование](concepts/encryption.md)

### Использование объектов API Kubernetes

 - [Том](concepts/volume.md)

 - [Сервис](concepts/service.md)

### Группа узлов

 - [Автоматическое масштабирование группы узлов](concepts/node-group/cluster-autoscaler.md)

 - [Политика развертывания группы узлов](concepts/node-group/deploy-policy.md)

 - [Расселение подов с узла](concepts/node-group/node-drain.md)

 - [Динамическое резервирование ресурсов для узла](concepts/node-group/allocatable-resources.md)

 - [Группы узлов с GPU](concepts/node-group/node-group-gpu.md)

 - [Пулы резервов виртуальных машин для групп узлов](concepts/node-group/reserved-pools.md)

 - [Переменные в шаблоне узла](concepts/node-group/variables-in-the-template.md)

 - [Сеть в Managed Service for Kubernetes](concepts/network.md)

 - [Сетевые настройки и политики кластера](concepts/network-policy.md)

 - [Автоматическое масштабирование](concepts/autoscale.md)

 - [Политика аудита](concepts/audit-policy.md)

 - [Внешние узлы кластера](concepts/external-nodes.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Рекомендации по использованию Managed Service for Kubernetes](concepts/usage-recommendations.md)

 - [Рекомендуемые конфигурации мастера](concepts/master-configuration.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [add-labels](cli-ref/cluster/add-labels.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [get-credentials](cli-ref/cluster/get-credentials.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-node-groups](cli-ref/cluster/list-node-groups.md)

 - [list-nodes](cli-ref/cluster/list-nodes.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/cluster/reschedule-maintenance.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

 - [create-token](cli-ref/create-token.md)

 - [list-versions](cli-ref/list-versions.md)

### marketplace

 - [Overview](cli-ref/marketplace/index.md)

#### helm-release

 - [Overview](cli-ref/marketplace/helm-release/index.md)

 - [get](cli-ref/marketplace/helm-release/get.md)

 - [install](cli-ref/marketplace/helm-release/install.md)

 - [list](cli-ref/marketplace/helm-release/list.md)

 - [uninstall](cli-ref/marketplace/helm-release/uninstall.md)

 - [update](cli-ref/marketplace/helm-release/update.md)

### node-group

 - [Overview](cli-ref/node-group/index.md)

 - [add-labels](cli-ref/node-group/add-labels.md)

 - [add-metadata](cli-ref/node-group/add-metadata.md)

 - [add-node-labels](cli-ref/node-group/add-node-labels.md)

 - [create](cli-ref/node-group/create.md)

 - [delete](cli-ref/node-group/delete.md)

 - [get](cli-ref/node-group/get.md)

 - [list](cli-ref/node-group/list.md)

 - [list-nodes](cli-ref/node-group/list-nodes.md)

 - [list-operations](cli-ref/node-group/list-operations.md)

 - [remove-labels](cli-ref/node-group/remove-labels.md)

 - [remove-metadata](cli-ref/node-group/remove-metadata.md)

 - [remove-node-labels](cli-ref/node-group/remove-node-labels.md)

 - [update](cli-ref/node-group/update.md)

### resource-preset

 - [Overview](cli-ref/resource-preset/index.md)

 - [get](cli-ref/resource-preset/get.md)

 - [list](cli-ref/resource-preset/list.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [add-labels](cli-ref/v0/cluster/add-labels.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [get-credentials](cli-ref/v0/cluster/get-credentials.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-node-groups](cli-ref/v0/cluster/list-node-groups.md)

 - [list-nodes](cli-ref/v0/cluster/list-nodes.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/v0/cluster/reschedule-maintenance.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [create-token](cli-ref/v0/create-token.md)

 - [list-versions](cli-ref/v0/list-versions.md)

#### marketplace

 - [Overview](cli-ref/v0/marketplace/index.md)

##### helm-release

 - [Overview](cli-ref/v0/marketplace/helm-release/index.md)

 - [get](cli-ref/v0/marketplace/helm-release/get.md)

 - [install](cli-ref/v0/marketplace/helm-release/install.md)

 - [list](cli-ref/v0/marketplace/helm-release/list.md)

 - [uninstall](cli-ref/v0/marketplace/helm-release/uninstall.md)

 - [update](cli-ref/v0/marketplace/helm-release/update.md)

#### node-group

 - [Overview](cli-ref/v0/node-group/index.md)

 - [add-labels](cli-ref/v0/node-group/add-labels.md)

 - [add-metadata](cli-ref/v0/node-group/add-metadata.md)

 - [add-node-labels](cli-ref/v0/node-group/add-node-labels.md)

 - [create](cli-ref/v0/node-group/create.md)

 - [delete](cli-ref/v0/node-group/delete.md)

 - [get](cli-ref/v0/node-group/get.md)

 - [list](cli-ref/v0/node-group/list.md)

 - [list-nodes](cli-ref/v0/node-group/list-nodes.md)

 - [list-operations](cli-ref/v0/node-group/list-operations.md)

 - [remove-labels](cli-ref/v0/node-group/remove-labels.md)

 - [remove-metadata](cli-ref/v0/node-group/remove-metadata.md)

 - [remove-node-labels](cli-ref/v0/node-group/remove-node-labels.md)

 - [update](cli-ref/v0/node-group/update.md)

#### resource-preset

 - [Overview](cli-ref/v0/resource-preset/index.md)

 - [get](cli-ref/v0/resource-preset/get.md)

 - [list](cli-ref/v0/resource-preset/list.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### Managed Service for Kubernetes gRPC (англ.)

 - [Overview](managed-kubernetes/api-ref/grpc/index.md)

#### Cluster

 - [Overview](managed-kubernetes/api-ref/grpc/Cluster/index.md)

 - [Get](managed-kubernetes/api-ref/grpc/Cluster/get.md)

 - [List](managed-kubernetes/api-ref/grpc/Cluster/list.md)

 - [Create](managed-kubernetes/api-ref/grpc/Cluster/create.md)

 - [Update](managed-kubernetes/api-ref/grpc/Cluster/update.md)

 - [Delete](managed-kubernetes/api-ref/grpc/Cluster/delete.md)

 - [Stop](managed-kubernetes/api-ref/grpc/Cluster/stop.md)

 - [Start](managed-kubernetes/api-ref/grpc/Cluster/start.md)

 - [RescheduleMaintenance](managed-kubernetes/api-ref/grpc/Cluster/rescheduleMaintenance.md)

 - [ListNodeGroups](managed-kubernetes/api-ref/grpc/Cluster/listNodeGroups.md)

 - [ListOperations](managed-kubernetes/api-ref/grpc/Cluster/listOperations.md)

 - [ListNodes](managed-kubernetes/api-ref/grpc/Cluster/listNodes.md)

 - [ListAccessBindings](managed-kubernetes/api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](managed-kubernetes/api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](managed-kubernetes/api-ref/grpc/Cluster/updateAccessBindings.md)

#### NodeGroup

 - [Overview](managed-kubernetes/api-ref/grpc/NodeGroup/index.md)

 - [Get](managed-kubernetes/api-ref/grpc/NodeGroup/get.md)

 - [List](managed-kubernetes/api-ref/grpc/NodeGroup/list.md)

 - [Create](managed-kubernetes/api-ref/grpc/NodeGroup/create.md)

 - [Update](managed-kubernetes/api-ref/grpc/NodeGroup/update.md)

 - [Delete](managed-kubernetes/api-ref/grpc/NodeGroup/delete.md)

 - [ListOperations](managed-kubernetes/api-ref/grpc/NodeGroup/listOperations.md)

 - [ListNodes](managed-kubernetes/api-ref/grpc/NodeGroup/listNodes.md)

#### Operation

 - [Overview](managed-kubernetes/api-ref/grpc/Operation/index.md)

 - [Get](managed-kubernetes/api-ref/grpc/Operation/get.md)

 - [Cancel](managed-kubernetes/api-ref/grpc/Operation/cancel.md)

#### ResourcePreset

 - [Overview](managed-kubernetes/api-ref/grpc/ResourcePreset/index.md)

 - [Get](managed-kubernetes/api-ref/grpc/ResourcePreset/get.md)

 - [List](managed-kubernetes/api-ref/grpc/ResourcePreset/list.md)

#### Version

 - [Overview](managed-kubernetes/api-ref/grpc/Version/index.md)

 - [List](managed-kubernetes/api-ref/grpc/Version/list.md)

### Managed Service for Kubernetes REST (англ.)

 - [Overview](managed-kubernetes/api-ref/index.md)

#### Cluster

 - [Overview](managed-kubernetes/api-ref/Cluster/index.md)

 - [Get](managed-kubernetes/api-ref/Cluster/get.md)

 - [List](managed-kubernetes/api-ref/Cluster/list.md)

 - [Create](managed-kubernetes/api-ref/Cluster/create.md)

 - [Update](managed-kubernetes/api-ref/Cluster/update.md)

 - [Delete](managed-kubernetes/api-ref/Cluster/delete.md)

 - [Stop](managed-kubernetes/api-ref/Cluster/stop.md)

 - [Start](managed-kubernetes/api-ref/Cluster/start.md)

 - [RescheduleMaintenance](managed-kubernetes/api-ref/Cluster/rescheduleMaintenance.md)

 - [ListNodeGroups](managed-kubernetes/api-ref/Cluster/listNodeGroups.md)

 - [ListOperations](managed-kubernetes/api-ref/Cluster/listOperations.md)

 - [ListNodes](managed-kubernetes/api-ref/Cluster/listNodes.md)

 - [ListAccessBindings](managed-kubernetes/api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](managed-kubernetes/api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](managed-kubernetes/api-ref/Cluster/updateAccessBindings.md)

#### NodeGroup

 - [Overview](managed-kubernetes/api-ref/NodeGroup/index.md)

 - [Get](managed-kubernetes/api-ref/NodeGroup/get.md)

 - [List](managed-kubernetes/api-ref/NodeGroup/list.md)

 - [Create](managed-kubernetes/api-ref/NodeGroup/create.md)

 - [Update](managed-kubernetes/api-ref/NodeGroup/update.md)

 - [Delete](managed-kubernetes/api-ref/NodeGroup/delete.md)

 - [ListOperations](managed-kubernetes/api-ref/NodeGroup/listOperations.md)

 - [ListNodes](managed-kubernetes/api-ref/NodeGroup/listNodes.md)

#### Operation

 - [Overview](managed-kubernetes/api-ref/Operation/index.md)

 - [Get](managed-kubernetes/api-ref/Operation/get.md)

 - [Cancel](managed-kubernetes/api-ref/Operation/cancel.md)

#### Version

 - [Overview](managed-kubernetes/api-ref/Version/index.md)

 - [List](managed-kubernetes/api-ref/Version/list.md)

### Kubernetes Marketplace gRPC (англ.)

 - [Overview](kubernetes-marketplace/api-ref/grpc/index.md)

#### HelmRelease

 - [Overview](kubernetes-marketplace/api-ref/grpc/HelmRelease/index.md)

 - [List](kubernetes-marketplace/api-ref/grpc/HelmRelease/list.md)

 - [Get](kubernetes-marketplace/api-ref/grpc/HelmRelease/get.md)

 - [Install](kubernetes-marketplace/api-ref/grpc/HelmRelease/install.md)

 - [Update](kubernetes-marketplace/api-ref/grpc/HelmRelease/update.md)

 - [Uninstall](kubernetes-marketplace/api-ref/grpc/HelmRelease/uninstall.md)

#### Operation

 - [Overview](kubernetes-marketplace/api-ref/grpc/Operation/index.md)

 - [Get](kubernetes-marketplace/api-ref/grpc/Operation/get.md)

 - [Cancel](kubernetes-marketplace/api-ref/grpc/Operation/cancel.md)

### Kubernetes Marketplace REST (англ.)

 - [Overview](kubernetes-marketplace/api-ref/index.md)

#### HelmRelease

 - [Overview](kubernetes-marketplace/api-ref/HelmRelease/index.md)

 - [List](kubernetes-marketplace/api-ref/HelmRelease/list.md)

 - [Get](kubernetes-marketplace/api-ref/HelmRelease/get.md)

 - [Install](kubernetes-marketplace/api-ref/HelmRelease/install.md)

 - [Update](kubernetes-marketplace/api-ref/HelmRelease/update.md)

 - [Uninstall](kubernetes-marketplace/api-ref/HelmRelease/uninstall.md)

#### Operation

 - [Overview](kubernetes-marketplace/api-ref/Operation/index.md)

 - [Get](kubernetes-marketplace/api-ref/Operation/get.md)

 - [Cancel](kubernetes-marketplace/api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

## Инструменты Application Load Balancer

 - [Обзор](alb-ref/index.md)

### Gwin

 - [Обзор](alb-ref/gwin-index.md)

 - [Политики Gwin](alb-ref/gwin-policies.md)

 - [Установка Gwin](alb-ref/gwin-quickstart.md)

 - [Миграция приложений с ALB Ingress-контроллера на Gwin](alb-ref/ingress-gwin-migration.md)

 - [Миграция приложений с Ingress NGINX на Gwin](alb-ref/nginx-gwin-migration.md)

 - [Механизм Attachment для интеграции Gwin с Application Load Balancer](alb-ref/gwin-alb-attachment.md)

#### Конфигурация ресурсов (англ.)

 - [Gateway](gwin-ref/gateway.md)

 - [GatewayPolicy](gwin-ref/gatewaypolicy.md)

 - [GRPCRoute](gwin-ref/grpcroute.md)

 - [HTTPRoute](gwin-ref/httproute.md)

 - [Ingress](gwin-ref/ingress.md)

 - [IngressBackendGroup](gwin-ref/ingressbackendgroup.md)

 - [IngressPolicy](gwin-ref/ingresspolicy.md)

 - [RoutePolicy](gwin-ref/routepolicy.md)

 - [Service](gwin-ref/service.md)

 - [ServicePolicy](gwin-ref/servicepolicy.md)

 - [TLSRoute](gwin-ref/tlsroute.md)

 - [YCCertificate](gwin-ref/yccertificate.md)

 - [YCStorageBucket](gwin-ref/ycstoragebucket.md)

### Ingress-контроллер

 - [Обзор](alb-ref/ingress-controller/index.md)

 - [Принципы работы](alb-ref/ingress-controller/principles.md)

 - [Установить Ingress-контроллер](operations/applications/alb-ingress-controller.md)

 - [Обновить Ingress-контроллер](operations/applications/upgrade-alb-ingress-controller.md)

#### Конфигурация ресурсов

 - [Ingress](alb-ref/ingress.md)

 - [HttpBackendGroup](alb-ref/http-backend-group.md)

 - [GrpcBackendGroup](alb-ref/grpc-backend-group.md)

 - [IngressClass](alb-ref/ingress-class.md)

 - [Service для Ingress](alb-ref/service-for-ingress.md)

### Gateway API

 - [Обзор](alb-ref/gateway-api/index.md)

 - [Установить Gateway API](operations/applications/gateway-api.md)

#### Конфигурация ресурсов

 - [Gateway](alb-ref/gateway.md)

 - [GatewayPolicy](alb-ref/gateway-policy.md)

 - [HTTPRoute](alb-ref/http-route.md)

 - [GRPCRoute](alb-ref/grpc-route.md)

 - [RoutePolicy](alb-ref/route-policy.md)

 - [TLSRoute](alb-ref/tls-route.md)

 - [Service для Gateway API](alb-ref/service-for-gateway.md)

 - [YCCertificate](alb-ref/yc-certificate.md)

 - [YCStorageBucket](alb-ref/yc-storage-bucket.md)

 - [Настройка групп безопасности](alb-ref/security-groups.md)

 - [Работа с сервисными аккаунтами](alb-ref/service-account.md)

 - [Создание и изменение ресурсов по конфигурации](alb-ref/k8s-ingress-controller-apply.md)

## Инструменты Network Load Balancer

 - [Обзор](nlb-ref/index.md)

 - [Service](nlb-ref/service.md)

 - [NetworkPolicy](nlb-ref/networkpolicy.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Хранилище данных](qa/volumes.md)

 - [Настройка и обновление](qa/settings.md)

 - [Автоматическое масштабирование](qa/cluster-autoscaler.md)

 - [Ресурсы](qa/resources.md)

 - [Мониторинг и логи](qa/logs.md)

 - [Решение проблем](qa/troubleshooting.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)