---
title: "Сценарии использования систем управления базовой инфраструктурой в {{ yandex-cloud }}"
description: "Различные сценарии использования систем управления базовой инфраструктурой в {{ yandex-cloud }}."
---

# Руководства по работе с системами управления базовой инфраструктурой

* [Архитектура и защита базового интернет-сервиса](../routing/web-service.md)

## Отказоустойчивость и масштабирование {#fault-tolerance}

* [Настройка отказоустойчивой архитектуры в {{ yandex-cloud }}](../infrastructure-management/fault-tolerance.md)
* [Отказоустойчивый сайт с балансировкой нагрузки с помощью {{ network-load-balancer-full-name }}](../web/load-balancer-website.md)
* [Отказоустойчивый сайт с балансировкой нагрузки с помощью {{ alb-full-name }}](../web/application-load-balancer-website.md)
* [Интеграция L7-балансировщика с {{ cdn-full-name }} и {{ objstorage-full-name }}](../web/cdn-storage-integration.md)
* [Работа с группой виртуальных машин с автоматическим масштабированием](../infrastructure-management/vm-autoscale.md)
* [Масштабирование группы ВМ по расписанию](../infrastructure-management/vm-scale-scheduled.md)
* [Автоматическое масштабирование группы ВМ для обработки сообщений из очереди {{ message-queue-full-name }}](../infrastructure-management/autoscale-monitoring.md)
* [Обновление группы ВМ под нагрузкой](../infrastructure-management/updating-under-load.md)
* [Создание триггера для бюджетов, который вызывает функцию {{ sf-full-name }} для остановки ВМ](../infrastructure-management/serverless-trigger-budget-vm.md)

## Инструменты {#tools}

* [Начало работы с {{ TF }}](../infrastructure-management/terraform-quickstart.md)
* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](../infrastructure-management/terraform-state-storage.md)
* [Начало работы с Packer](../infrastructure-management/packer-quickstart.md)
* [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](../infrastructure-management/packer-custom-image.md)
* [Блокировка состояний {{ TF }} с помощью {{ ydb-full-name }}](../infrastructure-management/terraform-state-lock.md)
* [Использование модулей {{ yandex-cloud }} в {{ TF }}](../infrastructure-management/terraform-modules.md)

## Сеть {#routing}

* [Настройка синхронизации часов с помощью NTP](../infrastructure-management/ntp.md)
* [Настройки DHCP для работы с корпоративным DNS-сервером](../routing/dhcp-options.md)
* [Маршрутизация с помощью NAT-инстанса](../routing/nat-instance.md)
* [Установка виртуального роутера Cisco CSR 1000v](../routing/cisco.md)
* [Установка виртуального роутера Mikrotik CHR](../routing/mikrotik.md)

## VPNs {#vpns}

* [Организация сетевой связности с помощью IPsec-шлюзов](../routing/ipsec/index.md)
* [Соединение с облачной сетью при помощи OpenVPN](../routing/openvpn.md)
* [Создание и настройка шлюза UserGate в режиме прокси-сервера](../routing/usergate-proxy.md)

## {{ dns-name }} {#dns}

* [Настройка локального кеширующего DNS-резолвера](../infrastructure-management/local-dns-cache.md)
* [Миграция DNS-зон из {{ yandex-360 }} в {{ dns-full-name }}](../infrastructure-management/connect-migration.md)
* [{#T}](../dataplatform/mdb-dns-peering.md)
* [{#T}](../infrastructure-management/dns-integration.md)
* [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](../infrastructure-management/cert-manager-webhook.md)