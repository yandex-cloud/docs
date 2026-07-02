[Документация Yandex Cloud](../index.md) > Yandex Virtual Private Cloud > Yandex Virtual Private Cloud

# Yandex Virtual Private Cloud

Yandex Virtual Private Cloud служит для управления облачными сетями и связи облачных ресурсов между собой и с интернетом. Virtual Private Cloud позволяет создавать <a href="concepts/network.md#network">сети</a>, <a href="concepts/network.md#subnet">подсети</a> в зонах доступности Yandex Cloud, назначать облачным ресурсам внутренние и публичные <a href="concepts/address.md">IP-адреса</a>,  а также предоставляет возможность защиты от DDoS-атак с помощью компонента <a href="ddos-protection/index.md">DDoS-Protection.</a>

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_yvpc">Уровень обслуживания Yandex Virtual Private Cloud</a>.

# Yandex Virtual Private Cloud

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Облачная сеть

 - [Создать облачную сеть](operations/network-create.md)

 - [Удалить облачную сеть](operations/network-delete.md)

 - [Изменить облачную сеть](operations/network-update.md)

 - [Получить информацию об облачной сети](operations/network-get-info.md)

 - [Изучить карту облачной сети](operations/network-map.md)

 - [Перенести облачную сеть между каталогами](operations/network-move.md)

### Подсеть

 - [Создать подсеть](operations/subnet-create.md)

 - [Удалить подсеть](operations/subnet-delete.md)

 - [Изменить подсеть](operations/subnet-update.md)

 - [Получить информацию о подсети](operations/subnet-get-info.md)

 - [Перенести подсеть между каталогами](operations/subnet-move.md)

 - [Посмотреть список используемых адресов](operations/subnet-used-addresses.md)

### IP-адрес

 - [Зарезервировать статический публичный IP-адрес](operations/get-static-ip.md)

 - [Зарезервировать внутренний IP-адрес](operations/private-ip-reserve.md)

 - [Сделать динамический публичный IP-адрес статическим](operations/set-static-ip.md)

 - [Сделать статический публичный IP-адрес динамическим](operations/set-dynamic-ip.md)

 - [Настроить защиту от удаления](operations/deletion-protection.md)

 - [Перенести адрес между каталогами](operations/address-move.md)

 - [Получить информацию об IP-адресе](operations/address-get-info.md)

 - [Удалить статический публичный IP-адрес](operations/address-delete.md)

 - [Удалить внутренний IP-адрес](operations/private-ip-delete.md)

### Статическая маршрутизация

 - [Создать статический маршрут](operations/static-route-create.md)

 - [Создать и настроить NAT-шлюз](operations/create-nat-gateway.md)

 - [Получить информацию о NAT-шлюзе](operations/get-info-nat-gateway.md)

 - [Перенести таблицу маршрутизации между каталогами](operations/static-route-move.md)

 - [Получить информацию о таблице маршрутизации](operations/route-table-get-info.md)

 - [Перенести NAT-шлюз между каталогами](operations/static-gateway-move.md)

 - [Удалить таблицу маршрутизации](operations/delete-route-table.md)

 - [Удалить NAT-шлюз](operations/delete-nat-gateway.md)

### Сервисные подключения

 - [Создать сервисное подключение](operations/private-endpoint-create.md)

 - [Получить информацию о сервисном подключении](operations/private-endpoint-get-info.md)

 - [Назначить политику доступа в Object Storage для сервисного подключения](operations/private-endpoint-storage-policy.md)

 - [Настроить ограничение в Object Storage для доступа только из сервисных подключений](operations/private-endpoint-storage-restriction.md)

 - [Удалить сервисное подключение](operations/private-endpoint-delete.md)

### Группы безопасности

 - [Создать группу безопасности](operations/security-group-create.md)

 - [Изменить имя и описание](operations/security-group-update.md)

 - [Добавить новое правило](operations/security-group-add-rule.md)

 - [Получить информацию о группе безопасности](operations/security-group-get-info.md)

 - [Удалить правило](operations/security-group-delete-rule.md)

 - [Перенести группу безопасности между каталогами](operations/security-group-move.md)

 - [Удалить группу безопасности](operations/security-group-delete.md)

 - [Включить программно ускоренную сеть](operations/enable-software-accelerated-network.md)

### Защита от DDoS-атак

 - [Включить защиту от DDoS-атак](operations/enable-ddos-protection.md)

 - [Настроить MTU при включении защиты от DDoS-атак](operations/adjust-mtu-ddos-protection.md)

 - [График сетевых соединений](operations/connections-view.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Организация VPN-подключений

 - [Соединение с облачной сетью при помощи OpenVPN](tutorials/openvpn.md)

 - [Создание бастионного хоста](tutorials/bastion.md)

 - [Защищенный доступ пользователей к облачным ресурсам на основе WireGuard VPN](tutorials/remote-wireguard-vpn.md)

 - [Создание туннеля между двумя подсетями при помощи OpenVPN Access Server](tutorials/site-to-site-openvpn.md)

 - [Настройка защищенного туннеля GRE поверх IPsec](tutorials/gre-over-ipsec.md)

#### Организация сетевой связности с помощью IPsec-шлюзов

 - [Схема решения](tutorials/ipsec/index.md)

 - [Самостоятельная реализация средствами Yandex Cloud](tutorials/ipsec/ipsec-vpn.md)

 - [Развертывание S2S VPN с помощью strongSwan в Yandex Cloud](tutorials/ipsec/s2s-vpn.md)

 - [Решение SGW от команды архитекторов Yandex Cloud](tutorials/ipsec/sgw.md)

 - [ViPNet Coordinator в Yandex Cloud](tutorials/vipnet-to-yc.md)

### Сетевая облачная инфраструктура на основе NGFW

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](tutorials/high-accessible-dmz.md)

 - [Сегментация облачной инфраструктуры с помощью решения Check Point Next-Generation Firewall](tutorials/network-segmentation-checkpoint.md)

 - [Создание и настройка шлюза UserGate в режиме прокси-сервера](tutorials/usergate-proxy.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Смарт-Софт NGFW](tutorials/high-accessible-dmz-ting.md)

 - [Создание и настройка шлюза UserGate в режиме межсетевого экрана](tutorials/usergate-firewall.md)

### BareMetal

 - [Настройка VRRP для кластера серверов BareMetal с использованием Keepalived](tutorials/bms-vrf-routing.md)

 - [Организация сетевой связности в приватной подсети Yandex BareMetal](tutorials/bms-simple-subnet.md)

 - [Организация сетевой связности между подсетями Yandex BareMetal и Yandex Virtual Private Cloud с помощью Yandex Cloud Interconnect](tutorials/bm-vrf-and-vpc-interconnect.md)

 - [Доставка USB-устройств на сервер BareMetal или виртуальную машину Compute Cloud](tutorials/usb-over-ip.md)

 - [Настройка межсетевого экрана OPNsense в режиме кластера высокой доступности на серверах Yandex BareMetal](tutorials/opnsense-failover-cluster.md)

 - [Развертывание веб-приложения на серверах Yandex BareMetal с L7-балансировщиком и защитой Yandex Smart Web Security](tutorials/webapp-on-bms-behind-sws.md)

### Cloud Interconnect

 - [Организация доступа через Cloud Interconnect к облачным сетям, размещенным за NGFW](tutorials/cic-with-ngfw.md)

 - [Создание прямого транкового подключения и приватного соединения в нем](tutorials/trunk-priv-add.md)

 - [Создание прямого транкового подключения и публичного соединения в нем](tutorials/trunk-pub-add.md)

 - [Создание нового партнерского транкового подключения и приватного соединения в нем](tutorials/partner-trunk-priv-add.md)

 - [Создание нового партнерского транкового подключения и публичного соединения в нем](tutorials/partner-trunk-pub-add.md)

 - [Добавление приватного соединения в прямое или партнерское транковое подключение](tutorials/priv-add.md)

 - [Добавление публичного соединения в прямое или партнерское транковое подключение](tutorials/pub-add.md)

 - [Изменение емкости транкового подключения](tutorials/trunk-capacity-change.md)

 - [Удаление приватного соединения](tutorials/priv-del.md)

 - [Удаление публичного соединения](tutorials/pub-del.md)

 - [Удаление транкового подключения](tutorials/trunk-del.md)

### Настройка сетевых ресурсов и взаимодействие между ними

 - [Архитектура и защита базового интернет-сервиса](tutorials/web-service.md)

 - [Настройки DHCP для работы с корпоративным DNS-сервером](tutorials/dhcp-options.md)

#### Маршрутизация через NAT-инстанс

 - [Обзор](tutorials/nat-instance/index.md)

 - [Консоль управления](tutorials/nat-instance/console.md)

 - [Terraform](tutorials/nat-instance/terraform.md)

 - [Настройка сетевого взаимодействия ресурсов из разных каталогов](tutorials/multi-folder-vpc.md)

 - [Реализация отказоустойчивых сценариев для сетевых виртуальных машин](tutorials/route-switcher.md)

 - [Настройка сети для Yandex Data Processing](tutorials/data-processing-nat-instance.md)

 - [Переключение сетевого соединения при пересоздании кластера Yandex Data Processing](tutorials/data-processing-dns-reconnect.md)

 - [Миграция кластера Yandex Data Processing с файловой системой HDFS в другую зону доступности](tutorials/hdfs-cluster-migration.md)

 - [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](tutorials/mssql-alwayson-lb.md)

### Подключение к сервисам

 - [Подключение к Object Storage из Virtual Private Cloud](tutorials/storage-vpc-access.md)

 - [Подключение к Container Registry из Virtual Private Cloud](tutorials/vpc-cr-access.md)

 - [Синхронизация топиков Apache Kafka® в Object Storage без использования интернета](tutorials/kafka-topic-s3-sync-private.md)

### Дополнительные настройки и инструменты

 - [Установка виртуального роутера Cisco CSR 1000v](tutorials/cisco.md)

 - [Установка виртуального роутера Mikrotik CHR](tutorials/mikrotik.md)

 - [Настройка Cloud DNS для доступа к кластеру Managed Service for ClickHouse® из других облачных сетей](tutorials/clickhouse-dns-peering.md)

 - [Автоматизация задач Query с помощью Managed Service for Apache Airflow™](tutorials/airflow-auto-tasks.md)

 - [Использование модулей Yandex Cloud в Terraform](tutorials/terraform-modules.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Устройство сети в Yandex Cloud](concepts/network-overview.md)

 - [Облачные сети и подсети](concepts/network.md)

 - [Адреса облачных ресурсов](concepts/address.md)

 - [Маршрутизация](concepts/routing.md)

 - [Группы безопасности](concepts/security-groups.md)

 - [Шлюзы](concepts/gateways.md)

 - [Сервисные подключения](concepts/private-endpoint.md)

 - [Мониторинг сетевых соединений](concepts/monitoring-connections.md)

 - [Диапазоны публичных IP-адресов](concepts/ips.md)

 - [MTU и MSS](concepts/mtu-mss.md)

 - [Настройки DHCP](concepts/dhcp-options.md)

 - [Программно ускоренная сеть](concepts/software-accelerated-network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [DDoS Protection](ddos-protection/index.md)

## Рекомендации

 - [Использование публичных IP-адресов](best-practices/public-ip-recommendations.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### address

 - [Overview](cli-ref/address/index.md)

 - [create](cli-ref/address/create.md)

 - [delete](cli-ref/address/delete.md)

 - [get](cli-ref/address/get.md)

 - [list](cli-ref/address/list.md)

 - [list-by-subnet](cli-ref/address/list-by-subnet.md)

 - [list-operations](cli-ref/address/list-operations.md)

 - [move](cli-ref/address/move.md)

 - [update](cli-ref/address/update.md)

### gateway

 - [Overview](cli-ref/gateway/index.md)

 - [add-labels](cli-ref/gateway/add-labels.md)

 - [create](cli-ref/gateway/create.md)

 - [delete](cli-ref/gateway/delete.md)

 - [get](cli-ref/gateway/get.md)

 - [list](cli-ref/gateway/list.md)

 - [list-operations](cli-ref/gateway/list-operations.md)

 - [move](cli-ref/gateway/move.md)

 - [remove-labels](cli-ref/gateway/remove-labels.md)

 - [update](cli-ref/gateway/update.md)

### network

 - [Overview](cli-ref/network/index.md)

 - [add-labels](cli-ref/network/add-labels.md)

 - [create](cli-ref/network/create.md)

 - [delete](cli-ref/network/delete.md)

 - [get](cli-ref/network/get.md)

 - [list](cli-ref/network/list.md)

 - [list-operations](cli-ref/network/list-operations.md)

 - [list-route-tables](cli-ref/network/list-route-tables.md)

 - [list-security-groups](cli-ref/network/list-security-groups.md)

 - [list-subnets](cli-ref/network/list-subnets.md)

 - [move](cli-ref/network/move.md)

 - [remove-labels](cli-ref/network/remove-labels.md)

 - [update](cli-ref/network/update.md)

### private-endpoint

 - [Overview](cli-ref/private-endpoint/index.md)

 - [create](cli-ref/private-endpoint/create.md)

 - [delete](cli-ref/private-endpoint/delete.md)

 - [get](cli-ref/private-endpoint/get.md)

 - [list](cli-ref/private-endpoint/list.md)

 - [list-operations](cli-ref/private-endpoint/list-operations.md)

 - [update](cli-ref/private-endpoint/update.md)

### route-table

 - [Overview](cli-ref/route-table/index.md)

 - [add-labels](cli-ref/route-table/add-labels.md)

 - [create](cli-ref/route-table/create.md)

 - [delete](cli-ref/route-table/delete.md)

 - [get](cli-ref/route-table/get.md)

 - [list](cli-ref/route-table/list.md)

 - [list-operations](cli-ref/route-table/list-operations.md)

 - [move](cli-ref/route-table/move.md)

 - [remove-labels](cli-ref/route-table/remove-labels.md)

 - [update](cli-ref/route-table/update.md)

### security-group

 - [Overview](cli-ref/security-group/index.md)

 - [add-labels](cli-ref/security-group/add-labels.md)

 - [create](cli-ref/security-group/create.md)

 - [delete](cli-ref/security-group/delete.md)

 - [get](cli-ref/security-group/get.md)

 - [list](cli-ref/security-group/list.md)

 - [list-operations](cli-ref/security-group/list-operations.md)

 - [move](cli-ref/security-group/move.md)

 - [remove-labels](cli-ref/security-group/remove-labels.md)

 - [update](cli-ref/security-group/update.md)

 - [update-rule-meta](cli-ref/security-group/update-rule-meta.md)

 - [update-rules](cli-ref/security-group/update-rules.md)

### subnet

 - [Overview](cli-ref/subnet/index.md)

 - [add-labels](cli-ref/subnet/add-labels.md)

 - [add-range](cli-ref/subnet/add-range.md)

 - [create](cli-ref/subnet/create.md)

 - [delete](cli-ref/subnet/delete.md)

 - [get](cli-ref/subnet/get.md)

 - [list](cli-ref/subnet/list.md)

 - [list-operations](cli-ref/subnet/list-operations.md)

 - [list-used-addresses](cli-ref/subnet/list-used-addresses.md)

 - [move](cli-ref/subnet/move.md)

 - [relocate](cli-ref/subnet/relocate.md)

 - [remove-labels](cli-ref/subnet/remove-labels.md)

 - [remove-range](cli-ref/subnet/remove-range.md)

 - [update](cli-ref/subnet/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### address

 - [Overview](cli-ref/v0/address/index.md)

 - [create](cli-ref/v0/address/create.md)

 - [delete](cli-ref/v0/address/delete.md)

 - [get](cli-ref/v0/address/get.md)

 - [list](cli-ref/v0/address/list.md)

 - [list-by-subnet](cli-ref/v0/address/list-by-subnet.md)

 - [list-operations](cli-ref/v0/address/list-operations.md)

 - [move](cli-ref/v0/address/move.md)

 - [update](cli-ref/v0/address/update.md)

#### gateway

 - [Overview](cli-ref/v0/gateway/index.md)

 - [add-labels](cli-ref/v0/gateway/add-labels.md)

 - [create](cli-ref/v0/gateway/create.md)

 - [delete](cli-ref/v0/gateway/delete.md)

 - [get](cli-ref/v0/gateway/get.md)

 - [list](cli-ref/v0/gateway/list.md)

 - [list-operations](cli-ref/v0/gateway/list-operations.md)

 - [move](cli-ref/v0/gateway/move.md)

 - [remove-labels](cli-ref/v0/gateway/remove-labels.md)

 - [update](cli-ref/v0/gateway/update.md)

#### network

 - [Overview](cli-ref/v0/network/index.md)

 - [add-labels](cli-ref/v0/network/add-labels.md)

 - [create](cli-ref/v0/network/create.md)

 - [delete](cli-ref/v0/network/delete.md)

 - [get](cli-ref/v0/network/get.md)

 - [list](cli-ref/v0/network/list.md)

 - [list-operations](cli-ref/v0/network/list-operations.md)

 - [list-route-tables](cli-ref/v0/network/list-route-tables.md)

 - [list-security-groups](cli-ref/v0/network/list-security-groups.md)

 - [list-subnets](cli-ref/v0/network/list-subnets.md)

 - [move](cli-ref/v0/network/move.md)

 - [remove-labels](cli-ref/v0/network/remove-labels.md)

 - [update](cli-ref/v0/network/update.md)

#### private-endpoint

 - [Overview](cli-ref/v0/private-endpoint/index.md)

 - [create](cli-ref/v0/private-endpoint/create.md)

 - [delete](cli-ref/v0/private-endpoint/delete.md)

 - [get](cli-ref/v0/private-endpoint/get.md)

 - [list](cli-ref/v0/private-endpoint/list.md)

 - [list-operations](cli-ref/v0/private-endpoint/list-operations.md)

 - [update](cli-ref/v0/private-endpoint/update.md)

#### route-table

 - [Overview](cli-ref/v0/route-table/index.md)

 - [add-labels](cli-ref/v0/route-table/add-labels.md)

 - [create](cli-ref/v0/route-table/create.md)

 - [delete](cli-ref/v0/route-table/delete.md)

 - [get](cli-ref/v0/route-table/get.md)

 - [list](cli-ref/v0/route-table/list.md)

 - [list-operations](cli-ref/v0/route-table/list-operations.md)

 - [move](cli-ref/v0/route-table/move.md)

 - [remove-labels](cli-ref/v0/route-table/remove-labels.md)

 - [update](cli-ref/v0/route-table/update.md)

#### security-group

 - [Overview](cli-ref/v0/security-group/index.md)

 - [add-labels](cli-ref/v0/security-group/add-labels.md)

 - [create](cli-ref/v0/security-group/create.md)

 - [delete](cli-ref/v0/security-group/delete.md)

 - [get](cli-ref/v0/security-group/get.md)

 - [list](cli-ref/v0/security-group/list.md)

 - [list-operations](cli-ref/v0/security-group/list-operations.md)

 - [move](cli-ref/v0/security-group/move.md)

 - [remove-labels](cli-ref/v0/security-group/remove-labels.md)

 - [update](cli-ref/v0/security-group/update.md)

 - [update-rule-meta](cli-ref/v0/security-group/update-rule-meta.md)

 - [update-rules](cli-ref/v0/security-group/update-rules.md)

#### subnet

 - [Overview](cli-ref/v0/subnet/index.md)

 - [add-labels](cli-ref/v0/subnet/add-labels.md)

 - [add-range](cli-ref/v0/subnet/add-range.md)

 - [create](cli-ref/v0/subnet/create.md)

 - [delete](cli-ref/v0/subnet/delete.md)

 - [get](cli-ref/v0/subnet/get.md)

 - [list](cli-ref/v0/subnet/list.md)

 - [list-operations](cli-ref/v0/subnet/list-operations.md)

 - [list-used-addresses](cli-ref/v0/subnet/list-used-addresses.md)

 - [move](cli-ref/v0/subnet/move.md)

 - [relocate](cli-ref/v0/subnet/relocate.md)

 - [remove-labels](cli-ref/v0/subnet/remove-labels.md)

 - [remove-range](cli-ref/v0/subnet/remove-range.md)

 - [update](cli-ref/v0/subnet/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Address

 - [Overview](api-ref/Address/index.md)

 - [Get](api-ref/Address/get.md)

 - [GetByValue](api-ref/Address/getByValue.md)

 - [List](api-ref/Address/list.md)

 - [ListBySubnet](api-ref/Address/listBySubnet.md)

 - [Create](api-ref/Address/create.md)

 - [Update](api-ref/Address/update.md)

 - [Delete](api-ref/Address/delete.md)

 - [ListOperations](api-ref/Address/listOperations.md)

 - [Move](api-ref/Address/move.md)

#### Gateway

 - [Overview](api-ref/Gateway/index.md)

 - [Get](api-ref/Gateway/get.md)

 - [List](api-ref/Gateway/list.md)

 - [Create](api-ref/Gateway/create.md)

 - [Update](api-ref/Gateway/update.md)

 - [Delete](api-ref/Gateway/delete.md)

 - [ListOperations](api-ref/Gateway/listOperations.md)

 - [Move](api-ref/Gateway/move.md)

#### Network

 - [Overview](api-ref/Network/index.md)

 - [Get](api-ref/Network/get.md)

 - [List](api-ref/Network/list.md)

 - [Create](api-ref/Network/create.md)

 - [Update](api-ref/Network/update.md)

 - [Delete](api-ref/Network/delete.md)

 - [ListSubnets](api-ref/Network/listSubnets.md)

 - [ListSecurityGroups](api-ref/Network/listSecurityGroups.md)

 - [ListRouteTables](api-ref/Network/listRouteTables.md)

 - [ListOperations](api-ref/Network/listOperations.md)

 - [Move](api-ref/Network/move.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### RouteTable

 - [Overview](api-ref/RouteTable/index.md)

 - [Get](api-ref/RouteTable/get.md)

 - [List](api-ref/RouteTable/list.md)

 - [Create](api-ref/RouteTable/create.md)

 - [Update](api-ref/RouteTable/update.md)

 - [Delete](api-ref/RouteTable/delete.md)

 - [ListOperations](api-ref/RouteTable/listOperations.md)

 - [Move](api-ref/RouteTable/move.md)

#### SecurityGroup

 - [Overview](api-ref/SecurityGroup/index.md)

 - [Get](api-ref/SecurityGroup/get.md)

 - [List](api-ref/SecurityGroup/list.md)

 - [Create](api-ref/SecurityGroup/create.md)

 - [Update](api-ref/SecurityGroup/update.md)

 - [UpdateRules](api-ref/SecurityGroup/updateRules.md)

 - [UpdateRule](api-ref/SecurityGroup/updateRule.md)

 - [Delete](api-ref/SecurityGroup/delete.md)

 - [Move](api-ref/SecurityGroup/move.md)

 - [ListOperations](api-ref/SecurityGroup/listOperations.md)

#### Subnet

 - [Overview](api-ref/Subnet/index.md)

 - [Get](api-ref/Subnet/get.md)

 - [List](api-ref/Subnet/list.md)

 - [Create](api-ref/Subnet/create.md)

 - [Update](api-ref/Subnet/update.md)

 - [AddCidrBlocks](api-ref/Subnet/addCidrBlocks.md)

 - [RemoveCidrBlocks](api-ref/Subnet/removeCidrBlocks.md)

 - [Relocate](api-ref/Subnet/relocate.md)

 - [Delete](api-ref/Subnet/delete.md)

 - [ListOperations](api-ref/Subnet/listOperations.md)

 - [Move](api-ref/Subnet/move.md)

 - [ListUsedAddresses](api-ref/Subnet/listUsedAddresses.md)

#### Virtual Private Cloud API

 - [Overview](privatelink/api-ref/index.md)

##### Operation

 - [Overview](privatelink/api-ref/Operation/index.md)

 - [Get](privatelink/api-ref/Operation/get.md)

 - [Cancel](privatelink/api-ref/Operation/cancel.md)

##### PrivateEndpoint

 - [Overview](privatelink/api-ref/PrivateEndpoint/index.md)

 - [Get](privatelink/api-ref/PrivateEndpoint/get.md)

 - [List](privatelink/api-ref/PrivateEndpoint/list.md)

 - [Create](privatelink/api-ref/PrivateEndpoint/create.md)

 - [Update](privatelink/api-ref/PrivateEndpoint/update.md)

 - [Delete](privatelink/api-ref/PrivateEndpoint/delete.md)

 - [ListOperations](privatelink/api-ref/PrivateEndpoint/listOperations.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Address

 - [Overview](api-ref/grpc/Address/index.md)

 - [Get](api-ref/grpc/Address/get.md)

 - [GetByValue](api-ref/grpc/Address/getByValue.md)

 - [List](api-ref/grpc/Address/list.md)

 - [ListBySubnet](api-ref/grpc/Address/listBySubnet.md)

 - [Create](api-ref/grpc/Address/create.md)

 - [Update](api-ref/grpc/Address/update.md)

 - [Delete](api-ref/grpc/Address/delete.md)

 - [ListOperations](api-ref/grpc/Address/listOperations.md)

 - [Move](api-ref/grpc/Address/move.md)

#### Gateway

 - [Overview](api-ref/grpc/Gateway/index.md)

 - [Get](api-ref/grpc/Gateway/get.md)

 - [List](api-ref/grpc/Gateway/list.md)

 - [Create](api-ref/grpc/Gateway/create.md)

 - [Update](api-ref/grpc/Gateway/update.md)

 - [Delete](api-ref/grpc/Gateway/delete.md)

 - [ListOperations](api-ref/grpc/Gateway/listOperations.md)

 - [Move](api-ref/grpc/Gateway/move.md)

#### Network

 - [Overview](api-ref/grpc/Network/index.md)

 - [Get](api-ref/grpc/Network/get.md)

 - [List](api-ref/grpc/Network/list.md)

 - [Create](api-ref/grpc/Network/create.md)

 - [Update](api-ref/grpc/Network/update.md)

 - [Delete](api-ref/grpc/Network/delete.md)

 - [ListSubnets](api-ref/grpc/Network/listSubnets.md)

 - [ListSecurityGroups](api-ref/grpc/Network/listSecurityGroups.md)

 - [ListRouteTables](api-ref/grpc/Network/listRouteTables.md)

 - [ListOperations](api-ref/grpc/Network/listOperations.md)

 - [Move](api-ref/grpc/Network/move.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### RouteTable

 - [Overview](api-ref/grpc/RouteTable/index.md)

 - [Get](api-ref/grpc/RouteTable/get.md)

 - [List](api-ref/grpc/RouteTable/list.md)

 - [Create](api-ref/grpc/RouteTable/create.md)

 - [Update](api-ref/grpc/RouteTable/update.md)

 - [Delete](api-ref/grpc/RouteTable/delete.md)

 - [ListOperations](api-ref/grpc/RouteTable/listOperations.md)

 - [Move](api-ref/grpc/RouteTable/move.md)

#### SecurityGroup

 - [Overview](api-ref/grpc/SecurityGroup/index.md)

 - [Get](api-ref/grpc/SecurityGroup/get.md)

 - [List](api-ref/grpc/SecurityGroup/list.md)

 - [Create](api-ref/grpc/SecurityGroup/create.md)

 - [Update](api-ref/grpc/SecurityGroup/update.md)

 - [UpdateRules](api-ref/grpc/SecurityGroup/updateRules.md)

 - [UpdateRule](api-ref/grpc/SecurityGroup/updateRule.md)

 - [Delete](api-ref/grpc/SecurityGroup/delete.md)

 - [Move](api-ref/grpc/SecurityGroup/move.md)

 - [ListOperations](api-ref/grpc/SecurityGroup/listOperations.md)

#### Subnet

 - [Overview](api-ref/grpc/Subnet/index.md)

 - [Get](api-ref/grpc/Subnet/get.md)

 - [List](api-ref/grpc/Subnet/list.md)

 - [Create](api-ref/grpc/Subnet/create.md)

 - [Update](api-ref/grpc/Subnet/update.md)

 - [AddCidrBlocks](api-ref/grpc/Subnet/addCidrBlocks.md)

 - [RemoveCidrBlocks](api-ref/grpc/Subnet/removeCidrBlocks.md)

 - [Relocate](api-ref/grpc/Subnet/relocate.md)

 - [Delete](api-ref/grpc/Subnet/delete.md)

 - [ListOperations](api-ref/grpc/Subnet/listOperations.md)

 - [Move](api-ref/grpc/Subnet/move.md)

 - [ListUsedAddresses](api-ref/grpc/Subnet/listUsedAddresses.md)

#### Virtual Private Cloud API

 - [Overview](privatelink/api-ref/grpc/index.md)

##### Operation

 - [Overview](privatelink/api-ref/grpc/Operation/index.md)

 - [Get](privatelink/api-ref/grpc/Operation/get.md)

 - [Cancel](privatelink/api-ref/grpc/Operation/cancel.md)

##### PrivateEndpoint

 - [Overview](privatelink/api-ref/grpc/PrivateEndpoint/index.md)

 - [Get](privatelink/api-ref/grpc/PrivateEndpoint/get.md)

 - [List](privatelink/api-ref/grpc/PrivateEndpoint/list.md)

 - [Create](privatelink/api-ref/grpc/PrivateEndpoint/create.md)

 - [Update](privatelink/api-ref/grpc/PrivateEndpoint/update.md)

 - [Delete](privatelink/api-ref/grpc/PrivateEndpoint/delete.md)

 - [ListOperations](privatelink/api-ref/grpc/PrivateEndpoint/listOperations.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)