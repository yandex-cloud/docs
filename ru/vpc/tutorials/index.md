---
title: Сценарии использования {{ vpc-full-name }}
description: Различные сценарии использования {{ vpc-name }} в {{ yandex-cloud }}.
---

# Практические руководства {{ vpc-name }}

## Организация VPN-подключений {#sec-vpn}

* [Соединение с облачной сетью при помощи OpenVPN](openvpn.md)
* [Создание бастионного хоста](bastion.md)
* [Защищенный доступ пользователей к облачным ресурсам на основе WireGuard VPN](remote-wireguard-vpn.md)
* [Создание туннеля между двумя подсетями при помощи OpenVPN Access Server](site-to-site-openvpn.md)
* [Настройка защищенного туннеля GRE поверх IPsec](gre-over-ipsec.md)
* [Организация сетевой связности с помощью IPsec-шлюзов](ipsec/index.md)

## Сетевая облачная инфраструктура на основе NGFW {#sec-ngfw}

* [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](high-accessible-dmz.md)
* [Сегментация облачной инфраструктуры с помощью решения Check Point Next-Generation Firewall](network-segmentation-checkpoint.md)
* [Создание и настройка шлюза UserGate в режиме прокси-сервера](usergate-proxy.md)
* [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Смарт-Софт NGFW](high-accessible-dmz-ting.md)
* [Создание и настройка шлюза UserGate в режиме межсетевого экрана](usergate-firewall.md)

## {{ baremetal-name }} {#sec-baremetal}

* [Настройка VRRP для кластера серверов {{ baremetal-name }} с использованием Keepalived](bms-vrf-routing.md)
* [Организация сетевой связности в приватной подсети {{ baremetal-full-name }}](bms-simple-subnet.md)
* [Организация сетевой связности между подсетями {{ baremetal-full-name }} и {{ vpc-full-name }} с помощью {{ interconnect-full-name }}](bm-vrf-and-vpc-interconnect.md)
* [Доставка USB-устройств на сервер {{ baremetal-name }} или виртуальную машину {{ compute-name }}](usb-over-ip.md)
* [Настройка межсетевого экрана OPNsense в режиме кластера высокой доступности на серверах {{ baremetal-full-name }}](opnsense-failover-cluster.md)
* [Развертывание веб-приложения на серверах {{ baremetal-full-name }} с L7-балансировщиком и защитой {{ sws-full-name }}](webapp-on-bms-behind-sws.md)

## {{ interconnect-name }} {#sec-interconnect}

* [Организация доступа через {{ interconnect-name }} к облачным сетям, размещенным за NGFW](cic-with-ngfw.md)
* [Создание прямого транкового подключения и приватного соединения в нем](trunk-priv-add.md)
* [Создание прямого транкового подключения и публичного соединения в нем](trunk-pub-add.md)
* [Создание нового партнерского транкового подключения и приватного соединения в нем](partner-trunk-priv-add.md)
* [Создание нового партнерского транкового подключения и публичного соединения в нем](partner-trunk-pub-add.md)
* [Добавление приватного соединения в прямое или партнерское транковое подключение](priv-add.md)
* [Добавление публичного соединения в прямое или партнерское транковое подключение](pub-add.md)
* [Изменение емкости транкового подключения](trunk-capacity-change.md)
* [Удаление приватного соединения](priv-del.md)
* [Удаление публичного соединения](pub-del.md)
* [Удаление транкового подключения](trunk-del.md)

## Настройка сетевых ресурсов и взаимодействие между ними {#sec-network-resources}

* [Архитектура и защита базового интернет-сервиса](web-service.md)
* [Настройка сетевого взаимодействия ресурсов из разных каталогов](multi-folder-vpc.md)
* [Реализация отказоустойчивых сценариев для сетевых виртуальных машин](route-switcher.md)
* [Настройка сети для {{ dataproc-full-name }}](data-processing-nat-instance.md)
* [Переключение сетевого соединения при пересоздании кластера {{ dataproc-full-name }}](data-processing-dns-reconnect.md)
* [Миграция кластера {{ dataproc-full-name }} с файловой системой HDFS в другую зону доступности](hdfs-cluster-migration.md)
* [Настройки DHCP для работы с корпоративным DNS-сервером](dhcp-options.md)
* [Маршрутизация через NAT-инстанс](nat-instance/index.md)
* [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](mssql-alwayson-lb.md)

## Подключение к сервисам {#sec-services-connect}

* [Подключение к {{ objstorage-name }} из {{ vpc-name }}](storage-vpc-access.md)
* [Подключение к {{ container-registry-name }} из {{ vpc-name }}](vpc-cr-access.md)
* [Передача данных топиков {{ KF }} в {{ objstorage-name }} без использования интернета](kafka-topic-s3-sync-private.md)

## Дополнительные настройки и инструменты {#sec-tools}

* [Установка виртуального роутера Cisco CSR 1000v](cisco.md)
* [Установка виртуального роутера Mikrotik CHR](mikrotik.md)
* [Настройка {{ dns-full-name }} для доступа к кластеру {{ mch-full-name }} из других облачных сетей](clickhouse-dns-peering.md)
* [Автоматизация задач {{ yq-full-name }} с помощью {{ maf-full-name }}](airflow-auto-tasks.md)
* [Использование модулей {{ yandex-cloud }} в {{ TF }}](terraform-modules.md)