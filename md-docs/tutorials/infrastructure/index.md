# Руководства по работе с системами управления базовой инфраструктурой

* [Архитектура и защита базового интернет-сервиса](../routing/web-service.md)
* [Анализ поресурсной детализации расходов с помощью Yandex Object Storage](billing-resource-detailing.md)
* [Получение сведений, необходимых для включения ресурса в белый список Минцифры](info-for-federal-ip-whitelist.md)

## Отказоустойчивость и масштабирование {#fault-tolerance}

* [Настройка отказоустойчивой архитектуры в Yandex Cloud](../infrastructure-management/fault-tolerance.md)
* [Отказоустойчивый сайт с балансировкой нагрузки через Yandex Network Load Balancer](../web/load-balancer-website/index.md)
* [Отказоустойчивый сайт с балансировкой нагрузки через Yandex Application Load Balancer](../web/application-load-balancer-website/index.md)
* [Интеграция L7-балансировщика с Yandex Cloud CDN и Yandex Object Storage](../web/cdn-storage-integration/index.md)
* [Работа с группой виртуальных машин с автоматическим масштабированием](../infrastructure-management/vm-autoscale/index.md)
* [Масштабирование группы ВМ по расписанию](../infrastructure-management/vm-scale-scheduled/index.md)
* [Автоматическое масштабирование группы ВМ для обработки сообщений из очереди Yandex Message Queue](../infrastructure-management/autoscale-monitoring.md)
* [Обновление группы ВМ под нагрузкой](../infrastructure-management/updating-under-load.md)
* [Создание триггера для бюджетов, который вызывает функцию Yandex Cloud Functions для остановки ВМ](../infrastructure-management/serverless-trigger-budget-vm.md)
* [Развертывание отказоустойчивой архитектуры с прерываемыми ВМ](nodejs-cron-restart-vm.md)
* [Создание триггеров, которые вызывают функции Yandex Cloud Functions для остановки ВМ и отправки уведомлений в Telegram](../infrastructure-management/serverless-trigger-budget-queue-vm-tg.md)

## Инструменты {#tools}

* [Начало работы с Terraform](../infrastructure-management/terraform-quickstart.md)
* [Источники данных Terraform](../infrastructure-management/terraform-data-sources.md)
* [Загрузка состояний Terraform в Yandex Object Storage](../infrastructure-management/terraform-state-storage.md)
* [Начало работы с Packer](../infrastructure-management/packer-quickstart.md)
* [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](../infrastructure-management/packer-custom-image.md)
* [Блокировка состояний Terraform с помощью Yandex Managed Service for YDB](../infrastructure-management/terraform-state-lock.md)
* [Использование модулей Yandex Cloud в Terraform](../infrastructure-management/terraform-modules.md)
* [Управление ресурсами Kubernetes в кластере Yandex Managed Service for Kubernetes с помощью провайдера Terraform](../infrastructure-management/kubernetes-terraform-provider.md)
* [Создание ВМ и группы ВМ с Container Optimized Image с помощью Terraform](coi-with-terraform.md)
* [Запуск Docker-образа на виртуальной машине](../infrastructure-management/run-docker-on-vm/index.md)
* [Передача логов через HTTP-вход Unified Agent в Yandex Cloud Logging](../infrastructure-management/ua-http-logging.md)
* [Запуск языковой модели DeepSeek-R1 в кластере GPU Yandex Compute Cloud](gpu-cluster-deepseek.md)

## Сеть {#routing}

* [Настройка синхронизации часов с помощью NTP](../infrastructure-management/ntp.md)
* [Настройки DHCP для работы с корпоративным DNS-сервером](../routing/dhcp-options.md)
* [Маршрутизация через NAT-инстанс](../routing/nat-instance/index.md)
* [Установка виртуального роутера Cisco CSR 1000v](../routing/cisco.md)
* [Установка виртуального роутера Mikrotik CHR](../routing/mikrotik.md)

## VPNs {#vpns}

* [Организация сетевой связности с помощью IPsec-шлюзов](../routing/ipsec/index.md)
* [Соединение с облачной сетью при помощи OpenVPN](../routing/openvpn.md)
* [Создание и настройка шлюза UserGate в режиме прокси-сервера](../routing/usergate-proxy.md)

## Yandex Cloud DNS {#dns}

* [Настройка локального кеширующего DNS-резолвера](../infrastructure-management/local-dns-cache.md)
* [Миграция DNS-зон из Яндекс 360 в Cloud DNS](../infrastructure-management/connect-migration.md)
* [Настройка Yandex Cloud DNS для доступа к кластеру Yandex Managed Service for ClickHouse® из других облачных сетей](../dataplatform/clickhouse-dns-peering.md)
* [Интеграция Cloud DNS и корпоративного сервиса DNS](../infrastructure-management/dns-integration.md)
* [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](../infrastructure-management/cert-manager-webhook.md)

## GPU {#gpu}

* [Запуск языковой модели DeepSeek-R1 в кластере GPU](../infrastructure-management/gpu-cluster-deepseek.md)
* [Запуск библиотеки vLLM с языковой моделью Gemma 3 на ВМ с GPU](../infrastructure-management/vllm-gemma-gpu.md)