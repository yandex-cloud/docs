---
title: Сценарии использования сетевой инфраструктуры в {{ yandex-cloud }}
description: Различные сценарии использования сетевой инфраструктуры в {{ yandex-cloud }}.
---

# Руководства по работе с сетевой инфраструктурой в {{ yandex-cloud }}

## Организация VPN-подключений {#sec-vpn}

* [Создание бастионного хоста](bastion.md)
* [Создание туннеля между двумя подсетями при помощи OpenVPN Access Server](site-to-site-openvpn.md)
* [Защищенный доступ пользователей к облачным ресурсам на основе WireGuard VPN](remote-wireguard-vpn.md)
* [Настройка защищенного туннеля GRE поверх IPsec](gre-over-ipsec.md)

## Сетевая облачная инфраструктура на основе NGFW {#sec-ngfw}

* [Сегментация облачной инфраструктуры с помощью решения Check Point Next-Generation Firewall](network-segmentation-checkpoint.md)
* [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](high-accessible-dmz.md)
* [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе UserGate NGFW](high-accessible-dmz-usergate.md)
* [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Смарт-Софт NGFW](high-accessible-dmz-ting.md)
* [Создание и настройка шлюза UserGate в режиме межсетевого экрана](usergate-firewall.md)

## {{ baremetal-name }} {#sec-baremetal}

* [Настройка VRRP для кластера серверов {{ baremetal-name }} с использованием Keepalived](bms-vrf-routing.md)
* [Организация сетевой связности в приватной подсети {{ baremetal-full-name }}](bms-simple-subnet.md)
* [Организация сетевой связности между подсетями {{ baremetal-full-name }} и {{ vpc-full-name }} с помощью {{ interconnect-full-name }}](./bm-vrf-and-vpc-interconnect.md)
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

* [Настройка сетевого взаимодействия ресурсов из разных каталогов](multi-folder-vpc.md)
* [Реализация отказоустойчивых сценариев для сетевых виртуальных машин](route-switcher.md)
* [Настройка сети для {{ dataproc-full-name }}](data-processing-nat-instance.md)
* [Переключение сетевого соединения при пересоздании кластера {{ dataproc-full-name }}](data-processing-dns-reconnect.md)

## Подключение к сервисам {#sec-services-connect}

* [Подключение к {{ objstorage-name }} из {{ vpc-name }}](storage-vpc-access.md)
* [Подключение к {{ container-registry-name }} из {{ vpc-name }}](vpc-cr-access.md)

