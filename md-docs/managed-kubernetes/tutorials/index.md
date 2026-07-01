# Практические руководства Managed Service for Kubernetes

C помощью Managed Service for Kubernetes вы можете работать с [контейнеризованными приложениями](../../glossary/containerization.md) в инфраструктуре Yandex Cloud: разворачивать, масштабировать и управлять приложениями в контейнерах.

## Создание и настройка проекта {#creating-project}

* [Создание нового Kubernetes-проекта в Yandex Cloud](new-kubernetes-project.md)
* [Создание и настройка кластера Kubernetes без доступа в интернет](k8s-cluster-with-no-internet.md)
* [Управление ресурсами Kubernetes в кластере Managed Service for Kubernetes с помощью провайдера Terraform](kubernetes-terraform-provider.md)
* [Запуск рабочих нагрузок с GPU](running-pod-gpu.md)
* [Использование групп узлов с GPU без предустановленных драйверов](driverless-gpu.md)
* [Установка Time-Slicing GPUs](time-slicing-gpu.md)
* [Миграция ресурсов Kubernetes в другую зону доступности](migration-to-an-availability-zone.md)
* [Шифрование секретов в Managed Service for Kubernetes](kms-k8s.md)
* [Создание управляемого пользователем (self-managed) кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API](k8s-cluster-api-provider-yandex.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](wlif-managed-k8s-integration.md)

### Создание проекта с помощью Terraform {#terraform}

* [Управление ресурсами Kubernetes в кластере Managed Service for Kubernetes с помощью провайдера Terraform](kubernetes-terraform-provider.md)
* [Использование модулей Yandex Cloud в Terraform](terraform-modules.md)

## Настройка и тестирование масштабирования {#scaling}

* [Горизонтальное масштабирование приложения в кластере](autoscaling.md)
* [Вертикальное масштабирование приложения в кластере](vpa-autoscaling.md)

## Использование Yandex Container Registry {#container-registry}

* [Интеграция с Container Registry](container-registry.md)
* [Подпись и проверка Docker-образов Yandex Container Registry в Managed Service for Kubernetes](sign-cr-with-cosign.md)
* [Хранение Docker-образов из проектов Yandex Managed Service for GitLab](image-storage.md)

## Использование Managed Service for Apache Kafka® {#kafka}

[Развертывание веб-интерфейса Apache Kafka®](deploy-kafka-ui.md)

## Непрерывная интеграция с GitLab {#gitlab}

* [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](gitlab-containers.md)
* [Сканирование уязвимостей Container Registry при непрерывном развертывании приложений с помощью GitLab](cr-scanner-with-k8s-and-gitlab.md)
* [Построение пайплайна CI/CD с использованием serverless-продуктов](ci-cd-serverless.md)

## Работа с DNS {#dns}

* [Интеграция с корпоративной зоной DNS](custom-dns.md)
* [Автоматическое масштабирование DNS по размеру кластера](dns-autoscaler.md)
* [Настройка NodeLocal DNS](node-local-dns.md)
* [Проверка DNS Challenge для сертификатов Let's Encrypt®](dnschallenge.md)
* [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](cert-manager-webhook.md)

## Резервное копирование {#backup}

* [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](kubernetes-backup.md)
* [Работа со снапшотами](pvc-snapshot-restore.md)


## Мониторинг {#monitoring}

* [Мониторинг кластера с помощью Prometheus Operator с поддержкой Yandex Monitoring](prometheus-grafana-monitoring.md)
* [Передача логов кластера Managed Service for Kubernetes в Yandex Cloud Logging](k8s-fluent-bit-logging.md)
* [Мониторинг кластера с помощью Filebeat OSS](filebeat-oss-monitoring.md)

## Использование продуктов Yandex Cloud Marketplace {#marketplace-tutorials}

* [Интеграция с Argo CD](marketplace/argo-cd.md)
* [Интеграция с Crossplane](marketplace/crossplane.md)
* [Синхронизация с секретами Yandex Lockbox](kubernetes-lockbox-secrets.md)
* [Настройка Fluent Bit для работы с Yandex Cloud Logging](fluent-bit-logging.md)
* [Настройка Gateway API](marketplace/gateway-api.md)
* [Настройка L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера](alb-ingress-controller.md)
* [Настройка логирования для L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера](alb-ingress-controller-log-options.md)
* [Проверка состояния приложений в кластере Yandex Managed Service for Kubernetes с помощью L7-балансировщика Yandex Application Load Balancer](custom-health-checks.md)
* [Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer](alb-ingress-with-sws-profile.md)
* [Настройка Kyverno & Kyverno Policies](marketplace/kyverno.md)
* [Использование Metrics Provider для трансляции метрик](marketplace/metrics-provider.md)
* [Редактирование изображений для сайтов с помощью приложения Thumbor](marketplace/thumbor.md)
* [Использование Istio](marketplace/istio.md)
* [Использование HashiCorp Vault для хранения секретов](marketplace/hashicorp-vault.md)