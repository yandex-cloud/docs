[Документация Yandex Cloud](../../index.md) > [Yandex Virtual Private Cloud](../index.md) > Практические руководства > Все руководства

# Практические руководства Virtual Private Cloud

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

## BareMetal {#sec-baremetal}

* [Настройка VRRP для кластера серверов BareMetal с использованием Keepalived](bms-vrf-routing.md)
* [Организация сетевой связности в приватной подсети Yandex BareMetal](bms-simple-subnet.md)
* [Организация сетевой связности между подсетями Yandex BareMetal и Yandex Virtual Private Cloud с помощью Yandex Cloud Interconnect](bm-vrf-and-vpc-interconnect.md)
* [Доставка USB-устройств на сервер BareMetal или виртуальную машину Compute Cloud](usb-over-ip.md)
* [Настройка межсетевого экрана OPNsense в режиме кластера высокой доступности на серверах Yandex BareMetal](opnsense-failover-cluster.md)
* [Развертывание веб-приложения на серверах Yandex BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security](webapp-on-bms-behind-sws.md)

## Cloud Interconnect {#sec-interconnect}

* [Организация доступа через Cloud Interconnect к облачным сетям, размещенным за NGFW](cic-with-ngfw.md)
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
* [Настройка сети для Yandex Data Processing](data-processing-nat-instance.md)
* [Переключение сетевого соединения при пересоздании кластера Yandex Data Processing](data-processing-dns-reconnect.md)
* [Миграция кластера Yandex Data Processing с файловой системой HDFS в другую зону доступности](hdfs-cluster-migration.md)
* [Настройки DHCP для работы с корпоративным DNS-сервером](dhcp-options.md)
* [Маршрутизация через NAT-инстанс](nat-instance/index.md)
* [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](mssql-alwayson-lb.md)

## Подключение к сервисам {#sec-services-connect}

* [Подключение к Object Storage из Virtual Private Cloud](storage-vpc-access.md)
* [Подключение к Container Registry из Virtual Private Cloud](vpc-cr-access.md)
* [Передача данных топиков Apache Kafka® в Object Storage без использования интернета](kafka-topic-s3-sync-private.md)

## Дополнительные настройки и инструменты {#sec-tools}

* [Установка виртуального роутера Cisco CSR 1000v](cisco.md)
* [Установка виртуального роутера Mikrotik CHR](mikrotik.md)
* [Настройка Yandex Cloud DNS для доступа к кластеру Yandex Managed Service for ClickHouse® из других облачных сетей](clickhouse-dns-peering.md)
* [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](airflow-auto-tasks.md)
* [Использование модулей Yandex Cloud в Terraform](terraform-modules.md)