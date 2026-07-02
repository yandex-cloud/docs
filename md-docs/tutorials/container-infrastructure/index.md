[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Контейнерная инфраструктура > Все руководства

# Руководства по работе с контейнерной инфраструктурой

* [Настройка подключения к Yandex Managed Service for PostgreSQL из контейнера Serverless Containers](container-pg-connect.md)
* [Создание ВМ с Container Optimized Image](vm-create.md)
* [Создание ВМ с Container Optimized Image и дополнительным томом для Docker-контейнера](vm-create-with-second-disk.md)
* [Создание ВМ с Container Optimized Image и несколькими Docker-контейнерами](docker-compose.md)
* [Создать группу ВМ с Container Optimized Image](ig-create.md)
* [Создание группы виртуальных машин с Container Optimized Image и несколькими Docker-контейнерами](ig-with-containers.md)
* [Изменить ВМ с Container Optimized Image](vm-update.md)
* [Настройка вывода информации из Docker-контейнера в серийный порт](serial-port.md)
* [Запуск Docker-образа на виртуальной машине с помощью Yandex Cloud Registry](docker-cloud-registry.md)

## Managed Service for Kubernetes {#k8s}

### Создание и настройка проекта {#creating-project}

* [Создание нового Kubernetes-проекта в Yandex Managed Service for Kubernetes](new-kubernetes-project.md)
* [Создание и настройка кластера Managed Service for Kubernetes без доступа в интернет](k8s-cluster-with-no-internet.md)
* [Запуск рабочих нагрузок с GPU в Yandex Managed Service for Kubernetes](running-pod-gpu.md)
* [Использование групп узлов Yandex Managed Service for Kubernetes c GPU без предустановленных драйверов](driverless-gpu.md)
* [Установка Time-Slicing GPUs в Yandex Managed Service for Kubernetes](time-slicing-gpu.md)
* [Миграция ресурсов Yandex Managed Service for Kubernetes в другую зону доступности](migration-to-an-availability-zone.md)
* [Шифрование секретов в Yandex Managed Service for Kubernetes](kms-k8s.md)
* [Создание управляемого пользователем (self-managed) кластера Kubernetes с помощью провайдера Yandex Cloud для Kubernetes Cluster API](k8s-cluster-api-provider-yandex.md)
* [Подключение сервера Yandex BareMetal как внешнего узла к кластеру Yandex Managed Service for Kubernetes](k8s-connect-bms-as-node.md)

### Настройка и тестирование масштабирования {#scaling}

* [Горизонтальное масштабирование приложения в кластере Yandex Managed Service for Kubernetes](autoscaling.md)
* [Вертикальное масштабирование приложения в кластере Yandex Managed Service for Kubernetes](vpa-autoscaling.md)

### Использование Yandex Container Registry {#container-registry}

* [Интеграция Managed Service for Kubernetes с Container Registry](container-registry.md)
* [Подпись и проверка Docker-образов Yandex Container Registry в Yandex Managed Service for Kubernetes](sign-cr-with-cosign.md)
* [Хранение Docker-образов из проектов Yandex Managed Service for GitLab](image-storage.md)

### Непрерывная интеграция с GitLab {#gitlab}

* [Сканирование уязвимостей при непрерывном развертывании приложений Managed Service for Kubernetes с помощью GitLab](cr-scanner-with-k8s-and-gitlab.md)

### Работа с DNS {#dns}

* [Интеграция Yandex Managed Service for Kubernetes с корпоративной зоной DNS](custom-dns.md)
* [Автоматическое масштабирование кластера Yandex Managed Service for Kubernetes DNS по размеру кластера](dns-autoscaler.md)
* [Настройка NodeLocal DNS Yandex Managed Service for Kubernetes](node-local-dns.md)
* [Проверка DNS Challenge для сертификатов Let's Encrypt® в Yandex Managed Service for Kubernetes](dnschallenge.md)

## Резервное копирование {#backup}

* [Работа со снапшотами Compute Cloud в Yandex Managed Service for Kubernetes](pvc-snapshot-restore.md)


### Мониторинг {#monitoring}

* [Мониторинг кластера Yandex Managed Service for Kubernetes с помощью Prometheus Operator с поддержкой Yandex Monitoring](prometheus-grafana-monitoring.md)
* [Мониторинг кластера Yandex Managed Service for Kubernetes с помощью Filebeat OSS](filebeat-oss-monitoring.md)

### Использование продуктов Yandex Cloud Marketplace {#marketplace-tutorials}

* [Интеграция Yandex Managed Service for Kubernetes с Argo CD](argo-cd.md)
* [Интеграция Yandex Managed Service for Kubernetes с Crossplane](crossplane.md)
* [Синхронизация секретов Yandex Lockbox и Yandex Managed Service for Kubernetes](kubernetes-lockbox-secrets.md)
* [Передача логов кластера Yandex Managed Service for Kubernetes в Yandex Cloud Logging](k8s-fluent-bit-logging.md)
* [Настройка Gateway API в Yandex Managed Service for Kubernetes](gateway-api.md)
* [Настройка L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера](alb-ingress-controller.md)
* [Настройка логирования для L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера](alb-ingress-controller-log-options.md)
* [Проверка состояния приложений в кластере Yandex Managed Service for Kubernetes с помощью L7-балансировщика Yandex Application Load Balancer](custom-health-checks.md)
* [Настройка Kyverno & Kyverno Policies в Yandex Managed Service for Kubernetes](kyverno.md)
* [Использование Metrics Provider для трансляции метрик Yandex Managed Service for Kubernetes](metrics-provider.md)
* [Редактирование изображений для сайтов с помощью приложения Thumbor в Yandex Managed Service for Kubernetes](thumbor.md)
* [Использование Istio в Yandex Managed Service for Kubernetes](istio.md)
* [Использование HashiCorp Vault для хранения секретов в Yandex Managed Service for Kubernetes](hashicorp-vault.md)